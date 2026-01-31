import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../data/database/database_helper.dart';
import '../../domain/entities/exam.dart';
import '../../domain/repositories/exam_repository.dart';

part 'exam_repository_impl.g.dart';

@riverpod
ExamRepository examRepository(ExamRepositoryRef ref) {
  return ExamRepositoryImpl(DatabaseHelper.instance);
}

class ExamRepositoryImpl implements ExamRepository {
  final DatabaseHelper _db;
  ExamRepositoryImpl(this._db);

  @override
  Future<int> createExam(Exam exam) async {
    return await _db.insert('exams', exam.toJson());
  }

  @override
  Future<void> updateExam(Exam exam) async {
    final db = await _db.database;
    await db.update('exams', exam.toJson(), where: 'id = ?', whereArgs: [exam.id]);
  }

  @override
  Future<void> deleteExam(int id) async {
    final db = await _db.database;
    await db.delete('exams', where: 'id = ?', whereArgs: [id]);
  }

  @override
  Future<List<Exam>> getExamsForSemester(int semesterId) async {
    final db = await _db.database;
    // Join with subjects to filter by semester
    final results = await db.rawQuery('''
      SELECT e.* FROM exams e
      INNER JOIN subjects s ON e.subject_id = s.id
      WHERE s.semester_id = ?
      ORDER BY e.date ASC
    ''', [semesterId]);
    
    return results.map((e) => Exam.fromJson(e)).toList();
  }

  @override
  Future<List<Exam>> getExamsForSubject(int subjectId) async {
    final results = await _db.queryBy('exams', 'subject_id = ?', [subjectId]);
    return results.map((e) => Exam.fromJson(e)).toList();
  }
}
