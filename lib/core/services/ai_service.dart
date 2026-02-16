import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../domain/entities/task.dart';
import '../../domain/entities/subject.dart';
import '../../domain/entities/user_profile.dart';
import '../../domain/entities/staff_subject_mapping.dart';

enum Priority { critical, high, medium, low }

enum TaskCategory { assignment, lab, study, examPrep, submission, other }

class TaskExtractionResult {
  final List<ExtractedTask> tasks;
  final String? rawResponse;
  final bool success;
  final String? error;
  final List<String>? suggestions;

  TaskExtractionResult({
    required this.tasks,
    this.rawResponse,
    required this.success,
    this.error,
    this.suggestions,
  });
}

class ExtractedTask {
  final String title;
  final Subject? subject;
  final DateTime? deadline;
  final Priority priority;
  final TaskCategory category;
  final String? specialInstructions;
  final String? rawText;

  ExtractedTask({
    required this.title,
    this.subject,
    this.deadline,
    required this.priority,
    required this.category,
    this.specialInstructions,
    this.rawText,
  });
}

class UserContext {
  final UserProfile profile;
  final List<Subject> subjects;
  final List<StaffSubjectMapping> staffMappings;
  final Map<int, String>? timetable;

  UserContext({
    required this.profile,
    required this.subjects,
    required this.staffMappings,
    this.timetable,
  });

  String generatePrompt() {
    final subjectList = subjects.map((s) => '- ${s.name}${s.code != null ? ' (${s.code})' : ''}').join('\n');
    
    final staffList = staffMappings.map((m) {
      final subject = subjects.firstWhere((s) => s.id == m.subjectId, orElse: () => Subject(name: '', semesterId: 0, color: 0));
      return '- ${m.staffName} → ${subject.name}';
    }).join('\n');

    return '''
You are an AI assistant for a college student. Extract actionable academic tasks from text.

Student Profile:
Name: ${profile.name}
Semester: ${profile.semester}
Department: ${profile.department}
Section: ${profile.section ?? 'N/A'}

Subjects this semester:
$subjectList

Staff → Subject Mapping:
$staffList

Your job is to:
1. Extract ALL actionable tasks from the text
2. Map tasks to the correct subject
3. Infer deadlines from context (use "next Monday", "this Friday", etc.)
4. Determine priority based on urgency and importance
5. Categorize the task type

Return ONLY valid JSON array in this exact format:
[
  {
    "title": "Complete assignment 3",
    "subject_name": "Digital Signal Processing",
    "deadline": "relative date like 'next Monday' or 'Feb 15'",
    "priority": "HIGH",
    "category": "ASSIGNMENT",
    "special_instructions": "Handwritten, questions 1-10"
  }
]

If there are NO actionable tasks, return: []

DO NOT include any explanation, just the JSON.
''';
  }
}

class AIService {
  final String _apiKey;
  late final UserContext _context;
  final List<ExtractedTask> _taskHistory = [];
  
  // Chat history for the session
  List<Map<String, dynamic>> _chatHistory = [];

  AIService(this._apiKey);

  void setContext(UserContext context) {
    _context = context;
    _initializeChatSession();
  }

  void _initializeChatSession() {
    final systemContext = '''
You are CampusBot, an intelligent academic assistant for ${_context.profile.name}, 
a ${_context.profile.department} student in semester ${_context.profile.semester}.

Your capabilities:
1. Extract tasks from any message (WhatsApp, email, verbal instructions)
2. Understand vague dates and calculate exact deadlines
3. Map tasks to correct subjects using context
4. Suggest task breakdowns for complex assignments
5. Provide study recommendations
6. Answer questions about academic workload
7. Clarify unclear instructions by asking smart follow-up questions

Student's subjects: ${_context.subjects.map((s) => s.name).join(', ')}

Be helpful, conversational, and proactive. If something is unclear, ask for clarification.
''';

    _chatHistory = [
      {'role': 'user', 'parts': [{'text': systemContext}]},
      {'role': 'model', 'parts': [{'text': 'I understand! I\'m here to help you manage your academic tasks intelligently. How can I assist you today?'}]}
    ];
  }

