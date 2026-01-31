import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../data/database/database_helper.dart';
import '../../domain/entities/semester.dart';
import '../../domain/repositories/semester_repository.dart';

part 'semester_repository_impl.g.dart';

@riverpod
SemesterRepository semesterRepository(SemesterRepositoryRef ref) {
  return SemesterRepositoryImpl(DatabaseHelper.instance);
}

class SemesterRepositoryImpl implements SemesterRepository {
  final DatabaseHelper _db;

  SemesterRepositoryImpl(this._db);

  @override
  Future<Semester?> getActiveSemester() async {

    final results = await _db.queryBy('semesters', 'is_active = ?', [1]);

    if (results.isNotEmpty) {
      return Semester.fromJson(results.first);
    }
    return null;
  }

  @override
  Future<List<Semester>> getAllSemesters() async {
    final results = await _db.queryAll('semesters');
    return results.map((e) => Semester.fromJson(e)).toList();
  }

  @override
  Future<int> createSemester(Semester semester) async {
    // Determine status: If no active semester exists, this one is active.
    // If one exists, we might want to deactivate it? 
    // For now, simple insert.
    return await _db.insert('semesters', semester.toJson());
  }

  @override
  Future<void> updateSemester(Semester semester) async {
    final db = await _db.database;
    await db.update(
      'semesters',
      semester.toJson(),
      where: 'id = ?',
      whereArgs: [semester.id],
    );
  }

  @override
  Future<void> deleteSemester(int id) async {
    final db = await _db.database;
    await db.delete('semesters', where: 'id = ?', whereArgs: [id]);
  }
}
