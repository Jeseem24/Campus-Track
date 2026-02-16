import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/entities/academic_day.dart';
import '../../domain/logic/day_order_calculator.dart';
import '../../data/database/database_helper.dart';
import '../../domain/providers/active_semester_provider.dart';

part 'calendar_provider.g.dart';

class CalendarDayState {
  final DateTime date;
  final int? dayOrder;
  final bool isHoliday;
  final bool isManualOverride;
  final bool isToday;

  CalendarDayState({
    required this.date,
    this.dayOrder,
    required this.isHoliday,
    this.isManualOverride = false,
    this.isToday = false,
  });
}

@riverpod
Future<List<CalendarDayState>> monthCalendar(MonthCalendarRef ref, DateTime month) async {
  final activeSemester = await ref.watch(activeSemesterProvider.future);
  if (activeSemester == null) return [];

  // Define range for the requested month
  final startOfMonth = DateTime(month.year, month.month, 1);
  final endOfMonth = DateTime(month.year, month.month + 1, 0); // Last day of month

  final startEpoch = startOfMonth.millisecondsSinceEpoch;
  final endEpoch = endOfMonth.millisecondsSinceEpoch;

  final db = DatabaseHelper.instance;
  // Fetch existing overrides/holidays for this month
  // Optimization: Could fetch just this month, but for now fetch semester (simpler logic reuse)
  // or fetch by range. Let's fetch semester to be safe for "Carry Forward" impacts from previous months.
  final rawDays = await db.queryBy('academic_days', 'semester_id = ?', [activeSemester.id]);
  final existingDays = rawDays.map((e) => AcademicDay.fromJson(e)).toList();

  final calculator = DayOrderCalculator();
  // We need to calculate from Semester Start to End of This Month to ensure sequence is correct
  final projection = calculator.calculateProjectedDayOrders(
    startDateEpoch: activeSemester.startDate,
    endDateEpoch: endEpoch, // Calculate up to end of this month
    existingDays: existingDays,
  );

  final List<CalendarDayState> calendarDays = [];
  final now = DateTime.now();
  final todayMidnight = DateTime(now.year, now.month, now.day);

  // Iterate through all days in the requested month
  for (int dayNum = 1; dayNum <= endOfMonth.day; dayNum++) {
    final date = DateTime(startOfMonth.year, startOfMonth.month, dayNum);
    final dateEpoch = date.millisecondsSinceEpoch;

    // Check if this date is within Semester bounds
    if (dateEpoch < activeSemester.startDate || dateEpoch > activeSemester.endDate) {
      // Out of semester - render as grey/empty-ish?
      // For now, just mark as holiday/no-order
      calendarDays.add(CalendarDayState(
        date: date, 
        isHoliday: true, 
        isToday: date.isAtSameMomentAs(todayMidnight)
      ));
      continue;
    }

    final dayOrder = projection[dateEpoch];
    final isHoliday = dayOrder == null;

    // Check specific record for override flag
    final record = existingDays.cast<AcademicDay?>().firstWhere(
      (d) => d?.dateEpoch == dateEpoch,
      orElse: () => null,
    );

    calendarDays.add(CalendarDayState(
      date: date,
      dayOrder: dayOrder,
      isHoliday: isHoliday,
      isManualOverride: record?.isManualOverride ?? false,
      isToday: date.isAtSameMomentAs(todayMidnight),
    ));
  }

  return calendarDays;
}
