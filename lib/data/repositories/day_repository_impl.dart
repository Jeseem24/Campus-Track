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
      return AcademicDay.fromJson(results.first);
    }
    return null;
  }

  @override
  Future<List<AcademicDay>> getDaysForSemester(int semesterId) async {
    final results = await _db.queryBy('academic_days', 'semester_id = ?', [semesterId]);
    return results.map((e) => AcademicDay.fromJson(e)).toList();
  }
}
