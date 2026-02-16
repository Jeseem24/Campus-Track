import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_profile.freezed.dart';
part 'user_profile.g.dart';

@freezed
class UserProfile with _$UserProfile {
  const factory UserProfile({
    @JsonKey(name: 'id') int? id,
    @JsonKey(name: 'name') required String name,
    @JsonKey(name: 'semester') required int semester,
    @JsonKey(name: 'department') required String department,
    @JsonKey(name: 'section') String? section,
    @JsonKey(name: 'college_name') String? collegeName,
    @JsonKey(name: 'wake_time') String? wakeTime, // e.g., "07:00"
    @JsonKey(name: 'sleep_time') String? sleepTime, // e.g., "23:00"
    @JsonKey(name: 'preferred_study_hours') int? preferredStudyHours, // daily
  }) = _UserProfile;

  factory UserProfile.fromJson(Map<String, dynamic> json) => 
      _$UserProfileFromJson(json);
}