  /// Helper to call Gemini REST API
  Future<String?> _generateContent(String prompt, {bool isChat = false, double temperature = 0.3}) async {
    try {
      // Found available model: gemini-flash-latest
      print('Using AI Model: gemini-flash-latest with Key: ${_apiKey.substring(0, 4)}...');
      final url = Uri.parse(
          'https://generativelanguage.googleapis.com/v1beta/models/gemini-flash-latest:generateContent?key=$_apiKey');

      final headers = {'Content-Type': 'application/json'};
      
      List<Map<String, dynamic>> contents;
      
      if (isChat) {
        // For chat, send history + new prompt
        contents = List.from(_chatHistory);
        contents.add({
          'role': 'user',
          'parts': [{'text': prompt}]
        });
      } else {
        // For single-turn, just the prompt
        contents = [{
          'role': 'user',
          'parts': [{'text': prompt}]
        }];
      }

      final body = jsonEncode({
        "contents": contents,
        "generationConfig": {
          "temperature": temperature,
          "maxOutputTokens": 2048,
          "topP": 0.95,
          "topK": 40
        }
      });

      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final text = data['candidates']?[0]?['content']?['parts']?[0]?['text'];
        
        if (isChat && text != null) {
          _chatHistory.add({
            'role': 'user',
            'parts': [{'text': prompt}]
          });
          _chatHistory.add({
            'role': 'model',
            'parts': [{'text': text}]
          });
        }
        
        return text;
      } else {
        print('Gemini API Error: ${response.statusCode} - ${response.body}');
        return null;
      }
    } catch (e) {
      print('Network Error: $e');
      return null;
    }
  }

  /// REST API: Multi-turn conversation for clarification
  Future<String> chat(String userMessage) async {
    if (_chatHistory.isEmpty) _initializeChatSession();
    
    final response = await _generateContent(userMessage, isChat: true, temperature: 0.7);
    return response ?? 'Error: Unable to process your message. Please try again.';
  }

  /// REST API: Extract tasks from text
  Future<TaskExtractionResult> extractTasks(String userInput) async {
    try {
      final systemPrompt = _context.generatePrompt();
      
      final prompt = '''
$systemPrompt

User Input:
"""
$userInput
"""

Extract tasks as JSON:
''';

      final jsonResponse = await _generateContent(prompt, temperature: 0.3);
      
      if (jsonResponse == null) {
        return TaskExtractionResult(
          tasks: [],
          success: false,
          error: 'No response from AI',
        );
      }

      // Parse JSON response
      final jsonText = jsonResponse.trim();
      
      // Remove markdown code blocks if present
      String cleanJson = jsonText;
      if (jsonText.startsWith('```json')) {
        cleanJson = jsonText.substring(7, jsonText.lastIndexOf('```')).trim();
      } else if (jsonText.startsWith('```')) {
        cleanJson = jsonText.substring(3, jsonText.lastIndexOf('```')).trim();
      }

      final List<dynamic> taskList = jsonDecode(cleanJson);
      
      final extractedTasks = <ExtractedTask>[];
      for (var taskJson in taskList) {
        final subjectName = taskJson['subject_name'] as String?;
        final subject = subjectName != null
            ? _context.subjects.firstWhere(
                (s) => s.name.toLowerCase().contains(subjectName.toLowerCase()),
                orElse: () => _context.subjects.first,
              )
            : null;

        extractedTasks.add(ExtractedTask(
          title: taskJson['title'] as String,
          subject: subject,
          deadline: _parseDeadline(taskJson['deadline'] as String?),
          priority: _parsePriority(taskJson['priority'] as String?),
          category: _parseCategory(taskJson['category'] as String?),
          specialInstructions: taskJson['special_instructions'] as String?,
          rawText: userInput,
        ));
      }

      // Store in history for learning
      _taskHistory.addAll(extractedTasks);

      // REST API: Generate intelligent suggestions
      final suggestions = await _generateTaskSuggestions(extractedTasks);

      return TaskExtractionResult(
        tasks: extractedTasks,
        rawResponse: jsonResponse,
        success: true,
        suggestions: suggestions,
      );

    } catch (e) {
      return TaskExtractionResult(
        tasks: [],
        success: false,
        error: 'Error extracting tasks: $e',
        rawResponse: e.toString(),
      );
    }
  }

  /// REST API: Generate intelligent suggestions for extracted tasks
  Future<List<String>> _generateTaskSuggestions(List<ExtractedTask> tasks) async {
    if (tasks.isEmpty) return [];
    
    try {
      final taskSummary = tasks.map((t) => '- ${t.title} (${t.subject?.name ?? "Unknown"}) - Due: ${t.deadline?.toString().split(' ')[0] ?? "No deadline"}').join('\n');
      
      final prompt = '''
Based on these extracted tasks:
$taskSummary

Provide 2-3 brief, actionable suggestions to help the student succeed. Consider:
- Task breakdown if complex
- Time management tips
- Study approach recommendations
- Resource suggestions

Format: One suggestion per line, no numbering, max 15 words each.
''';

      final response = await _generateContent(prompt, temperature: 0.7);
      if (response == null) return [];
      
      return response.trim().split('\n').where((s) => s.isNotEmpty).take(3).toList();
    } catch (e) {
      return [];
    }
  }

  /// REST API: Break down complex tasks into subtasks
  Future<List<String>> suggestTaskBreakdown(ExtractedTask task) async {
    try {
      final prompt = '''
Break down this task into specific, actionable subtasks:
Task: ${task.title}
Subject: ${task.subject?.name ?? "General"}
Deadline: ${task.deadline?.toString().split(' ')[0] ?? "Not specified"}

Provide 3-5 concrete subtasks that would help complete this efficiently.
Format: One subtask per line, starting with action verbs, max 10 words each.
''';

      final response = await _generateContent(prompt, temperature: 0.7);
      if (response == null) return [];
      
      return response.trim().split('\n').where((s) => s.isNotEmpty).take(5).toList();
    } catch (e) {
      return [];
    }
  }

  /// REST API: Estimate time required for task
  Future<Duration?> estimateTaskDuration(ExtractedTask task) async {
    try {
      final prompt = '''
Estimate time needed for: "${task.title}" (${task.subject?.name ?? "General"})
Consider typical student workload for this type of task.

Respond with ONLY a number of hours (1-20). Example: 3
''';

      final response = await _generateContent(prompt, temperature: 0.7);
      if (response == null) return null;
      
      final hours = int.tryParse(response.trim());
      return hours != null ? Duration(hours: hours) : null;
    } catch (e) {
      return null;
    }
  }

  DateTime? _parseDeadline(String? deadlineText) {
    if (deadlineText == null || deadlineText.isEmpty) return null;

    final now = DateTime.now();
    final text = deadlineText.toLowerCase();

    // Relative dates
    if (text.contains('today')) {
      return DateTime(now.year, now.month, now.day, 23, 59);
    } else if (text.contains('tomorrow')) {
      final tomorrow = now.add(const Duration(days: 1));
      return DateTime(tomorrow.year, tomorrow.month, tomorrow.day, 23, 59);
    } else if (text.contains('next monday') || text.contains('this monday')) {
      return _getNextWeekday(DateTime.monday);
    } else if (text.contains('next friday') || text.contains('this friday')) {
      return _getNextWeekday(DateTime.friday);
    } else if (text.contains('next week')) {
      return now.add(const Duration(days: 7));
    } else if (text.contains('this week')) {
      return _getEndOfWeek();
    }

    // Try parsing absolute dates
    try {
      return DateTime.parse(deadlineText);
    } catch (e) {
      // If can't parse, default to next week
      return now.add(const Duration(days: 7));
    }
  }

  DateTime _getNextWeekday(int weekday) {
    final now = DateTime.now();
    int daysToAdd = weekday - now.weekday;
    if (daysToAdd <= 0) daysToAdd += 7;
    final target = now.add(Duration(days: daysToAdd));
    return DateTime(target.year, target.month, target.day, 23, 59);
  }

  DateTime _getEndOfWeek() {
    final now = DateTime.now();
    final daysToFriday = DateTime.friday - now.weekday;
    final friday = now.add(Duration(days: daysToFriday > 0 ? daysToFriday : 0));
    return DateTime(friday.year, friday.month, friday.day, 23, 59);
  }

  Priority _parsePriority(String? priorityText) {
    if (priorityText == null) return Priority.medium;
    
    switch (priorityText.toUpperCase()) {
      case 'CRITICAL':
        return Priority.critical;
      case 'HIGH':
        return Priority.high;
      case 'LOW':
        return Priority.low;
      default:
        return Priority.medium;
    }
  }

  TaskCategory _parseCategory(String? categoryText) {
    if (categoryText == null) return TaskCategory.other;
    
    switch (categoryText.toUpperCase()) {
      case 'ASSIGNMENT':
        return TaskCategory.assignment;
      case 'LAB':
        return TaskCategory.lab;
      case 'STUDY':
        return TaskCategory.study;
      case 'EXAM_PREP':
        return TaskCategory.examPrep;
      case 'SUBMISSION':
        return TaskCategory.submission;
      default:
        return TaskCategory.other;
    }
  }

  /// REST API: Map task text to subject using AI
  Future<Subject?> mapToSubject(String taskText) async {
    try {
      final subjectNames = _context.subjects.map((s) => s.name).toList();
      
      final prompt = '''
Given this task: "$taskText"
And these subjects: ${subjectNames.join(', ')}

Which subject does this task belong to? Respond with ONLY the exact subject name, nothing else.
''';

      final response = await _generateContent(prompt, temperature: 0.3);
      if (response == null) return null;

      final subjectName = response.trim();
      return _context.subjects.firstWhere(
        (s) => s.name.toLowerCase() == subjectName.toLowerCase(),
        orElse: () => _context.subjects.first,
      );

    } catch (e) {
      return null;
    }
  }

  /// REST API: Determine priority using AI
  Future<Priority> determinePriority(String taskText, DateTime? deadline) async {
    try {
      final daysUntilDeadline = deadline != null 
          ? deadline.difference(DateTime.now()).inDays
          : null;

      final prompt = '''
Rate the priority of this task: "$taskText"
${daysUntilDeadline != null ? 'Days until deadline: $daysUntilDeadline' : 'No specific deadline'}

Respond with ONLY one word: CRITICAL, HIGH, MEDIUM, or LOW
''';

      final response = await _generateContent(prompt, temperature: 0.3);
      return _parsePriority(response?.trim());

    } catch (e) {
      return Priority.medium;
    }
  }
}
