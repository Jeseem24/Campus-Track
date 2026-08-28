import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../data/database/database_helper.dart';
import '../../domain/entities/participation_event.dart';

part 'participation_event_repository.g.dart';

@riverpod
ParticipationEventRepository participationEventRepository(ParticipationEventRepositoryRef ref) {
  return ParticipationEventRepository(DatabaseHelper.instance);
}

class ParticipationEventRepository {
  final DatabaseHelper _db;

  ParticipationEventRepository(this._db);

  Future<int> createEvent(ParticipationEvent event) async {
    return await _db.insert('participation_events', event.toJson());
  }

  Future<List<ParticipationEvent>> getAllEvents() async {
    final db = await _db.database;
    final results = await db.query('participation_events', orderBy: 'date_epoch DESC');
    return results.map((e) => ParticipationEvent.fromJson(e)).toList();
  }

  Future<void> deleteEvent(int id) async {
    final db = await _db.database;
    await db.delete('participation_events', where: 'id = ?', whereArgs: [id]);
  }
}
