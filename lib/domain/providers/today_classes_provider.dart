import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/entities/subject.dart';
import '../../domain/entities/academic_day.dart'; // New Import
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
  
  // Lazy Generation Logic
  if (day == null) {
      final semester = await ref.watch(activeSemesterProvider.future);
      if (semester != null) {
        final date = DateTime.fromMillisecondsSinceEpoch(dateEpoch);
        
        // Basic Rules
        final isSunday = date.weekday == DateTime.sunday;
        
        // Try to find previous day to infer order
        // We can't easily query "PREVIOUS" day without a specific repo method, 
        // but we can try yesterday.
        final yesterday = date.subtract(const Duration(days: 1));
        final prevDay = await dayRepo.getDay(yesterday.millisecondsSinceEpoch);
        
        int? newOrder;
        if (!isSunday) {
           if (prevDay != null && !prevDay.isHoliday && prevDay.dayOrder != null) {
             newOrder = (prevDay.dayOrder! % 6) + 1;
           } else {
             // Fallback or request manual?
             // Default to Day Order 1 if we have absolutely no info and it's not Sunday.
             // Or maybe checking 2 days ago? This is getting complicated for a quick fix.
             // Simplest Safe Fallback: Day Order 1. User can edit it.
             newOrder = 1;
           }
        }

        day = AcademicDay(
          dateEpoch: dateEpoch, 
          semesterId: semester.id!, 
          dayOrder: isSunday ? null : newOrder,
          isHoliday: isSunday,
          isManualOverride: false
        );
        
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
