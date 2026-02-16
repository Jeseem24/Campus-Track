// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ai_suggestion.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AISuggestionImpl _$$AISuggestionImplFromJson(Map<String, dynamic> json) =>
    _$AISuggestionImpl(
      id: (json['id'] as num?)?.toInt(),
      title: json['title'] as String,
      description: json['description'] as String,
      type: $enumDecode(_$SuggestionTypeEnumMap, json['type']),
      createdAtEpoch: (json['created_at'] as num).toInt(),
      dismissed: json['dismissed'] as bool? ?? false,
      actionTaken: json['action_taken'] as bool? ?? false,
    );

Map<String, dynamic> _$$AISuggestionImplToJson(_$AISuggestionImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'type': _$SuggestionTypeEnumMap[instance.type]!,
      'created_at': instance.createdAtEpoch,
      'dismissed': instance.dismissed,
      'action_taken': instance.actionTaken,
    };

const _$SuggestionTypeEnumMap = {
  SuggestionType.studyTime: 'studyTime',
  SuggestionType.priorityAlert: 'priorityAlert',
  SuggestionType.workloadWarning: 'workloadWarning',
  SuggestionType.attendanceAlert: 'attendanceAlert',
  SuggestionType.examPrep: 'examPrep',
};
