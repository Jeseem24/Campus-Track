import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../domain/entities/important_day.dart';
import '../providers/important_day_provider.dart';

class AddImportantDayDialog extends ConsumerStatefulWidget {
  const AddImportantDayDialog({super.key});

  @override
  ConsumerState<AddImportantDayDialog> createState() => _AddImportantDayDialogState();
}

class _AddImportantDayDialogState extends ConsumerState<AddImportantDayDialog> {
  final _titleController = TextEditingController();
  final _descController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add Important Day'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _titleController,
            decoration: const InputDecoration(labelText: 'Title (e.g. Training Class)'),
          ),
          TextField(
            controller: _descController,
            decoration: const InputDecoration(labelText: 'Description (What to practice)'),
            maxLines: 2,
          ),
          const SizedBox(height: 16),
          ListTile(
            title: const Text('Date'),
            subtitle: Text(DateFormat.yMMMd().format(_selectedDate)),
            trailing: const Icon(Icons.calendar_today),
            onTap: () async {
              final picked = await showDatePicker(
                context: context,
                initialDate: _selectedDate,
                firstDate: DateTime.now(),
                lastDate: DateTime.now().add(const Duration(days: 365)),
              );
              if (picked != null) {
                setState(() => _selectedDate = picked);
              }
            },
          ),
        ],
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
        FilledButton(
          onPressed: () {
            if (_titleController.text.isNotEmpty) {
              final newDay = ImportantDay(
                title: _titleController.text,
                description: _descController.text.isNotEmpty ? _descController.text : null,
                dateEpoch: DateTime(_selectedDate.year, _selectedDate.month, _selectedDate.day).millisecondsSinceEpoch,
              );
              ref.read(importantDayListProvider.notifier).addImportantDay(newDay);
              Navigator.pop(context);
            }
          },
          child: const Text('Add'),
        ),
      ],
    );
  }
}
