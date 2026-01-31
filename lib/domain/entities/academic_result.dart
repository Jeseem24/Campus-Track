import 'package:freezed_annotation/freezed_annotation.dart';

part 'academic_result.freezed.dart';
part 'academic_result.g.dart';

@freezed
class AcademicResult with _$AcademicResult {
  const factory AcademicResult({
    int? id,
    required String semesterName, // e.g., "Semester 1"
    required double gpa,
    required double totalCredits,
  }) = _AcademicResult;

  factory AcademicResult.fromJson(Map<String, dynamic> json) => _$AcademicResultFromJson(json);
}
