import 'package:freezed_annotation/freezed_annotation.dart';

part 'important_day.freezed.dart';
part 'important_day.g.dart';

@freezed
class ImportantDay with _$ImportantDay {
  const factory ImportantDay({
    int? id,
    required String title,
    String? description,
    required int dateEpoch,
  }) = _ImportantDay;

  factory ImportantDay.fromJson(Map<String, dynamic> json) => _$ImportantDayFromJson(json);
}
