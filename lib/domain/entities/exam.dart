import 'package:freezed_annotation/freezed_annotation.dart';

part 'exam.freezed.dart';
part 'exam.g.dart';

@freezed
class Exam with _$Exam {
  const factory Exam({
    int? id,
    @JsonKey(name: 'subject_id') required int subjectId,
    required String title, // e.g., "Cycle Test 1", "Semester Exam"
    required int date, // epoch
    @JsonKey(name: 'total_marks') required double totalMarks,
    @JsonKey(name: 'obtained_marks') double? obtainedMarks,
  }) = _Exam;

  factory Exam.fromJson(Map<String, dynamic> json) => _$ExamFromJson(json);
}
