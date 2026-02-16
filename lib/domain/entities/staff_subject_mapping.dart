import 'package:freezed_annotation/freezed_annotation.dart';

part 'staff_subject_mapping.freezed.dart';
part 'staff_subject_mapping.g.dart';

@freezed
class StaffSubjectMapping with _$StaffSubjectMapping {
  const factory StaffSubjectMapping({
    @JsonKey(name: 'id') int? id,
    @JsonKey(name: 'staff_name') required String staffName,
    @JsonKey(name: 'subject_id') required int subjectId,
    @JsonKey(name: 'communication_style') String? communicationStyle,
  }) = _StaffSubjectMapping;

  factory StaffSubjectMapping.fromJson(Map<String, dynamic> json) => 
      _$StaffSubjectMappingFromJson(json);
}
