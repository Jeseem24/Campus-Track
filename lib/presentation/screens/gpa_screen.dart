import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/bgpa_controller.dart';

class GPAScreen extends ConsumerWidget {
  const GPAScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final resultsAsync = ref.watch(bGPAControllerProvider);
    final controller = ref.read(bGPAControllerProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: const Text("Academic Performance")),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddDialog(context, ref),
        label: const Text("Add Semester"),
        icon: const Icon(Icons.add),
      ),
      body: resultsAsync.when(
        data: (results) {
          final cgpa = controller.calculateCGPA(results);
          
          return Column(
            children: [
              // CGPA Card
              Container(
                width: double.infinity,
                margin: const EdgeInsets.all(16),
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.purple.shade400, Colors.deepPurple.shade700],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(color: Colors.black26, blurRadius: 10, offset: Offset(0, 4))
                  ]
                ),
                child: Column(
                  children: [
                    const Text("Cumulative GPA (CGPA)", style: TextStyle(color: Colors.white70)),
                    const SizedBox(height: 8),
                    Text(
                      cgpa.toStringAsFixed(2),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 48,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "${results.length} Semesters Logged",
                      style: const TextStyle(color: Colors.white60),
                    )
                  ],
                ),
              ),

              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.only(left: 16, right: 16, bottom: 80),
                  itemCount: results.length,
                  separatorBuilder: (c, i) => const SizedBox(height: 8),
                  itemBuilder: (context, index) {
                    final res = results[index];
                    return Card(
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.deepPurple.shade50,
                          child: const Icon(Icons.school, color: Colors.deepPurple),
                        ),
                        title: Text(res.semesterName, style: const TextStyle(fontWeight: FontWeight.bold)),
                        subtitle: Text("Credits: ${res.totalCredits}"),
                        trailing: Text(
                          res.gpa.toStringAsFixed(2),
                          style: const TextStyle(
                            fontSize: 18, 
                            fontWeight: FontWeight.bold,
                            color: Colors.deepPurple
                          ),
                        ),
                        onLongPress: () {
                          // Delete option
                          showDialog(
                            context: context,
                            builder: (c) => AlertDialog(
                              title: const Text("Delete Record?"),
                              actions: [
                                TextButton(onPressed: () => Navigator.pop(c), child: const Text("Cancel")),
                                TextButton(
                                  onPressed: () {
                                    ref.read(bGPAControllerProvider.notifier).deleteResult(res.id!);
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
                ),
              ),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, s) => Center(child: Text("Error: $e")),
      ),
    );
  }

  void _showAddDialog(BuildContext context, WidgetRef ref) {
    final nameCtrl = TextEditingController();
    final gpaCtrl = TextEditingController();
    final creditCtrl = TextEditingController();

    showDialog(
      context: context,
      builder: (c) => AlertDialog(
        title: const Text("Log Semester Result"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameCtrl,
              decoration: const InputDecoration(labelText: "Semester Name (e.g. Sem 1)", border: OutlineInputBorder()),
              textCapitalization: TextCapitalization.words,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: gpaCtrl,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(labelText: "GPA", border: OutlineInputBorder()),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextField(
                    controller: creditCtrl,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(labelText: "Credits", border: OutlineInputBorder()),
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(c), child: const Text("Cancel")),
          FilledButton(
            onPressed: () {
              final name = nameCtrl.text;
              final gpa = double.tryParse(gpaCtrl.text);
              final credits = double.tryParse(creditCtrl.text);

              if (name.isNotEmpty && gpa != null && credits != null) {
                ref.read(bGPAControllerProvider.notifier).addResult(name, gpa, credits);
                Navigator.pop(c);
              }
            }, 
            child: const Text("Save"),
          )
        ],
      ),
    );
  }
}
