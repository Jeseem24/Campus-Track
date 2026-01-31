import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../../domain/entities/semester.dart';
import '../../../domain/repositories/semester_repository.dart';
import '../../../data/repositories/semester_repository_impl.dart';
import '../../../domain/providers/active_semester_provider.dart';

class SemesterSetupScreen extends ConsumerStatefulWidget {
  const SemesterSetupScreen({super.key});

  @override
  ConsumerState<SemesterSetupScreen> createState() => _SemesterSetupScreenState();
}

class _SemesterSetupScreenState extends ConsumerState<SemesterSetupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  DateTime? _startDate;
  DateTime? _endDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Setup Semester")),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Welcome to CampusTrack",
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 8),
              const Text(
                "Let's set up your current academic term.",
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 32),
              
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: "Semester Name",
                  hintText: "e.g. Semester 4",
                  border: OutlineInputBorder(),
                ),
                validator: (value) => value == null || value.isEmpty ? "Required" : null,
              ),
              const SizedBox(height: 24),
              
              // Start Date Picker
              _buildDatePicker(
                label: "Start Date",
                selectedDate: _startDate,
                onTap: () async {
                  final picked = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2020),
                    lastDate: DateTime(2030),
                  );
                  if (picked != null) {
                    setState(() => _startDate = picked);
                  }
                },
              ),
              const SizedBox(height: 16),
              
              // End Date Picker
              _buildDatePicker(
                label: "End Date (Approx)",
                selectedDate: _endDate,
                onTap: () async {
                  final picked = await showDatePicker(
                    context: context,
                    initialDate: _startDate?.add(const Duration(days: 90)) ?? DateTime.now().add(const Duration(days: 90)),
                    firstDate: _startDate ?? DateTime(2020),
                    lastDate: DateTime(2030),
                  );
                  if (picked != null) {
                    setState(() => _endDate = picked);
                  }
                },
              ),
              
              const Spacer(),
              
              SizedBox(
                width: double.infinity,
                height: 50,
                child: FilledButton(
                  onPressed: _saveSemester,
                  child: const Text("Start Semester"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDatePicker({required String label, required DateTime? selectedDate, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(4),
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
          suffixIcon: const Icon(Icons.calendar_today),
        ),
        child: Text(
          selectedDate != null ? DateFormat.yMMMd().format(selectedDate) : "Select Date",
          style: TextStyle(
            color: selectedDate != null ? Theme.of(context).textTheme.bodyLarge?.color : Colors.grey.shade600,
          ),
        ),
      ),
    );
  }

  Future<void> _saveSemester() async {
    if (_formKey.currentState!.validate() && _startDate != null && _endDate != null) {
      final semester = Semester(
        name: _nameController.text,
        startDate: _startDate!.millisecondsSinceEpoch,
        endDate: _endDate!.millisecondsSinceEpoch,
        isActive: true,
      );

      final repo = ref.read(semesterRepositoryProvider);
      await repo.createSemester(semester);
      
      // Force refresh of the active semester so Router knows we have one
      ref.invalidate(activeSemesterProvider);

      if (mounted) {
        context.go('/'); // Go to Home
      }
    } else if (_startDate == null || _endDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
         const SnackBar(content: Text("Please select start and end dates")),
      );
    }
  }
}
