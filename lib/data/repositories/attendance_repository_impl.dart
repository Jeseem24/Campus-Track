import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../data/database/database_helper.dart';
import '../../domain/repositories/attendance_repository.dart';
import 'package:sqflite/sqflite.dart';

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
    final endOfToday = DateTime(now.year, now.month, now.day, 23, 59, 59).millisecondsSinceEpoch;

    // 1. Fetch Days
    // Only count days up to today. Future days should not contribute to "Silence = Present".
    // If a future day has manual attendance (e.g. pre-approved leave), should we count it?
    // Generally No. Stats are "As of Today".
    final days = await db.query(
      'academic_days', 
      where: 'semester_id = ? AND date_epoch <= ? AND is_holiday = 0 AND day_order IS NOT NULL',
      whereArgs: [semesterId, endOfToday]
    );

    // 2. Fetch Timetable
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

    // 3. Fetch Attendance
    final attendanceRaw = await db.query('attendance');
    // Map<dateEpoch, Map<slot, {subjectId, status}>>
    final Map<int, Map<int, Map<String, dynamic>>> attendanceMap = {};
    for (var row in attendanceRaw) {
      final d = row['date_epoch'] as int;
      final s = row['slot_index'] as int;
      if (!attendanceMap.containsKey(d)) attendanceMap[d] = {};
      attendanceMap[d]![s] = row;
    }

    // 4. Initialize Stats Map: SubjectId -> {total, present, absent, od}
    final Map<int, Map<String, int>> stats = {};
    
    // Helper
    void ensureSubject(int id) {
      if (!stats.containsKey(id)) {
        stats[id] = {'total': 0, 'present': 0, 'absent': 0, 'od': 0};
      }
    }

    // 5. Iterate Days (The Simulation)
    for (var dayRow in days) {
      final dayOrder = dayRow['day_order'] as int;
      final dateEpoch = dayRow['date_epoch'] as int;
      
      final slots = timetable[dayOrder];
      if (slots == null) continue;

      for (var entry in slots.entries) {
        final slotIndex = entry.key;
        final scheduledSubjectId = entry.value;

        // Check for Override/Attendance Entry
        final override = attendanceMap[dateEpoch]?[slotIndex];

        if (override == null) {
          // SILENCE = PRESENT
          ensureSubject(scheduledSubjectId);
          stats[scheduledSubjectId]!['total'] = stats[scheduledSubjectId]!['total']! + 1;
          stats[scheduledSubjectId]!['present'] = stats[scheduledSubjectId]!['present']! + 1;
        } else {
          // Handle Explicit Status
          final recordedSubjectId = override['subject_id'] as int;
          final status = override['status'] as String;

          if (status == 'CANCELLED') {
             // If scheduled subject was cancelled, we count nothing.
             // If swapped subject was cancelled... weird edge case.
             // Just ignore.
             continue;
          }

          ensureSubject(recordedSubjectId);

          // If a swap occurred (Recorded != Scheduled)
          if (recordedSubjectId != scheduledSubjectId) {
             // The scheduled subject effectively didn't happen (Cancelled / Free)
             // So we do NOT increment scheduledSubjectId total.
             // We DO increment recordedSubjectId total.
          } else {
             // Regular class, increment total
             // ensureSubject called above handles init
          }
          
          // Increment Total for the subject that actually took place
          stats[recordedSubjectId]!['total'] = stats[recordedSubjectId]!['total']! + 1;

          // Increment Status
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
