import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/entities/semester.dart';
import '../../domain/repositories/semester_repository.dart';
import '../../data/repositories/semester_repository_impl.dart';

part 'active_semester_provider.g.dart';

@riverpod
Future<Semester?> activeSemester(ActiveSemesterRef ref) async {

  final repo = ref.watch(semesterRepositoryProvider);
  final sem = await repo.getActiveSemester();

  return sem;
}
