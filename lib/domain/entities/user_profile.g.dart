// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserProfileImpl _$$UserProfileImplFromJson(Map<String, dynamic> json) =>
    _$UserProfileImpl(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String,
      semester: (json['semester'] as num).toInt(),
      department: json['department'] as String,
      section: json['section'] as String?,
      collegeName: json['college_name'] as String?,
      wakeTime: json['wake_time'] as String?,
      sleepTime: json['sleep_time'] as String?,
      preferredStudyHours: (json['preferred_study_hours'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$UserProfileImplToJson(_$UserProfileImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'semester': instance.semester,
      'department': instance.department,
      'section': instance.section,
      'college_name': instance.collegeName,
      'wake_time': instance.wakeTime,
      'sleep_time': instance.sleepTime,
      'preferred_study_hours': instance.preferredStudyHours,
    };
