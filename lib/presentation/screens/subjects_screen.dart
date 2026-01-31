import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/subject_controller.dart';
import '../../domain/entities/subject.dart';
import 'package:go_router/go_router.dart';

class SubjectsScreen extends ConsumerWidget {
  const SubjectsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final subjectsAsync = ref.watch(subjectControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Manage Subjects"),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit_calendar),
            tooltip: "Edit Timetable",
            onPressed: () => context.push('/timetable-editor'),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showSubjectDialog(context, ref),
        icon: const Icon(Icons.add),
        label: const Text("Add Subject"),
      ),
      body: subjectsAsync.when(
        data: (subjects) {
           if (subjects.isEmpty) {
             return const Center(child: Text("No subjects added yet! Tap + to start."));
           }
           
           return ListView.builder(
             padding: const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 80), // Space for FAB
             itemCount: subjects.length,
             itemBuilder: (context, index) {
               final subject = subjects[index];
               return Card(
                 child: ListTile(
                   leading: CircleAvatar(
                     backgroundColor: Color(subject.color),
                     child: Text(
                       (subject.code != null && subject.code!.isNotEmpty) 
                         ? subject.code!.substring(0, 1) 
                         : subject.name.isNotEmpty ? subject.name.substring(0, 1) : "?", 
                       style: const TextStyle(color: Colors.white)
                     ),
                   ),
                   title: Text(subject.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                   subtitle: Text("${subject.code ?? ''} • ${subject.credits} Credits"),
                   trailing: Row(
                     mainAxisSize: MainAxisSize.min,
                     children: [
                       IconButton(
                         icon: const Icon(Icons.edit, color: Colors.blue),
                         onPressed: () => _showSubjectDialog(context, ref, subject: subject),
                       ),
                       IconButton(
                         icon: const Icon(Icons.delete, color: Colors.red),
                         onPressed: () {
                           // Confirm Dialog
                           showDialog(
                             context: context, 
                             builder: (c) => AlertDialog(
                               title: const Text("Delete Subject?"),
                               content: const Text("This will remove it from all schedules and exams."),
                               actions: [
                                 TextButton(onPressed: () => Navigator.pop(c), child: const Text("Cancel")),
                                 TextButton(
                                   onPressed: () {
                                     ref.read(subjectControllerProvider.notifier).deleteSubject(subject.id!);
                                     Navigator.pop(c);
                                   }, 
                                   child: const Text("Delete", style: TextStyle(color: Colors.red))
                                 ),
                               ],
                             )
                           );
                         },
                       ),
                     ],
                   ),
                 ),
               );
             },
           );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, s) => Center(child: Text("Error: $e")),
      ),
    );
  }

  void _showSubjectDialog(BuildContext context, WidgetRef ref, {Subject? subject}) {
    showDialog(
      context: context,
      builder: (c) => _SubjectDialog(subject: subject),
    );
  }
}

class _SubjectDialog extends ConsumerStatefulWidget {
  final Subject? subject;
  const _SubjectDialog({this.subject});

  @override
  ConsumerState<_SubjectDialog> createState() => __SubjectDialogState();
}

class __SubjectDialogState extends ConsumerState<_SubjectDialog> {
  final _nameController = TextEditingController();
  final _codeController = TextEditingController();
  final _creditsController = TextEditingController(text: "3");
  int _selectedColor = 0xFF2196F3; // Default Blue

  final List<int> _colors = [
    0xFFF44336, // Red
    0xFFE91E63, // Pink
    0xFF9C27B0, // Purple
    0xFF673AB7, // Deep Purple
    0xFF3F51B5, // Indigo
    0xFF2196F3, // Blue
    0xFF03A9F4, // Light Blue
    0xFF00BCD4, // Cyan
    0xFF009688, // Teal
    0xFF4CAF50, // Green
    0xFF8BC34A, // Light Green
    0xFFCDDC39, // Lime
    0xFFFFEB3B, // Yellow
    0xFFFFC107, // Amber
    0xFFFF9800, // Orange
    0xFFFF5722, // Deep Orange
    0xFF795548, // Brown
    0xFF607D8B, // Blue Grey
  ];

  @override
  void initState() {
    super.initState();
    if (widget.subject != null) {
      _nameController.text = widget.subject!.name;
      _codeController.text = widget.subject!.code ?? "";
      _creditsController.text = widget.subject!.credits.toString();
      _selectedColor = widget.subject!.color;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.subject == null ? "Add Subject" : "Edit Subject"),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: "Subject Name", border: OutlineInputBorder()),
              textCapitalization: TextCapitalization.words,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _codeController,
                    decoration: const InputDecoration(labelText: "Code (e.g. CS101)", border: OutlineInputBorder()),
                    textCapitalization: TextCapitalization.characters,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextField(
                    controller: _creditsController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(labelText: "Credits", border: OutlineInputBorder()),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Text("Color Code"),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _colors.map((c) => InkWell(
                onTap: () => setState(() => _selectedColor = c),
                child: Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: Color(c),
                    shape: BoxShape.circle,
                    border: _selectedColor == c ? Border.all(color: Colors.black, width: 2) : null,
                  ),
                  child: _selectedColor == c ? const Icon(Icons.check, size: 16, color: Colors.white) : null,
                ),
              )).toList(),
            )
          ],
        ),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancel")),
        FilledButton(
          onPressed: () {
            if (_nameController.text.isEmpty) return;
            
            final name = _nameController.text;
            final code = _codeController.text;
            final credits = int.tryParse(_creditsController.text) ?? 3;

            if (widget.subject == null) {
              ref.read(subjectControllerProvider.notifier).addSubject(name, code, _selectedColor, credits);
            } else {
              final updated = widget.subject!.copyWith(
                name: name,
                code: code,
                credits: credits,
                color: _selectedColor
              );
              ref.read(subjectControllerProvider.notifier).updateSubject(updated);
            }
            Navigator.pop(context);
          }, 
          child: const Text("Save"),
        )
      ],
    );
  }
}
