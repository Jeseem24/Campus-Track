import 'package:freezed_annotation/freezed_annotation.dart';

import '../../core/utils/json_converters.dart';

part 'semester.freezed.dart';
part 'semester.g.dart';

@freezed
class Semester with _$Semester {
  const factory Semester({
    int? id,
    required String name,
    @JsonKey(name: 'start_date') required int startDate,
    @JsonKey(name: 'end_date') required int endDate,
    @JsonKey(name: 'is_active', fromJson: boolFromInt, toJson: intFromBool) @Default(true) bool isActive,
  }) = _Semester;

  factory Semester.fromJson(Map<String, dynamic> json) => _$SemesterFromJson(json);
}
