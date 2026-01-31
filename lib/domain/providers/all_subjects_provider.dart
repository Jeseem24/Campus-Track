import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../entities/subject.dart';
import '../repositories/subject_repository.dart';
import '../../data/repositories/subject_repository_impl.dart';
import '../providers/active_semester_provider.dart';

part 'all_subjects_provider.g.dart';

@riverpod
Future<List<Subject>> allSubjects(AllSubjectsRef ref) async {
  final semester = await ref.watch(activeSemesterProvider.future);
  if (semester == null) return [];
  
  final repo = ref.watch(subjectRepositoryProvider);
  return await repo.getSubjectsForSemester(semester.id!);
}
