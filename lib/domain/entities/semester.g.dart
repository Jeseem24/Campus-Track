// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'semester.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SemesterImpl _$$SemesterImplFromJson(Map<String, dynamic> json) =>
    _$SemesterImpl(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String,
      startDate: (json['start_date'] as num).toInt(),
      endDate: (json['end_date'] as num).toInt(),
      isActive: json['is_active'] == null
          ? true
          : boolFromInt((json['is_active'] as num).toInt()),
    );

Map<String, dynamic> _$$SemesterImplToJson(_$SemesterImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'start_date': instance.startDate,
      'end_date': instance.endDate,
      'is_active': intFromBool(instance.isActive),
    };
