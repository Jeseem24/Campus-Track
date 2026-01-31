import 'package:freezed_annotation/freezed_annotation.dart';

part 'attendance.freezed.dart';
part 'attendance.g.dart';

enum AttendanceStatus {
  @JsonValue('PRESENT') present,
  @JsonValue('ABSENT') absent,
  @JsonValue('OD') onDuty,
  @JsonValue('CANCELLED') cancelled,
}

@freezed
class Attendance with _$Attendance {
  const factory Attendance({
    @JsonKey(name: 'date_epoch') required int dateEpoch,
    @JsonKey(name: 'subject_id') required int subjectId,
    @Default(AttendanceStatus.present) AttendanceStatus status,
  }) = _Attendance;

  factory Attendance.fromJson(Map<String, dynamic> json) => _$AttendanceFromJson(json);
}
