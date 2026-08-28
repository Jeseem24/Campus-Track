import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../data/database/database_helper.dart';
import '../../domain/entities/important_day.dart';

part 'important_day_repository.g.dart';

@riverpod
ImportantDayRepository importantDayRepository(ImportantDayRepositoryRef ref) {
  return ImportantDayRepository(DatabaseHelper.instance);
}

class ImportantDayRepository {
  final DatabaseHelper _db;

  ImportantDayRepository(this._db);

  Future<int> createImportantDay(ImportantDay day) async {
    return await _db.insert('important_days', day.toJson());
  }

  Future<List<ImportantDay>> getAllImportantDays() async {
    final db = await _db.database;
    final results = await db.query('important_days', orderBy: 'date_epoch ASC');
    return results.map((e) => ImportantDay.fromJson(e)).toList();
  }

  Future<List<ImportantDay>> getUpcomingImportantDays() async {
    final db = await _db.database;
    final now = DateTime.now().millisecondsSinceEpoch;
    final results = await db.query(
      'important_days', 
      where: 'date_epoch >= ?', 
      whereArgs: [now],
      orderBy: 'date_epoch ASC'
    );
    return results.map((e) => ImportantDay.fromJson(e)).toList();
  }

  Future<void> deleteImportantDay(int id) async {
    final db = await _db.database;
    await db.delete('important_days', where: 'id = ?', whereArgs: [id]);
  }
}
