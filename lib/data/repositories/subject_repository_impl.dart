import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sqflite/sqflite.dart';
import '../../data/database/database_helper.dart';
import '../../domain/entities/subject.dart';
import '../../domain/repositories/subject_repository.dart';

part 'subject_repository_impl.g.dart';

@riverpod
SubjectRepository subjectRepository(SubjectRepositoryRef ref) {
  return SubjectRepositoryImpl(DatabaseHelper.instance);
}

class SubjectRepositoryImpl implements SubjectRepository {
  final DatabaseHelper _db;

  SubjectRepositoryImpl(this._db);

  @override
  Future<List<Subject>> getSubjectsForSemester(int semesterId) async {
    final results = await _db.queryBy('subjects', 'semester_id = ?', [semesterId]);
    return results.map((e) => Subject.fromJson(e)).toList();
  }

  @override
  Future<Subject?> getSubject(int id) async {
    final results = await _db.queryBy('subjects', 'id = ?', [id]);
    if (results.isNotEmpty) {
      return Subject.fromJson(results.first);
    }
    return null;
  }

  @override
  Future<int> createSubject(Subject subject) async {
    return await _db.insert('subjects', subject.toJson());
  }

  @override
  Future<void> updateSubject(Subject subject) async {
    final db = await _db.database;
    await db.update(
      'subjects',
      subject.toJson(),
      where: 'id = ?',
      whereArgs: [subject.id],
    );
  }

  @override
  Future<void> deleteSubject(int id) async {
    final db = await _db.database;
    await db.delete('subjects', where: 'id = ?', whereArgs: [id]);
  }
}
