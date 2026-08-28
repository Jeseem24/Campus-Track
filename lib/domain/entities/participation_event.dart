import 'package:freezed_annotation/freezed_annotation.dart';

part 'participation_event.freezed.dart';
part 'participation_event.g.dart';

@freezed
class ParticipationEvent with _$ParticipationEvent {
  const factory ParticipationEvent({
    int? id,
    required String name,
    required int dateEpoch,
    String? location,
    String? description,
  }) = _ParticipationEvent;

  factory ParticipationEvent.fromJson(Map<String, dynamic> json) => _$ParticipationEventFromJson(json);
}
