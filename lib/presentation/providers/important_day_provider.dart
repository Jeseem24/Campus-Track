import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/entities/important_day.dart';
import '../../data/repositories/important_day_repository.dart';

part 'important_day_provider.g.dart';

@riverpod
class ImportantDayList extends _$ImportantDayList {
  @override
  Future<List<ImportantDay>> build() async {
    final repo = ref.watch(importantDayRepositoryProvider);
    return await repo.getUpcomingImportantDays();
  }

  Future<void> addImportantDay(ImportantDay day) async {
    final repo = ref.read(importantDayRepositoryProvider);
    await repo.createImportantDay(day);
    ref.invalidateSelf();
  }

  Future<void> deleteImportantDay(int id) async {
    final repo = ref.read(importantDayRepositoryProvider);
    await repo.deleteImportantDay(id);
    ref.invalidateSelf();
  }
}
