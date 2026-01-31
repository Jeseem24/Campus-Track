import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:go_router/go_router.dart';
import 'package:go_router/go_router.dart';
import '../providers/exam_controller.dart';
import '../providers/gpa_controller.dart';
import '../../domain/providers/all_subjects_provider.dart';
import '../../domain/entities/exam.dart';

class ExamsScreen extends ConsumerWidget {
  const ExamsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final examsAsync = ref.watch(examControllerProvider);
    final subjectsAsync = ref.watch(allSubjectsProvider);
    
    final gpaAsync = ref.watch(gpaControllerProvider);
    
    return Scaffold(
      appBar: AppBar(title: const Text("Exams & Results")),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddExamDialog(context, ref, subjectsAsync.valueOrNull ?? []),
        label: const Text("Add Exam"),
        icon: const Icon(Icons.add),
      ),
      body: examsAsync.when(
        data: (exams) {
          return SingleChildScrollView(
            child: Column(
              children: [
                // GPA Card
                gpaAsync.when(
                  data: (state) => Container(
                    margin: const EdgeInsets.all(16),
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [Colors.deepPurple.shade400, Colors.deepPurple.shade700]),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 8, offset: Offset(0, 4))]
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("Semester GPA", style: TextStyle(color: Colors.white70)),
                            Text(state.gpa.toStringAsFixed(2), style: const TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold)),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text("Credits: ${state.totalCredits}", style: const TextStyle(color: Colors.white70)),
                            if (state.totalCredits > 0)
                               const Text("Calculated", style: TextStyle(color: Colors.greenAccent, fontWeight: FontWeight.bold))
                          ],
                        )
                      ],
                    ),
                  ),
                  loading: () => const LinearProgressIndicator(), 
                  error: (_,__) => const SizedBox.shrink()
                ),
            
                if (exams.isEmpty) 
                   const Padding(
                     padding: EdgeInsets.all(32),
                     child: Text("No exams scheduled yet! 📚"),
                   )
                else
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: exams.length,
                    itemBuilder: (context, index) {
                      final exam = exams[index];
                      return _ExamCard(exam: exam);
                    },
                  ),
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e,s) => Center(child: Text("Error: $e")),
      ),
    );
  }

  void _showAddExamDialog(BuildContext context, WidgetRef ref, List<dynamic> subjects) { // dynamic to avoid import duplication issues if any
    showDialog(
      context: context,
      builder: (c) => _AddExamDialog(subjects: subjects),
    );
  }
}

class _ExamCard extends ConsumerWidget {
  final Exam exam;
  const _ExamCard({required this.exam});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final subjects = ref.watch(allSubjectsProvider).valueOrNull ?? [];
    final subject = subjects.firstWhere((s) => s.id == exam.subjectId, orElse: () => subjects.first); // Fallback
    
    final isComplted = exam.obtainedMarks != null;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(backgroundColor: Color(subject.color), child: Text(subject.code?[0] ?? "S", style: TextStyle(color: Colors.white))),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(exam.title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      Text(subject.name),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                     Text(DateFormat('MMM d').format(DateTime.fromMillisecondsSinceEpoch(exam.date)), style: const TextStyle(fontWeight: FontWeight.bold)),
                     const SizedBox(height: 4),
                     if (isComplted)
                       Text("${exam.obtainedMarks!.toStringAsFixed(1)} / ${exam.totalMarks.toStringAsFixed(0)}", style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold))
                     else
                       const Text("Upcoming", style: TextStyle(color: Colors.orange, fontSize: 12)),
                  ],
                )
              ],
            ),
            if (!isComplted) ...[
               const Divider(),
               TextButton(
                 onPressed: () {
                   _showMarksDialog(context, ref, exam);
                 }, 
                 child: const Text("Enter Result")
               )
            ] else ...[
               const Divider(),
               Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                   Text("Percentage: ${((exam.obtainedMarks! / exam.totalMarks) * 100).toStringAsFixed(1)}%"),
                   TextButton(onPressed: () => _showMarksDialog(context, ref, exam), child: const Text("Edit"))
                 ],
               )
            ]
          ],
        ),
      ),
    );
  }

  void _showMarksDialog(BuildContext context, WidgetRef ref, Exam exam) {
    final controller = TextEditingController(text: exam.obtainedMarks?.toString() ?? "");
    showDialog(
      context: context, 
      builder: (c) => AlertDialog(
        title: Text("Enter Marks for ${exam.title}"),
        content: TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: "Obtained Marks (Max: ${exam.totalMarks})",
            border: const OutlineInputBorder(),
          ),
          autofocus: true,
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(c), child: const Text("Cancel")),
          FilledButton(
            onPressed: () {
              final marks = double.tryParse(controller.text);
              if (marks != null && marks <= exam.totalMarks) {
                 ref.read(examControllerProvider.notifier).updateMarks(exam, marks);
                 Navigator.pop(c);
              }
            }, 
            child: const Text("Save"),
          )
        ],
      )
    );
  }
}

class _AddExamDialog extends ConsumerStatefulWidget {
  final List<dynamic> subjects;
  const _AddExamDialog({required this.subjects});

  @override
  ConsumerState<_AddExamDialog> createState() => __AddExamDialogState();
}

class __AddExamDialogState extends ConsumerState<_AddExamDialog> {
  final _titleController = TextEditingController();
  final _marksController = TextEditingController(text: "100");
  int? _subjectId;
  DateTime _date = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Schedule Exam"),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
             DropdownButtonFormField<int>(
               value: _subjectId,
               decoration: const InputDecoration(labelText: "Subject"),
               items: widget.subjects.map<DropdownMenuItem<int>>((s) => DropdownMenuItem(
                 value: s.id,
                 child: Text(s.name),
               )).toList(),
               onChanged: (v) => setState(() => _subjectId = v),
             ),
             const SizedBox(height: 16),
             TextField(
               controller: _titleController,
               decoration: const InputDecoration(labelText: "Title (e.g. Midterm)", border: OutlineInputBorder()),
             ),
             const SizedBox(height: 16),
             TextField(
               controller: _marksController,
               keyboardType: TextInputType.number,
               decoration: const InputDecoration(labelText: "Total Marks", border: OutlineInputBorder()),
             ),
             const SizedBox(height: 16),
             Row(
               children: [
                 const Text("Date: "),
                 TextButton(
                   onPressed: () async {
                     final d = await showDatePicker(context: context, initialDate: _date, firstDate: DateTime(2020), lastDate: DateTime(2030));
                     if(d!=null) setState(() => _date = d);
                   }, 
                   child: Text(DateFormat('MMM d, y').format(_date))
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
            if (_subjectId == null || _titleController.text.isEmpty || _marksController.text.isEmpty) return;
            
            final exam = Exam(
              subjectId: _subjectId!,
              title: _titleController.text,
              date: _date.millisecondsSinceEpoch,
              totalMarks: double.parse(_marksController.text),
            );
            ref.read(examControllerProvider.notifier).addExam(exam);
            Navigator.pop(context);
          }, 
          child: const Text("Schedule"),
        )
      ],
    );
  }
}
