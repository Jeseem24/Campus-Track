import 'package:flutter/material.dart';
import '../../domain/entities/academic_day.dart';

class DayCard extends StatelessWidget {
  final AcademicDay? day;

  const DayCard({super.key, required this.day});

  @override
  Widget build(BuildContext context) {
    if (day == null) {
      return const Card(child: Padding(padding: EdgeInsets.all(16), child: Text("No Semester Active")));
    }

    final isHoliday = day!.isHoliday;
    final dayOrder = day!.dayOrder;

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: isHoliday ? Colors.red.shade100 : Theme.of(context).colorScheme.primaryContainer,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Text(
              isHoliday ? "HOLIDAY" : "DAY ORDER",
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                letterSpacing: 1.5,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              isHoliday ? "Relax! 🏖️" : "$dayOrder",
              style: Theme.of(context).textTheme.displayLarge?.copyWith(
                fontWeight: FontWeight.w900,
                fontSize: isHoliday ? 40 : 80,
              ),
            ),
            if (!isHoliday && day!.isManualOverride)
               Chip(
                 label: const Text("Manual Override"),
                 backgroundColor: Colors.orange.shade100,
               )
          ],
        ),
      ),
    );
  }
}
