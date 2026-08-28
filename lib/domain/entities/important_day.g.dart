// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'important_day.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ImportantDayImpl _$$ImportantDayImplFromJson(Map<String, dynamic> json) =>
    _$ImportantDayImpl(
      id: (json['id'] as num?)?.toInt(),
      title: json['title'] as String,
      description: json['description'] as String?,
      dateEpoch: (json['dateEpoch'] as num).toInt(),
    );

Map<String, dynamic> _$$ImportantDayImplToJson(_$ImportantDayImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'dateEpoch': instance.dateEpoch,
    };
