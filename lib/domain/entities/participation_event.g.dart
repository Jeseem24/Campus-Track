// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'participation_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ParticipationEventImpl _$$ParticipationEventImplFromJson(
  Map<String, dynamic> json,
) => _$ParticipationEventImpl(
  id: (json['id'] as num?)?.toInt(),
  name: json['name'] as String,
  dateEpoch: (json['dateEpoch'] as num).toInt(),
  location: json['location'] as String?,
  description: json['description'] as String?,
);

Map<String, dynamic> _$$ParticipationEventImplToJson(
  _$ParticipationEventImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'dateEpoch': instance.dateEpoch,
  'location': instance.location,
  'description': instance.description,
};
