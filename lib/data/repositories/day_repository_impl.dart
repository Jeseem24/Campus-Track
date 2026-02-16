import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sqflite/sqflite.dart';
import '../../data/database/database_helper.dart';
import '../../domain/entities/academic_day.dart';
import '../../domain/repositories/day_repository.dart';

part 'day_repository_impl.g.dart';

@riverpod
DayRepository dayRepository(DayRepositoryRef ref) {
  return DayRepositoryImpl(DatabaseHelper.instance);
}

class DayRepositoryImpl implements DayRepository {
  final DatabaseHelper _db;

  DayRepositoryImpl(this._db);

  @override
  Future<void> saveDay(AcademicDay day) async {
    final db = await _db.database;
    // contentValues without nulls where possible, but here we want to save exactly what we have.
    // We use REPLACE or INSERT OR REPLACE logic.
    await db.insert(
      'academic_days',
      day.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<AcademicDay?> getDay(int dateEpoch) async {
    final results = await _db.queryBy('academic_days', 'date_epoch = ?', [dateEpoch]);
    if (results.isNotEmpty) {
      final day = AcademicDay.fromJson(results.first);
      print('getDay($dateEpoch) -> Found: Order=${day.dayOrder}, Manual=${day.isManualOverride}');
      return day;
    }
    print('getDay($dateEpoch) -> Not Found');
    return null;
  }

  @override
  Future<List<AcademicDay>> getDaysForSemester(int semesterId) async {
    final results = await _db.queryBy('academic_days', 'semester_id = ?', [semesterId]);
    return results.map((e) => AcademicDay.fromJson(e)).toList();
  }

  @override
  Future<void> deleteFutureComputedDays(int afterDateEpoch, int semesterId) async {
    final db = await _db.database;
    final count = await db.delete(
      'academic_days',
      where: 'date_epoch > ? AND semester_id = ? AND (is_manual_override = 0 OR (is_manual_override = 1 AND (note IS NULL OR note = "")))',
      whereArgs: [afterDateEpoch, semesterId],
    );
    print('Deleted $count days (computed + soft overrides) after $afterDateEpoch');
  }
}
