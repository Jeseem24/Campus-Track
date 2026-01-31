// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subject.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SubjectImpl _$$SubjectImplFromJson(Map<String, dynamic> json) =>
    _$SubjectImpl(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String,
      code: json['code'] as String?,
      color: (json['color'] as num?)?.toInt() ?? 0xFF2196F3,
      credits: (json['credits'] as num?)?.toInt() ?? 3,
      semesterId: (json['semester_id'] as num).toInt(),
    );

Map<String, dynamic> _$$SubjectImplToJson(_$SubjectImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'code': instance.code,
      'color': instance.color,
      'credits': instance.credits,
      'semester_id': instance.semesterId,
    };
