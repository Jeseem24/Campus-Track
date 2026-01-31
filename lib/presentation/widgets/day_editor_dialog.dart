import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../domain/entities/academic_day.dart';
import '../../domain/repositories/day_repository.dart';
import '../../data/repositories/day_repository_impl.dart';
import '../providers/calendar_provider.dart';
import '../providers/day_order_provider.dart';

class DayEditorDialog extends ConsumerStatefulWidget {
  final DateTime date;
  final int semesterId;
  final CalendarDayState? currentState;

  const DayEditorDialog({
    super.key,
    required this.date,
    required this.semesterId,
    this.currentState,
  });

  @override
  ConsumerState<DayEditorDialog> createState() => _DayEditorDialogState();
}

class _DayEditorDialogState extends ConsumerState<DayEditorDialog> {
  late bool _isHoliday;
  late TextEditingController _noteController;
  int? _selectedDayOrder;
  bool _affectsFuture = true; // Default to YES (safe default for overrides usually)

  @override
  void initState() {
    super.initState();
    _isHoliday = widget.currentState?.isHoliday ?? false;
    _selectedDayOrder = widget.currentState?.dayOrder;
    _noteController = TextEditingController(); // TODO: Load existing note if we had it in state
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(DateFormat.MMMMEEEEd().format(widget.date), style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 4),
          const Text("Freedom Mode (Edit Day)", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey)),
        ],
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Holiday Toggle
            SwitchListTile(
              title: const Text("Is this a Holiday?"),
              value: _isHoliday,
              onChanged: (val) {
                setState(() {
                  _isHoliday = val;
                  if (val) {
                    _selectedDayOrder = null; // Clear day order if holiday
                  } else {
                    // Default to 1 or keep existing
                    _selectedDayOrder ??= 1;
                  }
                });
              },
            ),
            
            if (!_isHoliday) ...[
              const SizedBox(height: 16),
              const Text("Day Order"),
              const SizedBox(height: 8),
              DropdownButtonFormField<int>(
                value: _selectedDayOrder,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                ),
                items: [1, 2, 3, 4, 5, 6].map((e) => DropdownMenuItem(value: e, child: Text("Day Order $e"))).toList(),
                onChanged: (val) {
                  setState(() {
                    _selectedDayOrder = val;
                  });
                },
              ),
            ],

            const SizedBox(height: 24),
            const Divider(),
            
            // CARRY FORWARD LOGIC
            // Only show if we are making a change that might affect sequence
            // For simplicity, show always when editing.
             const Text("Future Impact", style: TextStyle(fontWeight: FontWeight.bold)),
             const SizedBox(height: 8),
             if (_isHoliday)
               const Text(
                 "Holidays do not affect the sequence. The next working day will continue from where we left off.",
                 style: TextStyle(fontSize: 12, color: Colors.grey),
               )
             else
               Column(
                 children: [
                   RadioListTile<bool>(
                     title: const Text("Carry Forward Change"),
                     subtitle: const Text("Future days will shuffle to follow this new Day Order."),
                     value: true,
                     groupValue: _affectsFuture,
                     onChanged: (val) => setState(() => _affectsFuture = val!),
                   ),
                   RadioListTile<bool>(
                     title: const Text("Do Not Carry Forward"),
                     subtitle: const Text("Only this day changes. Future days follow original sequence."),
                     value: false,
                     groupValue: _affectsFuture,
                     onChanged: (val) => setState(() => _affectsFuture = val!),
                   ),
                 ],
               ),
          ],
        ),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancel")),
        FilledButton.tonal(
          onPressed: _save,
          child: const Text("Save Correction"),
        ),
      ],
    );
  }

  Future<void> _save() async {
    // Normalize to local midnight to match DayOrderCalculator logic
    final normalized = DateTime(widget.date.year, widget.date.month, widget.date.day);

    final day = AcademicDay(
      dateEpoch: normalized.millisecondsSinceEpoch,
      semesterId: widget.semesterId,
      isHoliday: _isHoliday,
      dayOrder: _isHoliday ? null : _selectedDayOrder,
      isManualOverride: true, // Always true if coming from Editor
      affectsFuture: _affectsFuture,
      note: _noteController.text,
    );

    final repo = ref.read(dayRepositoryProvider);
    await repo.saveDay(day);

    // Refresh Providers
    ref.invalidate(currentAcademicDayProvider);
    // There is no easy way to invalidate 'monthCalendarProvider' with specific argument family indiscriminately
    // But since it watches 'activeSemesterProvider', maybe we can just trigger a refresh or let UI rebuild.
    // Ideally we should invalidate the specific provider family.
    // For now, let's hope the UI rebuilds or we force it.
    // A trick: Invalidate activeSemester (fetch again) might be too heavy?
    // Proper way: ref.invalidate(monthCalendarProvider);
    // But it's a family. We need to invalidate the specific month of this date.
    // Let's rely on the fact that if we pop, the parent might rebuild? No.
    // We will return 'true' from dialog.
    if (mounted) {
      Navigator.pop(context, true);
    }
  }
}
