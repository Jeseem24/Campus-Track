import 'package:freezed_annotation/freezed_annotation.dart';

part 'subject.freezed.dart';
part 'subject.g.dart';

@freezed
class Subject with _$Subject {
  const factory Subject({
    int? id,
    required String name,
    String? code,
    @Default(0xFF2196F3) int color, // Default Blue
    @Default(3) int credits,
    @JsonKey(name: 'semester_id') required int semesterId,
  }) = _Subject;

  factory Subject.fromJson(Map<String, dynamic> json) => _$SubjectFromJson(json);
}
