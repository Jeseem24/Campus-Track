import 'package:freezed_annotation/freezed_annotation.dart';

part 'ai_suggestion.freezed.dart';
part 'ai_suggestion.g.dart';

enum SuggestionType {
  studyTime,
  priorityAlert,
  workloadWarning,
  attendanceAlert,
  examPrep,
}

@freezed
class AISuggestion with _$AISuggestion {
  const factory AISuggestion({
    @JsonKey(name: 'id') int? id,
    @JsonKey(name: 'title') required String title,
    @JsonKey(name: 'description') required String description,
    @JsonKey(name: 'type') required SuggestionType type,
    @JsonKey(name: 'created_at') required int createdAtEpoch,
    @JsonKey(name: 'dismissed') @Default(false) bool dismissed,
    @JsonKey(name: 'action_taken') @Default(false) bool actionTaken,
  }) = _AISuggestion;

  factory AISuggestion.fromJson(Map<String, dynamic> json) => 
      _$AISuggestionFromJson(json);
}
