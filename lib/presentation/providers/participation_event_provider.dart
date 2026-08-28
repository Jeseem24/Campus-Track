import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/entities/participation_event.dart';
import '../../data/repositories/participation_event_repository.dart';

part 'participation_event_provider.g.dart';

@riverpod
class ParticipationEventList extends _$ParticipationEventList {
  @override
  Future<List<ParticipationEvent>> build() async {
    final repo = ref.watch(participationEventRepositoryProvider);
    return await repo.getAllEvents();
  }

  Future<void> addEvent(ParticipationEvent event) async {
    final repo = ref.read(participationEventRepositoryProvider);
    await repo.createEvent(event);
    ref.invalidateSelf();
  }

  Future<void> deleteEvent(int id) async {
    final repo = ref.read(participationEventRepositoryProvider);
    await repo.deleteEvent(id);
    ref.invalidateSelf();
  }
}
