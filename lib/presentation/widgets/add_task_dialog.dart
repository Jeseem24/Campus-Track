import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../domain/entities/task.dart';
import '../../domain/providers/all_subjects_provider.dart';
import '../providers/task_provider.dart';

class AddTaskDialog extends ConsumerStatefulWidget {
  const AddTaskDialog({super.key});

  @override
  ConsumerState<AddTaskDialog> createState() => _AddTaskDialogState();
}

class _AddTaskDialogState extends ConsumerState<AddTaskDialog> {
  final _titleController = TextEditingController();
  TaskType _selectedType = TaskType.task;
  int? _selectedSubjectId;
  DateTime? _dueDate;

  @override
  Widget build(BuildContext context) {
    final subjectsAsync = ref.watch(allSubjectsProvider);

    return AlertDialog(
      title: const Text("New Item"),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Type Selection
            SegmentedButton<TaskType>(
              segments: const [
                ButtonSegment(value: TaskType.task, label: Text("Task"), icon: Icon(Icons.check_circle_outline)),
                ButtonSegment(value: TaskType.assignment, label: Text("Assignment"), icon: Icon(Icons.assignment_outlined)),
              ], 
              selected: {_selectedType},
              onSelectionChanged: (val) => setState(() => _selectedType = val.first),
            ),
            const SizedBox(height: 16),

            // 2. Title
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: "Title",
                border: OutlineInputBorder(),
                hintText: "e.g. Complete Lab Report"
              ),
              autofocus: true,
            ),
            const SizedBox(height: 16),

            // 3. Subject (Optional)
            subjectsAsync.when(
              data: (subjects) => DropdownButtonFormField<int>(
                value: _selectedSubjectId,
                isExpanded: true, // Fixes constraint issues
                decoration: const InputDecoration(labelText: "Subject (Optional)", border: OutlineInputBorder()),
                items: subjects.map((s) => DropdownMenuItem(
                  value: s.id,
                  child: Row(
                    children: [
                      CircleAvatar(backgroundColor: Color(s.color), radius: 8),
                      const SizedBox(width: 8),
                      Expanded( // Use Expanded safely now that isExpanded=true
                        child: Text(
                          "${s.name} (${s.code ?? '?'})", 
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                    ],
                  ),
                )).toList(),
                onChanged: (val) => setState(() => _selectedSubjectId = val),
              ),
              loading: () => const LinearProgressIndicator(), 
              error: (_,__) => const SizedBox(),
            ),
            const SizedBox(height: 16),
            
            // 4. Due Date
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    icon: const Icon(Icons.calendar_today),
                    label: Text(_dueDate == null ? "Set Due Date" : DateFormat('MMM d, y').format(_dueDate!)),
                    onPressed: () async {
                      final picked = await showDatePicker(
                        context: context, 
                        initialDate: DateTime.now(), 
                        firstDate: DateTime.now().subtract(const Duration(days: 365)), 
                        lastDate: DateTime.now().add(const Duration(days: 365))
                      );
                      if (picked != null) setState(() => _dueDate = picked);
                    },
                  ),
                ),
                if (_dueDate != null)
                  IconButton(
                    icon: const Icon(Icons.clear), 
                    onPressed: () => setState(() => _dueDate = null)
                  )
              ],
            )
          ],
        ),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancel")),
        FilledButton(
          onPressed: () {
            if (_titleController.text.isEmpty) return;
            
            final task = Task(
              title: _titleController.text,
              type: _selectedType,
              subjectId: _selectedSubjectId,
              dueDate: _dueDate?.millisecondsSinceEpoch,
              isCompleted: false,
            );
            
            ref.read(taskListProvider.notifier).addTask(task);
            Navigator.pop(context);
          }, 
          child: const Text("Create"),
        ),
      ],
    );
  }
}
