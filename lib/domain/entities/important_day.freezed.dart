// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'important_day.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ImportantDay _$ImportantDayFromJson(Map<String, dynamic> json) {
  return _ImportantDay.fromJson(json);
}

/// @nodoc
mixin _$ImportantDay {
  int? get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  int get dateEpoch => throw _privateConstructorUsedError;

  /// Serializes this ImportantDay to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ImportantDay
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ImportantDayCopyWith<ImportantDay> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ImportantDayCopyWith<$Res> {
  factory $ImportantDayCopyWith(
    ImportantDay value,
    $Res Function(ImportantDay) then,
  ) = _$ImportantDayCopyWithImpl<$Res, ImportantDay>;
  @useResult
  $Res call({int? id, String title, String? description, int dateEpoch});
}

/// @nodoc
class _$ImportantDayCopyWithImpl<$Res, $Val extends ImportantDay>
    implements $ImportantDayCopyWith<$Res> {
  _$ImportantDayCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ImportantDay
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? title = null,
    Object? description = freezed,
    Object? dateEpoch = null,
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
            description: freezed == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String?,
            dateEpoch: null == dateEpoch
                ? _value.dateEpoch
                : dateEpoch // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ImportantDayImplCopyWith<$Res>
    implements $ImportantDayCopyWith<$Res> {
  factory _$$ImportantDayImplCopyWith(
    _$ImportantDayImpl value,
    $Res Function(_$ImportantDayImpl) then,
  ) = __$$ImportantDayImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int? id, String title, String? description, int dateEpoch});
}

/// @nodoc
class __$$ImportantDayImplCopyWithImpl<$Res>
    extends _$ImportantDayCopyWithImpl<$Res, _$ImportantDayImpl>
    implements _$$ImportantDayImplCopyWith<$Res> {
  __$$ImportantDayImplCopyWithImpl(
    _$ImportantDayImpl _value,
    $Res Function(_$ImportantDayImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ImportantDay
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? title = null,
    Object? description = freezed,
    Object? dateEpoch = null,
  }) {
    return _then(
      _$ImportantDayImpl(
        id: freezed == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int?,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        description: freezed == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String?,
        dateEpoch: null == dateEpoch
            ? _value.dateEpoch
            : dateEpoch // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ImportantDayImpl implements _ImportantDay {
  const _$ImportantDayImpl({
    this.id,
    required this.title,
    this.description,
    required this.dateEpoch,
  });

  factory _$ImportantDayImpl.fromJson(Map<String, dynamic> json) =>
      _$$ImportantDayImplFromJson(json);

  @override
  final int? id;
  @override
  final String title;
  @override
  final String? description;
  @override
  final int dateEpoch;

  @override
  String toString() {
    return 'ImportantDay(id: $id, title: $title, description: $description, dateEpoch: $dateEpoch)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ImportantDayImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.dateEpoch, dateEpoch) ||
                other.dateEpoch == dateEpoch));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, title, description, dateEpoch);

  /// Create a copy of ImportantDay
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ImportantDayImplCopyWith<_$ImportantDayImpl> get copyWith =>
      __$$ImportantDayImplCopyWithImpl<_$ImportantDayImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ImportantDayImplToJson(this);
  }
}

abstract class _ImportantDay implements ImportantDay {
  const factory _ImportantDay({
    final int? id,
    required final String title,
    final String? description,
    required final int dateEpoch,
  }) = _$ImportantDayImpl;

  factory _ImportantDay.fromJson(Map<String, dynamic> json) =
      _$ImportantDayImpl.fromJson;

  @override
  int? get id;
  @override
  String get title;
  @override
  String? get description;
  @override
  int get dateEpoch;

  /// Create a copy of ImportantDay
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ImportantDayImplCopyWith<_$ImportantDayImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
