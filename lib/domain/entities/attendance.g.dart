// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attendance.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AttendanceImpl _$$AttendanceImplFromJson(Map<String, dynamic> json) =>
    _$AttendanceImpl(
      dateEpoch: (json['date_epoch'] as num).toInt(),
      subjectId: (json['subject_id'] as num).toInt(),
      status:
          $enumDecodeNullable(_$AttendanceStatusEnumMap, json['status']) ??
          AttendanceStatus.present,
    );

Map<String, dynamic> _$$AttendanceImplToJson(_$AttendanceImpl instance) =>
    <String, dynamic>{
      'date_epoch': instance.dateEpoch,
      'subject_id': instance.subjectId,
      'status': _$AttendanceStatusEnumMap[instance.status]!,
    };

const _$AttendanceStatusEnumMap = {
  AttendanceStatus.present: 'PRESENT',
  AttendanceStatus.absent: 'ABSENT',
  AttendanceStatus.onDuty: 'OD',
  AttendanceStatus.cancelled: 'CANCELLED',
};
