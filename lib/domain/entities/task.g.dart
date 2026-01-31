// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TaskImpl _$$TaskImplFromJson(Map<String, dynamic> json) => _$TaskImpl(
  id: (json['id'] as num?)?.toInt(),
  title: json['title'] as String,
  type: $enumDecodeNullable(_$TaskTypeEnumMap, json['type']) ?? TaskType.task,
  dueDate: (json['due_date'] as num?)?.toInt(),
  isCompleted: json['is_completed'] == null
      ? false
      : boolFromInt((json['is_completed'] as num).toInt()),
  subjectId: (json['subject_id'] as num?)?.toInt(),
);

Map<String, dynamic> _$$TaskImplToJson(_$TaskImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'type': _$TaskTypeEnumMap[instance.type]!,
      'due_date': instance.dueDate,
      'is_completed': intFromBool(instance.isCompleted),
      'subject_id': instance.subjectId,
    };

const _$TaskTypeEnumMap = {
  TaskType.assignment: 'ASSIGNMENT',
  TaskType.task: 'TASK',
};
