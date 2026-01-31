import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/entities/exam.dart';
import '../../domain/entities/subject.dart';
import '../../domain/repositories/exam_repository.dart';
import '../../data/repositories/exam_repository_impl.dart';
import '../../domain/providers/active_semester_provider.dart';

part 'exam_controller.g.dart';

@riverpod
class ExamController extends _$ExamController {
  @override
  Future<List<Exam>> build() async {
    final semester = await ref.watch(activeSemesterProvider.future);
    if (semester == null) return [];
    
    final repo = ref.watch(examRepositoryProvider);
    return await repo.getExamsForSemester(semester.id!);
  }

  Future<void> addExam(Exam exam) async {
    final repo = ref.read(examRepositoryProvider);
    await repo.createExam(exam);
    ref.invalidateSelf();
  }

  Future<void> deleteExam(int id) async {
    final repo = ref.read(examRepositoryProvider);
    await repo.deleteExam(id);
    ref.invalidateSelf();
  }

  Future<void> updateMarks(Exam exam, double obtainedMarks) async {
    final repo = ref.read(examRepositoryProvider);
    final updated = exam.copyWith(obtainedMarks: obtainedMarks);
    await repo.updateExam(updated);
    ref.invalidateSelf();
  }
}
