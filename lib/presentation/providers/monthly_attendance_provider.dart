import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../data/database/database_helper.dart';
import '../../data/repositories/day_repository_impl.dart';
import '../../data/repositories/attendance_repository_impl.dart';

part 'monthly_attendance_provider.g.dart';

enum DayAttendanceStatus {
  fullPresent,
  fullAbsent,
  partial,
  none, // Holiday or No Classes
}

@riverpod
Future<Map<int, DayAttendanceStatus>> monthlyAttendanceStatus(MonthlyAttendanceStatusRef ref, DateTime monthKey) async {
  // 1. Get Range
  final start = DateTime(monthKey.year, monthKey.month, 1).millisecondsSinceEpoch;
  final end = DateTime(monthKey.year, monthKey.month + 1, 0, 23, 59, 59).millisecondsSinceEpoch;

  final db = await DatabaseHelper.instance.database;

  // 2. Fetch Days in Month
  final daysRaw = await db.query(
    'academic_days',
    where: 'date_epoch >= ? AND date_epoch <= ? AND is_holiday = 0 AND day_order IS NOT NULL',
    whereArgs: [start, end]
  );

  // 3. Fetch Timetable (Cache)
  final timetableRaw = await db.query('timetable');
  final Map<int, int> slotsPerOrder = {}; // dayOrder -> count
  for (var r in timetableRaw) {
    final d = r['day_order'] as int;
    slotsPerOrder[d] = (slotsPerOrder[d] ?? 0) + 1;
  }

  // 4. Fetch Attendance for Month
  // We can fetch all attendance records for this range
  final attendanceRaw = await db.query(
    'attendance',
    where: 'date_epoch >= ? AND date_epoch <= ?',
    whereArgs: [start, end]
  );
  
  // Group by Date -> {slot: status}
  final Map<int, Map<int, String>> attendanceMap = {};
  for (var r in attendanceRaw) {
    final d = r['date_epoch'] as int;
    final s = r['slot_index'] as int;
    final stat = r['status'] as String;
    
    if (!attendanceMap.containsKey(d)) attendanceMap[d] = {};
    attendanceMap[d]![s] = stat;
  }

  final Map<int, DayAttendanceStatus> result = {};

  // 5. Calculate Status per Day
  for (var d in daysRaw) {
    final dateEpoch = d['date_epoch'] as int;
    final dayOrder = d['day_order'] as int;
    
    final totalSlots = slotsPerOrder[dayOrder] ?? 0;
    if (totalSlots == 0) {
      result[dateEpoch] = DayAttendanceStatus.none;
      continue;
    }

    final dayRecords = attendanceMap[dateEpoch];
    
    // Silence = Present
    if (dayRecords == null || dayRecords.isEmpty) {
      result[dateEpoch] = DayAttendanceStatus.fullPresent;
      continue;
    }

    // Count all statuses properly
    int presentCount = 0;
    int absentCount = 0;
    int odCount = 0;
    int cancelledCount = 0;
    
    // We need to check all expected slots for this day order
    // Get the actual slots from timetable for this day order
    final daySlots = timetableRaw
        .where((r) => r['day_order'] as int == dayOrder)
        .map((r) => r['slot_index'] as int)
        .toList();
    
    for (var slotIndex in daySlots) {
      final status = dayRecords[slotIndex];
      
      if (status == null) {
        // No record = default present
        presentCount++;
      } else {
        switch (status) {
          case 'PRESENT':
            presentCount++;
            break;
          case 'ABSENT':
            absentCount++;
            break;
          case 'OD':
            odCount++;
            break;
          case 'CANCELLED':
            cancelledCount++;
            break;
        }
      }
    }
    
    // Calculate effective slots (exclude cancelled)
    final effectiveSlots = daySlots.length - cancelledCount;
    if (effectiveSlots == 0) {
      result[dateEpoch] = DayAttendanceStatus.none;
      continue;
    }

    // Determine status based on counts
    if (absentCount == effectiveSlots) {
      result[dateEpoch] = DayAttendanceStatus.fullAbsent;
    } else if (absentCount > 0) {
      result[dateEpoch] = DayAttendanceStatus.partial;
    } else {
      // All are present or OD
      result[dateEpoch] = DayAttendanceStatus.fullPresent;
    }
  }

  return result;
}
