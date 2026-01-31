import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/entities/academic_result.dart';
import '../../data/repositories/academic_result_repository.dart';

part 'bgpa_controller.g.dart';

@riverpod
class BGPAController extends _$BGPAController {
  @override
  Future<List<AcademicResult>> build() async {
    final repo = ref.watch(academicResultRepositoryProvider);
    return await repo.getAllResults();
  }

  Future<void> addResult(String semesterName, double gpa, double credits) async {
    final repo = ref.read(academicResultRepositoryProvider);
    final result = AcademicResult(
      semesterName: semesterName,
      gpa: gpa,
      totalCredits: credits,
    );
    await repo.addResult(result);
    ref.invalidateSelf();
  }

  Future<void> deleteResult(int id) async {
    final repo = ref.read(academicResultRepositoryProvider);
    await repo.deleteResult(id);
    ref.invalidateSelf();
  }

  double calculateCGPA(List<AcademicResult> results) {
    if (results.isEmpty) return 0.0;
    
    double totalPoints = 0;
    double totalCredits = 0;

    for (var r in results) {
      totalPoints += (r.gpa * r.totalCredits);
      totalCredits += r.totalCredits;
    }

    if (totalCredits == 0) return 0.0;
    return totalPoints / totalCredits;
  }
}
