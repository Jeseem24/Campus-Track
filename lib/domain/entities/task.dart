import 'package:freezed_annotation/freezed_annotation.dart';

import '../../core/utils/json_converters.dart';

part 'task.freezed.dart';
part 'task.g.dart';

enum TaskType {
  @JsonValue('ASSIGNMENT') assignment,
  @JsonValue('TASK') task,
}

@freezed
class Task with _$Task {
  const factory Task({
    int? id,
    required String title,
    @Default(TaskType.task) TaskType type,
    @JsonKey(name: 'due_date') int? dueDate,
    @JsonKey(name: 'is_completed', fromJson: boolFromInt, toJson: intFromBool) @Default(false) bool isCompleted,
    @JsonKey(name: 'subject_id') int? subjectId,
  }) = _Task;

  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);
}
