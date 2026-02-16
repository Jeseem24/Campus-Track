import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/entities/subject.dart';
import '../../domain/entities/academic_day.dart'; // New Import
import '../../domain/logic/day_order_calculator.dart'; // Required for proper day calculation
import '../../domain/providers/active_semester_provider.dart'; // New Import
import '../../data/repositories/subject_repository_impl.dart';
import '../../data/repositories/timetable_repository_impl.dart';
import '../../presentation/providers/day_order_provider.dart';
import '../../data/repositories/day_repository_impl.dart'; // Verified Import

part 'today_classes_provider.g.dart';

class TimetableSlot {
  final int slotIndex; // 1-8
  final Subject? subject;
  final String timeRange;

  TimetableSlot(this.slotIndex, this.subject, this.timeRange);
}

@riverpod
Future<List<TimetableSlot>> classesForDate(ClassesForDateRef ref, int dateEpoch) async {
  final dayRepo = ref.watch(dayRepositoryProvider);
  AcademicDay? day = await dayRepo.getDay(dateEpoch); 
  
  // Lazy Generation Logic using proper DayOrderCalculator
  if (day == null) {
      final semester = await ref.watch(activeSemesterProvider.future);
      if (semester != null) {
        final date = DateTime.fromMillisecondsSinceEpoch(dateEpoch);
        
        // Fetch all existing days for proper calculation
        final existingDays = await dayRepo.getDaysForSemester(semester.id!);
        
        // Use DayOrderCalculator for proper sequence computation
        final calculator = DayOrderCalculator();
        final projection = calculator.calculateProjectedDayOrders(
          startDateEpoch: semester.startDate,
          endDateEpoch: dateEpoch,
          existingDays: existingDays,
        );
        
        final calculatedOrder = projection[dateEpoch];
        final isHoliday = calculatedOrder == null;
        
        day = AcademicDay(
          dateEpoch: dateEpoch, 
          semesterId: semester.id!, 
          dayOrder: calculatedOrder,
          isHoliday: isHoliday,
          isManualOverride: false
        );
        
        // Save the computed day to avoid recalculation
        await dayRepo.saveDay(day);
      }
  }
  
  if (day == null || day.dayOrder == null) return [];

  final timetableRepo = ref.watch(timetableRepositoryProvider);
  final subjectRepo = ref.watch(subjectRepositoryProvider);

  // 1. Get raw timetable {slot: subjectId}
  final rawMap = await timetableRepo.getTimetableForDay(day.dayOrder!);
  
  // 2. Build list of slots 1-8
  final List<TimetableSlot> slots = [];
  
  // Helper for fixed timings
  String getTime(int i) {
    switch(i) {
      case 1: return "9:00 - 9:45";
      case 2: return "9:45 - 10:30";
      case 3: return "10:45 - 11:30";
      case 4: return "11:30 - 12:15";
      case 5: return "1:00 - 1:45";
      case 6: return "1:45 - 2:30";
      case 7: return "2:45 - 3:30";
      case 8: return "3:30 - 4:15";
      default: return "";
    }
  }

  for (int i = 1; i <= 8; i++) {
    final subjectId = rawMap[i];
    Subject? subject;
    if (subjectId != null) {
      subject = await subjectRepo.getSubject(subjectId);
    }
    slots.add(TimetableSlot(i, subject, getTime(i)));
  }

  return slots;
}

// Keep todayClasses for backward compat if needed, or redirect
@riverpod
Future<List<TimetableSlot>> todayClasses(TodayClassesRef ref) async {
  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);
  return ref.watch(classesForDateProvider(today.millisecondsSinceEpoch).future);
}

/// Provider to get the AcademicDay for a given date epoch.
/// Uses the same lazy generation + DayOrderCalculator logic as classesForDate.
/// This is used by DayCard on the home screen so it refreshes via Riverpod invalidation.
@riverpod
Future<AcademicDay?> academicDayForDate(AcademicDayForDateRef ref, int dateEpoch) async {
  final dayRepo = ref.watch(dayRepositoryProvider);
  AcademicDay? day = await dayRepo.getDay(dateEpoch);

  if (day == null) {
    final semester = await ref.watch(activeSemesterProvider.future);
    if (semester != null) {
      final existingDays = await dayRepo.getDaysForSemester(semester.id!);
      final calculator = DayOrderCalculator();
      final projection = calculator.calculateProjectedDayOrders(
        startDateEpoch: semester.startDate,
        endDateEpoch: dateEpoch,
        existingDays: existingDays,
      );

      final calculatedOrder = projection[dateEpoch];
      final isHoliday = calculatedOrder == null;

      day = AcademicDay(
        dateEpoch: dateEpoch,
        semesterId: semester.id!,
        dayOrder: calculatedOrder,
        isHoliday: isHoliday,
        isManualOverride: false,
      );
      await dayRepo.saveDay(day);
    }
  }

  return day;
}
