// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'participation_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ParticipationEvent _$ParticipationEventFromJson(Map<String, dynamic> json) {
  return _ParticipationEvent.fromJson(json);
}

/// @nodoc
mixin _$ParticipationEvent {
  int? get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  int get dateEpoch => throw _privateConstructorUsedError;
  String? get location => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;

  /// Serializes this ParticipationEvent to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ParticipationEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ParticipationEventCopyWith<ParticipationEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ParticipationEventCopyWith<$Res> {
  factory $ParticipationEventCopyWith(
    ParticipationEvent value,
    $Res Function(ParticipationEvent) then,
  ) = _$ParticipationEventCopyWithImpl<$Res, ParticipationEvent>;
  @useResult
  $Res call({
    int? id,
    String name,
    int dateEpoch,
    String? location,
    String? description,
  });
}

/// @nodoc
class _$ParticipationEventCopyWithImpl<$Res, $Val extends ParticipationEvent>
    implements $ParticipationEventCopyWith<$Res> {
  _$ParticipationEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ParticipationEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = null,
    Object? dateEpoch = null,
    Object? location = freezed,
    Object? description = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: freezed == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int?,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            dateEpoch: null == dateEpoch
                ? _value.dateEpoch
                : dateEpoch // ignore: cast_nullable_to_non_nullable
                      as int,
            location: freezed == location
                ? _value.location
                : location // ignore: cast_nullable_to_non_nullable
                      as String?,
            description: freezed == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ParticipationEventImplCopyWith<$Res>
    implements $ParticipationEventCopyWith<$Res> {
  factory _$$ParticipationEventImplCopyWith(
    _$ParticipationEventImpl value,
    $Res Function(_$ParticipationEventImpl) then,
  ) = __$$ParticipationEventImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int? id,
    String name,
    int dateEpoch,
    String? location,
    String? description,
  });
}

/// @nodoc
class __$$ParticipationEventImplCopyWithImpl<$Res>
    extends _$ParticipationEventCopyWithImpl<$Res, _$ParticipationEventImpl>
    implements _$$ParticipationEventImplCopyWith<$Res> {
  __$$ParticipationEventImplCopyWithImpl(
    _$ParticipationEventImpl _value,
    $Res Function(_$ParticipationEventImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ParticipationEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = null,
    Object? dateEpoch = null,
    Object? location = freezed,
    Object? description = freezed,
  }) {
    return _then(
      _$ParticipationEventImpl(
        id: freezed == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int?,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        dateEpoch: null == dateEpoch
            ? _value.dateEpoch
            : dateEpoch // ignore: cast_nullable_to_non_nullable
                  as int,
        location: freezed == location
            ? _value.location
            : location // ignore: cast_nullable_to_non_nullable
                  as String?,
        description: freezed == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ParticipationEventImpl implements _ParticipationEvent {
  const _$ParticipationEventImpl({
    this.id,
    required this.name,
    required this.dateEpoch,
    this.location,
    this.description,
  });

  factory _$ParticipationEventImpl.fromJson(Map<String, dynamic> json) =>
      _$$ParticipationEventImplFromJson(json);

  @override
  final int? id;
  @override
  final String name;
  @override
  final int dateEpoch;
  @override
  final String? location;
  @override
  final String? description;

  @override
  String toString() {
    return 'ParticipationEvent(id: $id, name: $name, dateEpoch: $dateEpoch, location: $location, description: $description)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ParticipationEventImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.dateEpoch, dateEpoch) ||
                other.dateEpoch == dateEpoch) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.description, description) ||
                other.description == description));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, name, dateEpoch, location, description);

  /// Create a copy of ParticipationEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ParticipationEventImplCopyWith<_$ParticipationEventImpl> get copyWith =>
      __$$ParticipationEventImplCopyWithImpl<_$ParticipationEventImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ParticipationEventImplToJson(this);
  }
}

abstract class _ParticipationEvent implements ParticipationEvent {
  const factory _ParticipationEvent({
    final int? id,
    required final String name,
    required final int dateEpoch,
    final String? location,
    final String? description,
  }) = _$ParticipationEventImpl;

  factory _ParticipationEvent.fromJson(Map<String, dynamic> json) =
      _$ParticipationEventImpl.fromJson;

  @override
  int? get id;
  @override
  String get name;
  @override
  int get dateEpoch;
  @override
  String? get location;
  @override
  String? get description;

  /// Create a copy of ParticipationEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ParticipationEventImplCopyWith<_$ParticipationEventImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
