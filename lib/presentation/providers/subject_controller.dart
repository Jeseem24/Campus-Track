import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/entities/subject.dart';
import '../../domain/repositories/subject_repository.dart';
import '../../data/repositories/subject_repository_impl.dart';
import '../../domain/providers/active_semester_provider.dart';

import '../../domain/providers/all_subjects_provider.dart';

part 'subject_controller.g.dart';

@riverpod
class SubjectController extends _$SubjectController {
  @override
  Future<List<Subject>> build() async {
    final semester = await ref.watch(activeSemesterProvider.future);
    if (semester == null) return [];
    
    final repo = ref.watch(subjectRepositoryProvider);
    return await repo.getSubjectsForSemester(semester.id!);
  }

  Future<void> addSubject(String name, String code, int color, int credits) async {
    final semester = await ref.read(activeSemesterProvider.future);
    if (semester == null) return;

    final repo = ref.read(subjectRepositoryProvider);
    final subject = Subject(
      name: name,
      code: code,
      color: color,
      credits: credits,
      semesterId: semester.id!,
    );
    
    await repo.createSubject(subject);
    ref.invalidateSelf();
    ref.invalidate(allSubjectsProvider);
  }

  Future<void> updateSubject(Subject subject) async {
    final repo = ref.read(subjectRepositoryProvider);
    await repo.updateSubject(subject);
    ref.invalidateSelf();
    ref.invalidate(allSubjectsProvider);
  }

  Future<void> deleteSubject(int id) async {
    final repo = ref.read(subjectRepositoryProvider);
    await repo.deleteSubject(id);
    ref.invalidateSelf();
    ref.invalidate(allSubjectsProvider);
  }
}
