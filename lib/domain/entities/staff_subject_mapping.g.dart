// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'staff_subject_mapping.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$StaffSubjectMappingImpl _$$StaffSubjectMappingImplFromJson(
  Map<String, dynamic> json,
) => _$StaffSubjectMappingImpl(
  id: (json['id'] as num?)?.toInt(),
  staffName: json['staff_name'] as String,
  subjectId: (json['subject_id'] as num).toInt(),
  communicationStyle: json['communication_style'] as String?,
);

Map<String, dynamic> _$$StaffSubjectMappingImplToJson(
  _$StaffSubjectMappingImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'staff_name': instance.staffName,
  'subject_id': instance.subjectId,
  'communication_style': instance.communicationStyle,
};
