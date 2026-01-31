import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../data/repositories/subject_repository_impl.dart';
import '../../data/repositories/timetable_repository_impl.dart';
import '../../data/seeds/data_seeder.dart';

part 'seed_provider.g.dart';

@riverpod
Future<void> seedDatabase(SeedDatabaseRef ref, int semesterId) async {
  final subjectRepo = ref.watch(subjectRepositoryProvider);
  final timetableRepo = ref.watch(timetableRepositoryProvider);
  
  final seeder = DataSeeder(subjectRepo, timetableRepo);
  await seeder.seedSemesterVI(semesterId);
}
