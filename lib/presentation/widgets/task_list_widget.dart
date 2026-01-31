import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../providers/task_provider.dart';
import '../../domain/providers/all_subjects_provider.dart';
import '../../domain/entities/task.dart';

class TaskListWidget extends ConsumerWidget {
  const TaskListWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasksAsync = ref.watch(taskListProvider);
    final subjectsAsync = ref.watch(allSubjectsProvider);
    final subjects = subjectsAsync.valueOrNull ?? [];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Pending Tasks", style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 8),
        tasksAsync.when(
          data: (tasks) {
            if (tasks.isEmpty) {
              return Container(
                padding: const EdgeInsets.all(24),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: const Text("All caught up! 🎉", style: TextStyle(color: Colors.grey)),
              );
            }
            return ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: tasks.length,
              separatorBuilder: (c, i) => const Divider(height: 1),
              itemBuilder: (context, index) {
                final task = tasks[index];
                
                // Find Subject
                final subject = (task.subjectId != null && subjects.isNotEmpty)
                    ? subjects.firstWhere((s) => s.id == task.subjectId, orElse: () => subjects.first) // Fallback safe
                    : null;
                // Actually fallback is risky, better nullable:
                final realSubject = (task.subjectId != null) 
                  ? subjects.where((s) => s.id == task.subjectId).firstOrNull 
                  : null;

                return ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Checkbox(
                    value: task.isCompleted,
                    shape: const CircleBorder(),
                    onChanged: (_) {
                      ref.read(taskListProvider.notifier).toggleTask(task);
                    },
                  ),
                  title: Text(
                    task.title,
                    style: TextStyle(
                      decoration: task.isCompleted ? TextDecoration.lineThrough : null,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  subtitle: Row(
                    children: [
                      // Badge for Type
                      if (task.type == TaskType.assignment)
                        Container(
                          margin: const EdgeInsets.only(right: 8),
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: Colors.purple.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(color: Colors.purple.withOpacity(0.3)),
                          ),
                          child: const Text("ASSGN", style: TextStyle(fontSize: 10, color: Colors.purple, fontWeight: FontWeight.bold)),
                        ),
                      
                      // Subject Dot & Name
                      if (realSubject != null) ...[
                        CircleAvatar(backgroundColor: Color(realSubject.color), radius: 4),
                        const SizedBox(width: 4),
                        Flexible(
                          child: Text(
                            "${realSubject.name} (${realSubject.code ?? '?'})", 
                            style: const TextStyle(fontSize: 12),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: 8),
                      ],
                      
                      // Due Date (Always visible if possible, or moves to next line? Row doesn't wrap. 
                      // If we want date to stick, we shouldn't use Flexible on it, but on the name.)
                      if (task.dueDate != null) ...[
                        const Icon(Icons.calendar_today, size: 12, color: Colors.grey),
                        const SizedBox(width: 4),
                        Text(
                          DateFormat('MMM d').format(DateTime.fromMillisecondsSinceEpoch(task.dueDate!)),
                          style: TextStyle(fontSize: 12, color: DateTime.now().millisecondsSinceEpoch > task.dueDate! ? Colors.red : Colors.grey),
                        ),
                      ]
                    ],
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete_outline, size: 18, color: Colors.grey),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (c) => AlertDialog(
                          title: const Text("Delete Task?"),
                          content: Text("Are you sure you want to delete '${task.title}'?"),
                          actions: [
                            TextButton(onPressed: () => Navigator.pop(c), child: const Text("Cancel")),
                            TextButton(
                              onPressed: () {
                                ref.read(taskListProvider.notifier).deleteTask(task.id!);
                                Navigator.pop(c);
                              },
                              child: const Text("Delete", style: TextStyle(color: Colors.red)),
                            )
                          ],
                        )
                      );
                    },
                  ),
                );
              },
            );
          },
          loading: () => const LinearProgressIndicator(),
          error: (err, stack) => Text("Error: $err"),
        )
      ],
    );
  }
}
