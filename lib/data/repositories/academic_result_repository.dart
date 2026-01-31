import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../data/database/database_helper.dart';
import '../../domain/entities/academic_result.dart';

part 'academic_result_repository.g.dart';

@riverpod
AcademicResultRepository academicResultRepository(AcademicResultRepositoryRef ref) {
  return AcademicResultRepository(DatabaseHelper.instance);
}

class AcademicResultRepository {
  final DatabaseHelper _db;

  AcademicResultRepository(this._db);

  Future<List<AcademicResult>> getAllResults() async {
    final results = await _db.queryAll('academic_results');
    return results.map((e) => AcademicResult.fromJson(e)).toList();
  }

  Future<void> addResult(AcademicResult result) async {
    await _db.insert('academic_results', result.toJson());
  }

  Future<void> deleteResult(int id) async {
    final db = await _db.database;
    await db.delete('academic_results', where: 'id = ?', whereArgs: [id]);
  }
}
