import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../../core/services/ai_study_assistant.dart';
import '../../domain/entities/task.dart';
import '../../domain/entities/subject.dart';

/// Widget showing AI-powered study recommendation
class AIStudyRecommendationCard extends ConsumerStatefulWidget {
  final List<Task> pendingTasks;
  final List<Subject> subjects;
  final Map<Subject, double> attendancePercentages;

  const AIStudyRecommendationCard({
    super.key,
    required this.pendingTasks,
    required this.subjects,
    required this.attendancePercentages,
  });

  @override
  ConsumerState<AIStudyRecommendationCard> createState() =>
      _AIStudyRecommendationCardState();
}

class _AIStudyRecommendationCardState
    extends ConsumerState<AIStudyRecommendationCard> {
  String? _recommendation;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadRecommendation();
  }

  Future<void> _loadRecommendation() async {
    setState(() => _isLoading = true);

    try {
      final apiKey = dotenv.env['GEMINI_API_KEY'] ?? '';
      if (apiKey.isEmpty) return;

      final assistant = AIStudyAssistant(apiKey);
      final recommendation = await assistant.getStudyRecommendation(
        subjects: widget.subjects,
        attendancePercentages: widget.attendancePercentages,
        pendingTasks: widget.pendingTasks,
      );

      if (mounted) {
        setState(() {
          _recommendation = recommendation;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _recommendation = '✅ Keep up the good work!';
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Card(
        margin: const EdgeInsets.all(16),
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.purple.shade400, Colors.deepPurple.shade600],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          child: const Row(
            children: [
              CircularProgressIndicator(color: Colors.white),
              SizedBox(width: 16),
              Text(
                'Getting AI recommendation...',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      );
    }

    if (_recommendation == null) return const SizedBox.shrink();

    return Card(
      margin: const EdgeInsets.all(16),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.purple.shade400, Colors.deepPurple.shade600],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.auto_awesome, color: Colors.white, size: 28),
                SizedBox(width: 12),
                Text(
                  'AI Recommendation',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              _recommendation!,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              onPressed: _loadRecommendation,
              icon: const Icon(Icons.refresh, size: 18),
              label: const Text('Refresh'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.deepPurple,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Widget showing priority tasks
class PriorityTasksWidget extends ConsumerStatefulWidget {
  final List<Task> tasks;

  const PriorityTasksWidget({super.key, required this.tasks});

  @override
  ConsumerState<PriorityTasksWidget> createState() =>
      _PriorityTasksWidgetState();
}

class _PriorityTasksWidgetState extends ConsumerState<PriorityTasksWidget> {
  List<Task> _rankedTasks = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _rankTasks();
  }

  Future<void> _rankTasks() async {
    if (widget.tasks.isEmpty) return;

    setState(() => _isLoading = true);

    try {
      final apiKey = dotenv.env['GEMINI_API_KEY'] ?? '';
      if (apiKey.isEmpty) {
        setState(() {
          _rankedTasks = widget.tasks;
          _isLoading = false;
        });
        return;
      }

      final assistant = AIStudyAssistant(apiKey);
      final ranked = await assistant.rankTasks(widget.tasks);

      if (mounted) {
        setState(() {
          _rankedTasks = ranked.take(5).toList(); // Top 5 priority tasks
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _rankedTasks = widget.tasks.take(5).toList();
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Card(
        margin: EdgeInsets.all(16),
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Center(child: CircularProgressIndicator()),
        ),
      );
    }

    if (_rankedTasks.isEmpty) return const SizedBox.shrink();

    return Card(
      margin: const EdgeInsets.all(16),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.priority_high, color: Colors.orange),
                SizedBox(width: 8),
                Text(
                  'Priority Tasks',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            ..._rankedTasks.asMap().entries.map((entry) {
              final index = entry.key;
              final task = entry.value;
              final deadline = task.dueDate != null
                  ? DateTime.fromMillisecondsSinceEpoch(task.dueDate!)
                  : null;

              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Priority number
                    Container(
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                        color: _getPriorityColor(index),
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          '${index + 1}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    // Task info
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            task.title,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          if (deadline != null) ...[
                            const SizedBox(height: 4),
                            Text(
                              'Due: ${deadline.toString().split(' ')[0]}',
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  Color _getPriorityColor(int index) {
    switch (index) {
      case 0:
        return Colors.red;
      case 1:
        return Colors.orange;
      case 2:
        return Colors.amber;
      default:
        return Colors.blue;
    }
  }
}
