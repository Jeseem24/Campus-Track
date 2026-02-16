// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ai_suggestion.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

AISuggestion _$AISuggestionFromJson(Map<String, dynamic> json) {
  return _AISuggestion.fromJson(json);
}

/// @nodoc
mixin _$AISuggestion {
  @JsonKey(name: 'id')
  int? get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'title')
  String get title => throw _privateConstructorUsedError;
  @JsonKey(name: 'description')
  String get description => throw _privateConstructorUsedError;
  @JsonKey(name: 'type')
  SuggestionType get type => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  int get createdAtEpoch => throw _privateConstructorUsedError;
  @JsonKey(name: 'dismissed')
  bool get dismissed => throw _privateConstructorUsedError;
  @JsonKey(name: 'action_taken')
  bool get actionTaken => throw _privateConstructorUsedError;

  /// Serializes this AISuggestion to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AISuggestion
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AISuggestionCopyWith<AISuggestion> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AISuggestionCopyWith<$Res> {
  factory $AISuggestionCopyWith(
    AISuggestion value,
    $Res Function(AISuggestion) then,
  ) = _$AISuggestionCopyWithImpl<$Res, AISuggestion>;
  @useResult
  $Res call({
    @JsonKey(name: 'id') int? id,
    @JsonKey(name: 'title') String title,
    @JsonKey(name: 'description') String description,
    @JsonKey(name: 'type') SuggestionType type,
    @JsonKey(name: 'created_at') int createdAtEpoch,
    @JsonKey(name: 'dismissed') bool dismissed,
    @JsonKey(name: 'action_taken') bool actionTaken,
  });
}

/// @nodoc
class _$AISuggestionCopyWithImpl<$Res, $Val extends AISuggestion>
    implements $AISuggestionCopyWith<$Res> {
  _$AISuggestionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AISuggestion
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? title = null,
    Object? description = null,
    Object? type = null,
    Object? createdAtEpoch = null,
    Object? dismissed = null,
    Object? actionTaken = null,
  }) {
    return _then(
      _value.copyWith(
            id: freezed == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int?,
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            description: null == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String,
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as SuggestionType,
            createdAtEpoch: null == createdAtEpoch
                ? _value.createdAtEpoch
                : createdAtEpoch // ignore: cast_nullable_to_non_nullable
                      as int,
            dismissed: null == dismissed
                ? _value.dismissed
                : dismissed // ignore: cast_nullable_to_non_nullable
                      as bool,
            actionTaken: null == actionTaken
                ? _value.actionTaken
                : actionTaken // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AISuggestionImplCopyWith<$Res>
    implements $AISuggestionCopyWith<$Res> {
  factory _$$AISuggestionImplCopyWith(
    _$AISuggestionImpl value,
    $Res Function(_$AISuggestionImpl) then,
  ) = __$$AISuggestionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'id') int? id,
    @JsonKey(name: 'title') String title,
    @JsonKey(name: 'description') String description,
    @JsonKey(name: 'type') SuggestionType type,
    @JsonKey(name: 'created_at') int createdAtEpoch,
    @JsonKey(name: 'dismissed') bool dismissed,
    @JsonKey(name: 'action_taken') bool actionTaken,
  });
}

/// @nodoc
class __$$AISuggestionImplCopyWithImpl<$Res>
    extends _$AISuggestionCopyWithImpl<$Res, _$AISuggestionImpl>
    implements _$$AISuggestionImplCopyWith<$Res> {
  __$$AISuggestionImplCopyWithImpl(
    _$AISuggestionImpl _value,
    $Res Function(_$AISuggestionImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AISuggestion
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? title = null,
    Object? description = null,
    Object? type = null,
    Object? createdAtEpoch = null,
    Object? dismissed = null,
    Object? actionTaken = null,
  }) {
    return _then(
      _$AISuggestionImpl(
        id: freezed == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int?,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        description: null == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String,
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as SuggestionType,
        createdAtEpoch: null == createdAtEpoch
            ? _value.createdAtEpoch
            : createdAtEpoch // ignore: cast_nullable_to_non_nullable
                  as int,
        dismissed: null == dismissed
            ? _value.dismissed
            : dismissed // ignore: cast_nullable_to_non_nullable
                  as bool,
        actionTaken: null == actionTaken
            ? _value.actionTaken
            : actionTaken // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AISuggestionImpl implements _AISuggestion {
  const _$AISuggestionImpl({
    @JsonKey(name: 'id') this.id,
    @JsonKey(name: 'title') required this.title,
    @JsonKey(name: 'description') required this.description,
    @JsonKey(name: 'type') required this.type,
    @JsonKey(name: 'created_at') required this.createdAtEpoch,
    @JsonKey(name: 'dismissed') this.dismissed = false,
    @JsonKey(name: 'action_taken') this.actionTaken = false,
  });

  factory _$AISuggestionImpl.fromJson(Map<String, dynamic> json) =>
      _$$AISuggestionImplFromJson(json);

  @override
  @JsonKey(name: 'id')
  final int? id;
  @override
  @JsonKey(name: 'title')
  final String title;
  @override
  @JsonKey(name: 'description')
  final String description;
  @override
  @JsonKey(name: 'type')
  final SuggestionType type;
  @override
  @JsonKey(name: 'created_at')
  final int createdAtEpoch;
  @override
  @JsonKey(name: 'dismissed')
  final bool dismissed;
  @override
  @JsonKey(name: 'action_taken')
  final bool actionTaken;

  @override
  String toString() {
    return 'AISuggestion(id: $id, title: $title, description: $description, type: $type, createdAtEpoch: $createdAtEpoch, dismissed: $dismissed, actionTaken: $actionTaken)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AISuggestionImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.createdAtEpoch, createdAtEpoch) ||
                other.createdAtEpoch == createdAtEpoch) &&
            (identical(other.dismissed, dismissed) ||
                other.dismissed == dismissed) &&
            (identical(other.actionTaken, actionTaken) ||
                other.actionTaken == actionTaken));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    title,
    description,
    type,
    createdAtEpoch,
    dismissed,
    actionTaken,
  );

  /// Create a copy of AISuggestion
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AISuggestionImplCopyWith<_$AISuggestionImpl> get copyWith =>
      __$$AISuggestionImplCopyWithImpl<_$AISuggestionImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AISuggestionImplToJson(this);
  }
}

abstract class _AISuggestion implements AISuggestion {
  const factory _AISuggestion({
    @JsonKey(name: 'id') final int? id,
    @JsonKey(name: 'title') required final String title,
    @JsonKey(name: 'description') required final String description,
    @JsonKey(name: 'type') required final SuggestionType type,
    @JsonKey(name: 'created_at') required final int createdAtEpoch,
    @JsonKey(name: 'dismissed') final bool dismissed,
    @JsonKey(name: 'action_taken') final bool actionTaken,
  }) = _$AISuggestionImpl;

  factory _AISuggestion.fromJson(Map<String, dynamic> json) =
      _$AISuggestionImpl.fromJson;

  @override
  @JsonKey(name: 'id')
  int? get id;
  @override
  @JsonKey(name: 'title')
  String get title;
  @override
  @JsonKey(name: 'description')
  String get description;
  @override
  @JsonKey(name: 'type')
  SuggestionType get type;
  @override
  @JsonKey(name: 'created_at')
  int get createdAtEpoch;
  @override
  @JsonKey(name: 'dismissed')
  bool get dismissed;
  @override
  @JsonKey(name: 'action_taken')
  bool get actionTaken;

  /// Create a copy of AISuggestion
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AISuggestionImplCopyWith<_$AISuggestionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
