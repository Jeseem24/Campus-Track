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
    final note = day!.note ?? "";
    final isExam = note.toLowerCase().contains("exam") || note.toLowerCase().contains("cat");
    final isActivity = note.toLowerCase().contains("activity");

    Color cardColor = Theme.of(context).colorScheme.primaryContainer;
    String headerText = "DAY ORDER";
    Widget centerWidget;

    if (isHoliday) {
      if (isExam) {
        cardColor = Colors.orange.shade100;
        headerText = "EXAMINATION PERIOD";
        centerWidget = Column(
          children: [
            const Text("📝", style: TextStyle(fontSize: 50)),
            const SizedBox(height: 8),
            Text(
              "Exams Ongoing",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.orange.shade900,
              ),
            ),
          ],
        );
      } else if (isActivity) {
        cardColor = Colors.amber.shade100;
        headerText = "CELL ACTIVITY";
        centerWidget = Column(
          children: [
            const Text("🎯", style: TextStyle(fontSize: 50)),
            const SizedBox(height: 8),
            Text(
              "Activity Day",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.amber.shade900,
              ),
            ),
          ],
        );
      } else {
        cardColor = Colors.red.shade100;
        headerText = "HOLIDAY";
        centerWidget = Text(
          "Relax! 🏖️",
          style: Theme.of(context).textTheme.displayLarge?.copyWith(
            fontWeight: FontWeight.w900,
            fontSize: 40,
            color: Colors.red.shade900,
          ),
        );
      }
    } else {
      centerWidget = Text(
        "$dayOrder",
        style: Theme.of(context).textTheme.displayLarge?.copyWith(
          fontWeight: FontWeight.w900,
          fontSize: 80,
          color: Theme.of(context).colorScheme.onPrimaryContainer,
        ),
      );
    }

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: cardColor,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Text(
              headerText,
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                letterSpacing: 1.5,
                fontWeight: FontWeight.bold,
                color: isHoliday 
                  ? (isExam 
                      ? Colors.orange.shade800 
                      : (isActivity ? Colors.amber.shade900 : Colors.red.shade800))
                  : Theme.of(context).colorScheme.onPrimaryContainer.withOpacity(0.8),
              ),
            ),
            const SizedBox(height: 8),
            centerWidget,
            if (note.isNotEmpty) ...[
              const SizedBox(height: 12),
              Text(
                note,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: isHoliday 
                    ? (isExam 
                        ? Colors.orange.shade900 
                        : (isActivity ? Colors.amber.shade900 : Colors.red.shade900))
                    : Theme.of(context).colorScheme.onPrimaryContainer,
                ),
                textAlign: TextAlign.center,
              ),
            ],
            if (!isHoliday && day!.isManualOverride) ...[
               const SizedBox(height: 12),
               Chip(
                 label: const Text("Manual Override"),
                 backgroundColor: Colors.orange.shade100,
               ),
            ]
          ],
        ),
      ),
    );
  }
}
