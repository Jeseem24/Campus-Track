import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../../core/services/ai_service.dart';
import '../../core/services/notification_service.dart';
import '../../data/repositories/task_repository.dart';
import '../../data/repositories/subject_repository_impl.dart';
import '../../domain/entities/task.dart';
import '../../domain/entities/user_profile.dart';
import '../../main.dart';

class AIAssistantScreen extends ConsumerStatefulWidget {
  const AIAssistantScreen({super.key});

  @override
  ConsumerState<AIAssistantScreen> createState() => _AIAssistantScreenState();
}

class _AIAssistantScreenState extends ConsumerState<AIAssistantScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<ExtractedTask> _extractedTasks = [];
  List<String> _suggestions = []; // ADVANCED: Store AI suggestions
  bool _isProcessing = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    
    // Check for shared text after first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final sharedText = ref.read(sharedTextProvider);
      if (sharedText != null && sharedText.isNotEmpty) {
        setState(() {
          _controller.text = sharedText;
        });
        // Clear the shared text
        ref.read(sharedTextProvider.notifier).state = null;
        // Show snackbar
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('📱 Message received from WhatsApp! Tap "Extract Tasks" to analyze.'),
            duration: Duration(seconds: 4),
            backgroundColor: Colors.green,
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _extractTasks() async {
    if (_controller.text.trim().isEmpty) return;

    setState(() {
      _isProcessing = true;
      _errorMessage = null;
      _extractedTasks.clear();
      _suggestions.clear();
    });

    try {
      // Get API key from environment
      final apiKey = dotenv.env['GEMINI_API_KEY'] ?? '';
      if (apiKey.isEmpty) {
        throw Exception('API key not configured');
      }

      // Initialize AI service
      final aiService = AIService(apiKey);
      
      // Get subjects and create context
      final subjectRepo = ref.read(subjectRepositoryProvider);
      final subjects = await subjectRepo.getSubjectsForSemester(1);
      
      // TODO: Get actual user profile and staff mappings from database
      // For now, using a basic context
      final context = UserContext(
        profile: UserProfile(
          name: 'Student',
          semester: 5,
          department: 'IT',
        ),
        subjects: subjects,
        staffMappings: [], // Add staff mappings when available
      );
      
      aiService.setContext(context);

      // Extract tasks
      final result = await aiService.extractTasks(_controller.text);
      
      if (!result.success) {
        throw Exception('${result.error ?? 'Failed to extract tasks'}\n(Key: ${apiKey.substring(0, 4)}...)');
      }

      setState(() {
        _extractedTasks.addAll(result.tasks);
        _suggestions = result.suggestions ?? [];
        _isProcessing = false;
      });
    } catch (e) {
      final apiKey = dotenv.env['GEMINI_API_KEY'] ?? '';
      final keySnippet = apiKey.isNotEmpty ? apiKey.substring(0, 4) : 'NONE';
      setState(() {
        _errorMessage = 'Error: $e\nUsing Key: $keySnippet...';
        _isProcessing = false;
      });
    }
  }

  Future<void> _saveTask(ExtractedTask extractedTask) async {
    try {
      final taskRepo = ref.read(taskRepositoryProvider);
      final notificationService = NotificationService();

      final task = Task(
        title: extractedTask.title,
        type: TaskType.task,
        dueDate: extractedTask.deadline?.millisecondsSinceEpoch,
        isCompleted: false,
        subjectId: extractedTask.subject?.id,
      );

      await taskRepo.createTask(task);
      
      // Schedule notification if has deadline
      if (task.dueDate != null) {
        await notificationService.scheduleAssignmentReminder(
          task,
          DateTime.fromMillisecondsSinceEpoch(task.dueDate!),
        );
      }

      setState(() {
        _extractedTasks.remove(extractedTask);
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Task saved successfully!')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error saving task: $e')),
        );
      }
    }
  }

  Future<void> _breakDownTask(ExtractedTask task) async {
    // Show loading dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (c) => const Center(child: CircularProgressIndicator()),
    );

    try {
      final apiKey = dotenv.env['GEMINI_API_KEY'] ?? '';
      final aiService = AIService(apiKey);
      
      // Get subjects and create context
      final subjectRepo = ref.read(subjectRepositoryProvider);
      final subjects = await subjectRepo.getSubjectsForSemester(1);
      
      final context = UserContext(
        profile: UserProfile(name: 'Student', semester: 5, department: 'IT'),
        subjects: subjects,
        staffMappings: [],
      );
      aiService.setContext(context);

      final subtasks = await aiService.suggestTaskBreakdown(task);
      
      if (mounted) {
        Navigator.pop(this.context); // Close loading
        
        // Show subtasks dialog
        showDialog(
          context: this.context,
          builder: (c) => AlertDialog(
            title: Text('📋 Breakdown: ${task.title}'),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: subtasks.map((s) => Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(Icons.check_circle_outline, size: 16, color: Colors.deepPurple),
                      const SizedBox(width: 8),
                      Expanded(child: Text(s)),
                    ],
                  ),
                )).toList(),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(c),
                child: const Text('Close'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(c);
                  ScaffoldMessenger.of(this.context).showSnackBar(
                    const SnackBar(content: Text('Feature coming soon: Add subtasks automatically!')),
                  );
                },
                child: const Text('Add All'),
              ),
            ],
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        Navigator.pop(this.context);
        ScaffoldMessenger.of(this.context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
  }

  Future<void> _estimateTime(ExtractedTask task) async {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('⏱️ Estimating time...'), duration: Duration(seconds: 1)),
    );

    try {
      final apiKey = dotenv.env['GEMINI_API_KEY'] ?? '';
      final aiService = AIService(apiKey);
      
      final subjectRepo = ref.read(subjectRepositoryProvider);
      final subjects = await subjectRepo.getSubjectsForSemester(1);
      
      final context = UserContext(
        profile: UserProfile(name: 'Student', semester: 5, department: 'IT'),
        subjects: subjects,
        staffMappings: [],
      );
      aiService.setContext(context);

      final duration = await aiService.estimateTaskDuration(task);
      
      if (mounted) {
        if (duration != null) {
          showDialog(
            context: this.context,
            builder: (c) => AlertDialog(
              title: const Text('⏱️ Time Estimate'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.timer, size: 48, color: Colors.deepPurple),
                  const SizedBox(height: 16),
                  Text(
                    '${duration.inHours} Hours',
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'AI estimated based on task complexity and subject.',
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(c),
                  child: const Text('OK'),
                ),
              ],
            ),
          );
        } else {
          ScaffoldMessenger.of(this.context).showSnackBar(
            const SnackBar(content: Text('Could not estimate time.')),
          );
        }
      }
    } catch (e) {
      // Ignore errors
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🤖 AI Assistant'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Column(
        children: [
          // Top section - scrollable to handle keyboard
          Flexible(
            flex: 1,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Instructions card
                  Container(
                    margin: const EdgeInsets.all(16),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.deepPurple.shade50,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.deepPurple.shade200),
                    ),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '📝 How to use:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          '1. Paste any message (WhatsApp, classroom post, etc.)\n'
                          '2. Tap "Extract Tasks" to let AI analyze it\n'
                          '3. Review and save the extracted tasks',
                          style: TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                  ),

                  // Input section
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: TextField(
                      controller: _controller,
                      maxLines: 6,
                      decoration: InputDecoration(
                        hintText: 'Paste your message here...\n\n'
                            'Example:\n'
                            'Prof. Kumar: Complete DSP assignment 3, questions 1-10. '
                            'Submit next Monday, handwritten.',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        filled: true,
                        fillColor: Colors.grey.shade50,
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Extract button
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: _isProcessing ? null : _extractTasks,
                        icon: _isProcessing
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                ),
                              )
                            : const Icon(Icons.auto_awesome),
                        label: Text(_isProcessing ? 'Processing...' : 'Extract Tasks'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepPurple,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Error message
                  if (_errorMessage != null)
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.red.shade50,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.red.shade200),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.error_outline, color: Colors.red),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                _errorMessage!,
                                style: const TextStyle(color: Colors.red),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                  // AI Suggestions
                  if (_suggestions.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.amber.shade50,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.amber.shade200),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Row(
                              children: [
                                Icon(Icons.lightbulb, color: Colors.amber, size: 20),
                                SizedBox(width: 8),
                                Text(
                                  '💡 AI Insights',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Colors.amber,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            ..._suggestions.map((s) => Padding(
                              padding: const EdgeInsets.only(bottom: 4),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('• ', style: TextStyle(fontWeight: FontWeight.bold)),
                                  Expanded(child: Text(s, style: TextStyle(color: Colors.brown.shade900))),
                                ],
                              ),
                            )),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),

          // Extracted tasks list
          if (_extractedTasks.isNotEmpty)
            Expanded(
              flex: 2,
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: _extractedTasks.length,
                itemBuilder: (context, index) {
                  final task = _extractedTasks[index];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 12),
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Title
                          Text(
                            task.title,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),

                          // Subject
                          if (task.subject != null)
                            Row(
                              children: [
                                const Icon(Icons.book, size: 16),
                                const SizedBox(width: 4),
                                Text(
                                  task.subject!.name,
                                  style: TextStyle(
                                    color: Colors.grey.shade700,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),

                          // Deadline
                          if (task.deadline != null) ...[
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                const Icon(Icons.calendar_today, size: 16),
                                const SizedBox(width: 4),
                                Text(
                                  'Due: ${task.deadline!.toString().split(' ')[0]}',
                                  style: TextStyle(
                                    color: Colors.grey.shade700,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ],

                          // Priority
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              const Icon(Icons.flag, size: 16),
                              const SizedBox(width: 4),
                              Text(
                                'Priority: ${task.priority.name.toUpperCase()}',
                                style: TextStyle(
                                  color: _getPriorityColor(task.priority),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),

                          // Special instructions
                          if (task.specialInstructions != null) ...[
                            const SizedBox(height: 8),
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.blue.shade50,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                task.specialInstructions!,
                                style: const TextStyle(fontSize: 13),
                              ),
                            ),
                          ],

                          const SizedBox(height: 12),

                          // Advanced Actions
                          Row(
                            children: [
                              Expanded(
                                child: OutlinedButton.icon(
                                  onPressed: () => _breakDownTask(task),
                                  icon: const Icon(Icons.list_alt, size: 16),
                                  label: const Text('Break Down', style: TextStyle(fontSize: 12)),
                                  style: OutlinedButton.styleFrom(
                                    foregroundColor: Colors.deepPurple,
                                    side: const BorderSide(color: Colors.deepPurple),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: OutlinedButton.icon(
                                  onPressed: () => _estimateTime(task),
                                  icon: const Icon(Icons.timer_outlined, size: 16),
                                  label: const Text('Estimate Time', style: TextStyle(fontSize: 12)),
                                  style: OutlinedButton.styleFrom(
                                    foregroundColor: Colors.deepPurple,
                                    side: const BorderSide(color: Colors.deepPurple),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),

                          // Save button
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton.icon(
                              onPressed: () => _saveTask(task),
                              icon: const Icon(Icons.save, size: 18),
                              label: const Text('Save Task'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }

  Color _getPriorityColor(Priority priority) {
    switch (priority) {
      case Priority.critical:
        return Colors.red;
      case Priority.high:
        return Colors.orange;
      case Priority.medium:
        return Colors.blue;
      case Priority.low:
        return Colors.green;
    }
  }
}
