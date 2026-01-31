import 'package:freezed_annotation/freezed_annotation.dart';

import '../../core/utils/json_converters.dart';

part 'academic_day.freezed.dart';
part 'academic_day.g.dart';

@freezed
class AcademicDay with _$AcademicDay {
  const factory AcademicDay({
    @JsonKey(name: 'date_epoch') required int dateEpoch,
    @JsonKey(name: 'semester_id') required int semesterId,
    @JsonKey(name: 'is_holiday', fromJson: boolFromInt, toJson: intFromBool) required bool isHoliday,
    @JsonKey(name: 'day_order') int? dayOrder,
    @JsonKey(name: 'is_manual_override', fromJson: boolFromInt, toJson: intFromBool) @Default(false) bool isManualOverride,
    @JsonKey(name: 'affects_future', fromJson: boolFromInt, toJson: intFromBool) @Default(false) bool affectsFuture,
    String? note,
  }) = _AcademicDay;

  factory AcademicDay.fromJson(Map<String, dynamic> json) => _$AcademicDayFromJson(json);
}
