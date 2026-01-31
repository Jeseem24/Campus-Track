import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../domain/providers/today_classes_provider.dart';
import '../../presentation/providers/attendance_controller.dart';
import 'class_timeline_widget.dart';

class PastAttendanceDialog extends ConsumerWidget {
  final DateTime date;

  const PastAttendanceDialog({
    super.key,
    required this.date,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 1. Fetch classes for this day
    final dateEpoch = DateTime(date.year, date.month, date.day).millisecondsSinceEpoch;
    final classesAsync = ref.watch(classesForDateProvider(dateEpoch));

    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: Container(
        padding: const EdgeInsets.all(16),
        constraints: const BoxConstraints(maxHeight: 600),
        child: Column(
           mainAxisSize: MainAxisSize.min,
           crossAxisAlignment: CrossAxisAlignment.stretch,
           children: [
             // Header
             Text(
               DateFormat.MMMMEEEEd().format(date),
               style: Theme.of(context).textTheme.titleLarge,
               textAlign: TextAlign.center,
             ),
             const SizedBox(height: 4),
             const Text(
               "Edit Past Attendance",
               style: TextStyle(fontSize: 12, color: Colors.grey),
               textAlign: TextAlign.center,
             ),
             const Divider(),
             const SizedBox(height: 8),

             // List
             Flexible(
               child: SingleChildScrollView(
                 child: classesAsync.when(
                   data: (slots) {
                     return ClassTimelineWidget(
                       slots: slots, 
                       dateEpoch: dateEpoch,
                       isReadOnly: false, // Editable!
                     );
                   },
                   loading: () => const Center(child: CircularProgressIndicator()),
                   error: (e, s) => Center(child: Text("Error: $e")),
                 ),
               ),
             ),
             
             const SizedBox(height: 16),
             Row(
               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
               children: [
                 TextButton(
                   onPressed: () async {
                      await ref.read(attendanceControllerProvider(dateEpoch).notifier).markAll('ABSENT');
                      if (context.mounted) Navigator.pop(context);
                   },
                   style: TextButton.styleFrom(foregroundColor: Colors.red), 
                   child: const Text("Mark All Absent")
                 ),
                 TextButton(
                   onPressed: () async {
                      await ref.read(attendanceControllerProvider(dateEpoch).notifier).markAll('PRESENT');
                      if (context.mounted) Navigator.pop(context);
                   },
                   style: TextButton.styleFrom(foregroundColor: Colors.green), 
                   child: const Text("Mark All Present")
                 ),
               ],
             ),
             const SizedBox(height: 8),
             Align(
               alignment: Alignment.center,
               child: TextButton(
                 onPressed: () => Navigator.pop(context), 
                 child: const Text("Done", style: TextStyle(fontWeight: FontWeight.bold))
               ),
             ),
           ],
        ),
      ),
    );
  }
}
