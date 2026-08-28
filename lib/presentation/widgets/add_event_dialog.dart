import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../domain/entities/participation_event.dart';
import '../providers/participation_event_provider.dart';

class AddEventDialog extends ConsumerStatefulWidget {
  const AddEventDialog({super.key});

  @override
  ConsumerState<AddEventDialog> createState() => _AddEventDialogState();
}

class _AddEventDialogState extends ConsumerState<AddEventDialog> {
  final _nameController = TextEditingController();
  final _locController = TextEditingController();
  final _descController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add Participated Event'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Event Name (e.g. Smart India Hackathon)'),
            ),
            TextField(
              controller: _locController,
              decoration: const InputDecoration(labelText: 'Place / Location'),
            ),
            TextField(
              controller: _descController,
              decoration: const InputDecoration(labelText: 'Description / Details'),
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
                  firstDate: DateTime(2020),
                  lastDate: DateTime.now(),
                );
                if (picked != null) {
                  setState(() => _selectedDate = picked);
                }
              },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
        FilledButton(
          onPressed: () {
            if (_nameController.text.isNotEmpty) {
              final newEvent = ParticipationEvent(
                name: _nameController.text,
                location: _locController.text.isNotEmpty ? _locController.text : null,
                description: _descController.text.isNotEmpty ? _descController.text : null,
                dateEpoch: _selectedDate.millisecondsSinceEpoch,
              );
              ref.read(participationEventListProvider.notifier).addEvent(newEvent);
              Navigator.pop(context);
            }
          },
          child: const Text('Add'),
        ),
      ],
    );
  }
}
