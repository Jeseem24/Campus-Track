import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/repositories/attendance_repository.dart';
import '../../data/repositories/attendance_repository_impl.dart';
import '../../data/repositories/timetable_repository_impl.dart';
import '../../domain/repositories/timetable_repository.dart';
import '../../data/repositories/day_repository_impl.dart';
import 'day_order_provider.dart';

import '../../domain/providers/attendance_stats_provider.dart';

part 'attendance_controller.g.dart';

@riverpod
class AttendanceController extends _$AttendanceController {
  @override
  Future<Map<int, AttendanceLog>> build(int dateEpoch) async {
    // 1. Fetch existing attendance for THIS day
    final repo = ref.watch(attendanceRepositoryProvider);
    return await repo.getAttendanceForDay(dateEpoch);
  }

  Future<void> mark(int slotIndex, int subjectId, String status) async {
    final repo = ref.read(attendanceRepositoryProvider);
    
    // Optimistic Update
    final current = state.value ?? {};
    state = AsyncData({
      ...current, 
      slotIndex: AttendanceLog(subjectId: subjectId, status: status)
    });

    try {
      await repo.markAttendance(dateEpoch, slotIndex, subjectId, status);
      // Force refresh of stats
      ref.invalidate(attendanceStatsProvider);
    } catch (e) {
      // Revert on failure
      state = AsyncData(current);
      throw e;
    }
  }
  
  Future<void> markAll(String status) async {
     // We need the list of slots for this day to know what to mark.
     // Access the day to find day Order
     final dayRepo = ref.read(dayRepositoryProvider);
     final day = await dayRepo.getDay(dateEpoch);
     
     if (day == null || day.dayOrder == null) return;

    final timetableRepo = ref.read(timetableRepositoryProvider);
    final rawMap = await timetableRepo.getTimetableForDay(day.dayOrder!);
    
    if (rawMap.isEmpty) return;

    final repo = ref.read(attendanceRepositoryProvider);

    // Optimistic Update
    final current = state.value ?? {};
    final newMap = Map<int, AttendanceLog>.from(current);
    
    for (var entry in rawMap.entries) {
      newMap[entry.key] = AttendanceLog(subjectId: entry.value, status: status); 
    }
    state = AsyncData(newMap);

    // Batch DB Update
    try {
      for (var entry in rawMap.entries) {
        await repo.markAttendance(dateEpoch, entry.key, entry.value, status);
      }
      ref.invalidate(attendanceStatsProvider);
    } catch (e) {
      state = AsyncData(current); // Revert
      rethrow;
    }
  }
}
