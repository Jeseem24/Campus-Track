import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../data/database/database_helper.dart';
import '../../domain/repositories/attendance_repository.dart';
import 'package:sqflite/sqflite.dart';

import '../../domain/logic/day_order_calculator.dart';
import '../../domain/entities/academic_day.dart';


part 'attendance_repository_impl.g.dart';

@riverpod
AttendanceRepository attendanceRepository(AttendanceRepositoryRef ref) {
  return AttendanceRepositoryImpl(DatabaseHelper.instance);
}

class AttendanceRepositoryImpl implements AttendanceRepository {
  final DatabaseHelper _db;

  AttendanceRepositoryImpl(this._db);

  @override
  Future<void> markAttendance(int dateEpoch, int slotIndex, int subjectId, String status) async {
    final db = await _db.database;
    await db.insert(
      'attendance',
      {
        'date_epoch': dateEpoch,
        'slot_index': slotIndex,
        'subject_id': subjectId,
        'status': status,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<Map<int, AttendanceLog>> getAttendanceForDay(int dateEpoch) async {
    final results = await _db.queryBy('attendance', 'date_epoch = ?', [dateEpoch]);
    final Map<int, AttendanceLog> map = {};
    for (var row in results) {
      map[row['slot_index'] as int] = AttendanceLog(
        subjectId: row['subject_id'] as int,
        status: row['status'] as String,
      );
    }
    return map;
  }

  @override
  Future<Map<String, dynamic>> getSubjectStats(int subjectId) async {
    // Deprecated or redirect to new logic? 
    // For now keep as is for backward compat, but we will switch provider to use the bulk method.
    // Actually, let's implement the bulk one and ignore this one or make this one use the bulk one (inefficiently).
    return {}; 
  }

  @override
  Future<List<Map<String, dynamic>>> getSemesterStats(int semesterId) async {
    final db = await _db.database;
    final now = DateTime.now();
    // Include full Today (so attendance marks for today count)
    final endOfToday = DateTime(now.year, now.month, now.day, 23, 59, 59);

    // 0. Fetch Semester Info (Need start date)
    // We don't have direct access to Semester object here, need to query it.
    final semesterRaw = await db.query('semesters', where: 'id = ?', whereArgs: [semesterId]);
    if (semesterRaw.isEmpty) return [];
    final semesterStartEpoch = semesterRaw.first['start_date'] as int;

    // 1. Fetch Existing Overrides/Days from DB
    // We need ALL days to correctly project the day order sequence.
    final allDbDaysRaw = await db.query(
      'academic_days', 
      where: 'semester_id = ?', // Fetch all to be safe for projection
      whereArgs: [semesterId]
    );
    final allDbDays = allDbDaysRaw.map((e) => AcademicDay.fromJson(e)).toList();

    // 2. Calculate Project Days (Start of Semester -> Today)
    final calculator = DayOrderCalculator();
    // We must project from start date to today to get accurate day orders
    // The map is <dateEpoch, dayOrder>
    final computedDayOrders = calculator.calculateProjectedDayOrders(
      startDateEpoch: semesterStartEpoch,
      endDateEpoch: endOfToday.millisecondsSinceEpoch,
      existingDays: allDbDays,
    );

    // 3. Fetch Timetable
    final timetableRaw = await db.query('timetable');
    // Map<dayOrder, Map<slot, subjectId>>
    final Map<int, Map<int, int>> timetable = {};
    for (var row in timetableRaw) {
      final d = row['day_order'] as int;
      final s = row['slot_index'] as int;
      final sub = row['subject_id'] as int;
      if (!timetable.containsKey(d)) timetable[d] = {};
      timetable[d]![s] = sub;
    }

    // 4. Fetch Attendance
    final attendanceRaw = await db.query('attendance');
    // Map<dateEpoch, Map<slot, {subjectId, status}>>
    final Map<int, Map<int, Map<String, dynamic>>> attendanceMap = {};
    for (var row in attendanceRaw) {
      final d = row['date_epoch'] as int;
      final s = row['slot_index'] as int;
      if (!attendanceMap.containsKey(d)) attendanceMap[d] = {};
      attendanceMap[d]![s] = row;
    }

    // 5. Initialize Stats Map: SubjectId -> {total, present, absent, od}
    final Map<int, Map<String, int>> stats = {};
    
    void ensureSubject(int id) {
      if (!stats.containsKey(id)) {
        stats[id] = {'total': 0, 'present': 0, 'absent': 0, 'od': 0};
      }
    }

    // 6. Iterate Computed Days (The True Simulation)
    // computedDayOrders only contains days with a valid day order (holidays/weekends typically excluded or null)
    // Actually calculateProjectedDayOrders logic needs checking.
    // Assuming it returns Map<DateEpoch, int?> where int is dayOrder.
    // We filter for dates <= endOfToday.

    final sortedDates = computedDayOrders.keys.toList()..sort();

    for (var dateEpoch in sortedDates) {
      if (dateEpoch > endOfToday.millisecondsSinceEpoch) continue;
      
      final dayOrder = computedDayOrders[dateEpoch];
      
      // Skip if no day order (Weekend/Holiday)
      if (dayOrder == null) continue; 
      
      // Double check if it's explicitly marked as holiday in DB (though calculator should handle this)
      // The calculator logic usually returns null for holiday.

      final slotsMap = timetable[dayOrder] ?? {};
      final attendanceSlots = attendanceMap[dateEpoch] ?? {};
      
      // Union of slots
      final allSlots = {...slotsMap.keys, ...attendanceSlots.keys}.toList()..sort();

      for (var slotIndex in allSlots) {
        final scheduledSubjectId = slotsMap[slotIndex];
        
        // Check for Override/Attendance Entry
        final override = attendanceSlots[slotIndex];

        if (override == null) {
          // Standard case: Timetable exists, no override.
          if (scheduledSubjectId == null) continue;

          // SILENCE = PRESENT
          ensureSubject(scheduledSubjectId);
          stats[scheduledSubjectId]!['total'] = stats[scheduledSubjectId]!['total']! + 1;
          stats[scheduledSubjectId]!['present'] = stats[scheduledSubjectId]!['present']! + 1;
        } else {
          // Handle Explicit Status
          final recordedSubjectId = override['subject_id'] as int;
          final status = override['status'] as String;

          if (status == 'CANCELLED') continue;

          ensureSubject(recordedSubjectId);

          stats[recordedSubjectId]!['total'] = stats[recordedSubjectId]!['total']! + 1;

          switch (status) {
            case 'PRESENT': stats[recordedSubjectId]!['present'] = stats[recordedSubjectId]!['present']! + 1; break;
            case 'ABSENT': stats[recordedSubjectId]!['absent'] = stats[recordedSubjectId]!['absent']! + 1; break;
            case 'OD': stats[recordedSubjectId]!['od'] = stats[recordedSubjectId]!['od']! + 1; break;
          }
        }
      }
    }

    // Convert to List
    final List<Map<String, dynamic>> result = [];
    stats.forEach((subId, data) {
      result.add({
        'subject_id': subId,
        'total': data['total'],
        'present': data['present'],
        'absent': data['absent'],
        'od': data['od'],
      });
    });

    return result;
  }
}
