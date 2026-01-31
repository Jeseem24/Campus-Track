// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'academic_day.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AcademicDayImpl _$$AcademicDayImplFromJson(Map<String, dynamic> json) =>
    _$AcademicDayImpl(
      dateEpoch: (json['date_epoch'] as num).toInt(),
      semesterId: (json['semester_id'] as num).toInt(),
      isHoliday: boolFromInt((json['is_holiday'] as num).toInt()),
      dayOrder: (json['day_order'] as num?)?.toInt(),
      isManualOverride: json['is_manual_override'] == null
          ? false
          : boolFromInt((json['is_manual_override'] as num).toInt()),
      affectsFuture: json['affects_future'] == null
          ? false
          : boolFromInt((json['affects_future'] as num).toInt()),
      note: json['note'] as String?,
    );

Map<String, dynamic> _$$AcademicDayImplToJson(_$AcademicDayImpl instance) =>
    <String, dynamic>{
      'date_epoch': instance.dateEpoch,
      'semester_id': instance.semesterId,
      'is_holiday': intFromBool(instance.isHoliday),
      'day_order': instance.dayOrder,
      'is_manual_override': intFromBool(instance.isManualOverride),
      'affects_future': intFromBool(instance.affectsFuture),
      'note': instance.note,
    };
