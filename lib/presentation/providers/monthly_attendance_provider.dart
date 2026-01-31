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

    int presentCount = 0;
    int absentCount = 0;
    int odCount = 0;

    // We only care about slots that actually exist in the timetable?
    // Or we stick to the records? 
    // Records override timetable.
    // If a record exists, we count it.
    // But we also need to account for implicit presents (slots not in records).
    
    // Iterate expected slots
    for (int i = 1; i <= totalSlots; i++) { // Assuming slots are 1-indexed?
       // Let's check timetable query. Timetable usually keyed by slot_index. 
       // We'll assume slot indices match what's in DB.
       // Actually, we should iterate the known slot indices for this day order, but for simplicity let's rely on counts if simple.
       // Attendance record keys matching slot indices.
    }
    
    // Precise way:
    // Count explicit Absent/OD.
    // Present = Total - (Absent + OD).
    
    dayRecords.forEach((slot, status) {
       if (status == 'ABSENT') absentCount++;
       if (status == 'OD') odCount++;
    });

    if (absentCount == totalSlots) {
      result[dateEpoch] = DayAttendanceStatus.fullAbsent;
    } else if (absentCount > 0) {
      result[dateEpoch] = DayAttendanceStatus.partial;
    } else {
      result[dateEpoch] = DayAttendanceStatus.fullPresent;
    }
  }

  return result;
}
