import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/entities/academic_day.dart';
import '../../domain/logic/day_order_calculator.dart';
import '../../data/database/database_helper.dart';
import '../../domain/providers/active_semester_provider.dart';

part 'day_order_provider.g.dart';

@riverpod
class CurrentAcademicDay extends _$CurrentAcademicDay {
  @override
  Future<AcademicDay?> build() async {
    final activeSemester = await ref.watch(activeSemesterProvider.future);
    if (activeSemester == null) return null;

    final db = DatabaseHelper.instance;
    
    // Fetch all days for this semester
    final rawDays = await db.queryBy('academic_days', 'semester_id = ?', [activeSemester.id]);
    final existingDays = rawDays.map((e) => AcademicDay.fromJson(e)).toList();

    // Calculate details for TODAY
    final now = DateTime.now();
    // Normalize to midnight for consistent epoch matching
    final todayMidnight = DateTime(now.year, now.month, now.day);
    final todayEpoch = todayMidnight.millisecondsSinceEpoch;

    final calculator = DayOrderCalculator();
    final projection = calculator.calculateProjectedDayOrders(
      startDateEpoch: activeSemester.startDate,
      endDateEpoch: activeSemester.endDate,
      existingDays: existingDays,
    );

    final dayOrder = projection[todayEpoch];
    final isHoliday = dayOrder == null; // In our map, null means holiday (if within range)
    
    // Check if we have a specific record for today to get "Manual Override" flags etc
    final todayRecord = existingDays.cast<AcademicDay?>().firstWhere(
      (d) => d?.dateEpoch == todayEpoch,
      orElse: () => null,
    );

    return AcademicDay(
      dateEpoch: todayEpoch,
      semesterId: activeSemester.id!,
      isHoliday: isHoliday,
      dayOrder: dayOrder,
      isManualOverride: todayRecord?.isManualOverride ?? false,
      affectsFuture: todayRecord?.affectsFuture ?? false,
      note: todayRecord?.note,
    );
  }
}
