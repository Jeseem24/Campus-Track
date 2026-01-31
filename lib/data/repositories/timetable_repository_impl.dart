import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sqflite/sqflite.dart';
import '../../data/database/database_helper.dart';
import '../../domain/repositories/timetable_repository.dart';

part 'timetable_repository_impl.g.dart';

@riverpod
TimetableRepository timetableRepository(TimetableRepositoryRef ref) {
  return TimetableRepositoryImpl(DatabaseHelper.instance);
}

class TimetableRepositoryImpl implements TimetableRepository {
  final DatabaseHelper _db;

  TimetableRepositoryImpl(this._db);

  @override
  Future<Map<int, int>> getTimetableForDay(int dayOrder) async {
    final results = await _db.queryBy('timetable', 'day_order = ?', [dayOrder]);
    final Map<int, int> timetable = {};
    for (var row in results) {
      timetable[row['slot_index'] as int] = row['subject_id'] as int;
    }
    return timetable;
  }

  @override
  Future<void> assignSlot(int dayOrder, int slotIndex, int subjectId) async {
    final db = await _db.database;
    await db.insert(
      'timetable',
      {
        'day_order': dayOrder,
        'slot_index': slotIndex,
        'subject_id': subjectId,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<void> clearSlot(int dayOrder, int slotIndex) async {
    final db = await _db.database;
    await db.delete(
      'timetable',
      where: 'day_order = ? AND slot_index = ?',
      whereArgs: [dayOrder, slotIndex],
    );
  }

  @override
  Future<void> clearDay(int dayOrder) async {
    final db = await _db.database;
    await db.delete(
      'timetable',
      where: 'day_order = ?',
      whereArgs: [dayOrder],
    );
  }
}
