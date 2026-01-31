// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'academic_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AcademicResultImpl _$$AcademicResultImplFromJson(Map<String, dynamic> json) =>
    _$AcademicResultImpl(
      id: (json['id'] as num?)?.toInt(),
      semesterName: json['semesterName'] as String,
      gpa: (json['gpa'] as num).toDouble(),
      totalCredits: (json['totalCredits'] as num).toDouble(),
    );

Map<String, dynamic> _$$AcademicResultImplToJson(
  _$AcademicResultImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'semesterName': instance.semesterName,
  'gpa': instance.gpa,
  'totalCredits': instance.totalCredits,
};
