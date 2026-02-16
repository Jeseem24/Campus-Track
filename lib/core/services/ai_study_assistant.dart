import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../domain/entities/task.dart';
import '../../domain/entities/subject.dart';
import '../../domain/entities/exam.dart';
import '../services/ai_service.dart';

class StudyPlan {
  final DateTime date;
  final List<StudyBlock> blocks;
  final String recommendation;
  
  StudyPlan({
    required this.date,
    required this.blocks,
    required this.recommendation,
  });
}

class StudyBlock {
  final Subject subject;
  final Duration duration;
  final String reason;
  final int priority;
  
  StudyBlock({
    required this.subject,
    required this.duration,
    required this.reason,
    required this.priority,
  });
}

class WorkloadAlert {
  final DateTime date;
  final String severity; // 'HIGH', 'MEDIUM', 'LOW'
  final String message;
  final List<String> suggestions;
  
  WorkloadAlert({
    required this.date,
    required this.severity,
    required this.message,
    required this.suggestions,
  });
}

class AIStudyAssistant {
  final String _apiKey;
  
  AIStudyAssistant(this._apiKey);

  /// Helper to call Gemini REST API
  Future<String?> _generateContent(String prompt, {double temperature = 0.7}) async {
    try {
      final url = Uri.parse(
        'https://generativelanguage.googleapis.com/v1beta/models/gemini-flash-latest:generateContent?key=$_apiKey');

      final headers = {'Content-Type': 'application/json'};
      
      final body = jsonEncode({
        "contents": [{
          'role': 'user',
          'parts': [{'text': prompt}]
        }],
        "generationConfig": {
          "temperature": temperature,
          "maxOutputTokens": 1024,
        }
      });

      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['candidates']?[0]?['content']?['parts']?[0]?['text'];
      } else {
        print('Gemini API Error: ${response.statusCode} - ${response.body}');
        return null;
      }
    } catch (e) {
      print('Network Error: $e');
      return null;
    }
  }

  /// Generate study plan for the week
  Future<StudyPlan> generateStudyPlan({
    required List<Task> pendingTasks,
    required Map<Subject, double> attendancePercentages,
    required List<Exam> upcomingExams,
    required int availableHoursPerDay,
  }) async {
    // Build context
    final taskSummary = pendingTasks.map((t) => 
      '- ${t.title} (Due: ${t.dueDate != null ? DateTime.fromMillisecondsSinceEpoch(t.dueDate!).toString() : "No deadline"})'
    ).join('\n');
    
    final attendanceSummary = attendancePercentages.entries.map((e) =>
      '- ${e.key.name}: ${e.value.toStringAsFixed(1)}%'
    ).join('\n');
    
    final examSummary = upcomingExams.map((e) =>
      '- ${e.title} on ${DateTime.fromMillisecondsSinceEpoch(e.date).toString().split(' ')[0]}'
    ).join('\n');

    final prompt = '''
You are an AI study counselor. Create a study plan.

Pending Tasks:
$taskSummary

Attendance:
$attendanceSummary

Upcoming Exams:
$examSummary

Available study time: $availableHoursPerDay hours/day

Provide a recommendation focusing on:
1. Subjects with low attendance (need catch-up)
2. Upcoming exam preparation
3. Urgent task deadlines

Keep it concise and actionable.
''';

    try {
      final responseText = await _generateContent(prompt);
      
      return StudyPlan(
        date: DateTime.now(),
        blocks: [], // Simplified for now
        recommendation: responseText ?? 'Focus on pending tasks and exam prep.',
      );
    } catch (e) {
      return StudyPlan(
        date: DateTime.now(),
        blocks: [],
        recommendation: 'Complete urgent tasks first, then study for upcoming exams.',
      );
    }
  }

  /// Rank tasks by priority using AI
  Future<List<Task>> rankTasks(List<Task> tasks) async {
    if (tasks.isEmpty) return tasks;

    // Calculate urgency scores
    final now = DateTime.now();
    final scoredTasks = tasks.map((task) {
      int urgencyScore = 50; // Base score
      
      // Deadline urgency
      if (task.dueDate != null) {
        final deadline = DateTime.fromMillisecondsSinceEpoch(task.dueDate!);
        final daysUntil = deadline.difference(now).inDays;
        
        if (daysUntil < 0) {
          urgencyScore += 50; // Overdue!
        } else if (daysUntil == 0) {
          urgencyScore += 40; // Due today
        } else if (daysUntil == 1) {
          urgencyScore += 30; // Due tomorrow
        } else if (daysUntil <= 3) {
          urgencyScore += 20; // Due within 3 days
        } else if (daysUntil <= 7) {
          urgencyScore += 10; // Due this week
        }
      }
      
      // Task type weight
      if (task.type.toUpperCase().contains('EXAM')) {
        urgencyScore += 15;
      } else if (task.type.toUpperCase().contains('ASSIGNMENT')) {
        urgencyScore += 10;
      } else if (task.type.toUpperCase().contains('LAB')) {
        urgencyScore += 8;
      }
      
      return MapEntry(task, urgencyScore);
    }).toList();

    // Sort by score (highest first)
    scoredTasks.sort((a, b) => b.value.compareTo(a.value));
    
    return scoredTasks.map((e) => e.key).toList();
  }

  /// Analyze workload for a specific date
  Future<WorkloadAlert?> analyzeWorkload(
    DateTime date,
    List<Task> tasksOnDate,
    List<Exam> examsOnDate,
  ) async {
    final taskCount = tasksOnDate.length;
    final examCount = examsOnDate.length;
    
    // High workload thresholds
    if (examCount >= 2) {
      return WorkloadAlert(
        date: date,
        severity: 'HIGH',
        message: 'You have $examCount exams on the same day!',
        suggestions: [
          'Start preparing at least 2 weeks in advance',
          'Create dedicated study blocks for each exam',
          'Consider requesting exam reschedule if possible',
        ],
      );
    }
    
    if (taskCount >= 5) {
      return WorkloadAlert(
        date: date,
        severity: 'HIGH',
        message: 'You have $taskCount tasks due on the same day!',
        suggestions: [
          'Try to complete some tasks early',
          'Prioritize the most important/graded tasks',
          'Ask for extensions if needed',
        ],
      );
    }
    
    if (taskCount >= 3 && examCount >= 1) {
      return WorkloadAlert(
        date: date,
        severity: 'MEDIUM',
        message: 'Busy day ahead: $taskCount tasks + $examCount exam',
        suggestions: [
          'Focus on exam preparation first',
          'Complete quick tasks today',
          'Defer non-urgent tasks if possible',
        ],
      );
    }
    
    if (taskCount >= 3) {
      return WorkloadAlert(
        date: date,
        severity: 'MEDIUM',
        message: '$taskCount tasks due - plan ahead',
        suggestions: [
          'Start working on tasks early',
          'Break down large tasks into smaller steps',
        ],
      );
    }
    
    return null; // No alert needed
  }

  /// Generate personalized study recommendation
  Future<String> getStudyRecommendation({
    required List<Subject> subjects,
    required Map<Subject, double> attendancePercentages,
    required List<Task> pendingTasks,
  }) async {
    // Find subjects needing attention
    final lowAttendance = attendancePercentages.entries
        .where((e) => e.value < 75.0)
        .map((e) => e.key.name)
        .toList();
    
    final urgentTasks = pendingTasks.where((t) {
      if (t.dueDate == null) return false;
      final deadline = DateTime.fromMillisecondsSinceEpoch(t.dueDate!);
      return deadline.difference(DateTime.now()).inDays <= 3;
    }).toList();

    if (lowAttendance.isNotEmpty) {
      final subjects = lowAttendance.join(', ');
      return '⚠️ Attendance Alert: Your attendance in $subjects is below 75%. Attend upcoming classes!';
    }
    
    if (urgentTasks.isNotEmpty) {
      return '📅 You have ${urgentTasks.length} task(s) due within 3 days. Focus on these first!';
    }
    
    if (pendingTasks.length > 10) {
      return '📚 You have ${pendingTasks.length} pending tasks. Break them down and tackle them one by one.';
    }
    
    return '✅ You\'re on track! Keep up the good work and stay consistent with your studies.';
  }
}
