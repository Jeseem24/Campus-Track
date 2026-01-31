// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'semester.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Semester _$SemesterFromJson(Map<String, dynamic> json) {
  return _Semester.fromJson(json);
}

/// @nodoc
mixin _$Semester {
  int? get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'start_date')
  int get startDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'end_date')
  int get endDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_active', fromJson: boolFromInt, toJson: intFromBool)
  bool get isActive => throw _privateConstructorUsedError;

  /// Serializes this Semester to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Semester
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SemesterCopyWith<Semester> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SemesterCopyWith<$Res> {
  factory $SemesterCopyWith(Semester value, $Res Function(Semester) then) =
      _$SemesterCopyWithImpl<$Res, Semester>;
  @useResult
  $Res call({
    int? id,
    String name,
    @JsonKey(name: 'start_date') int startDate,
    @JsonKey(name: 'end_date') int endDate,
    @JsonKey(name: 'is_active', fromJson: boolFromInt, toJson: intFromBool)
    bool isActive,
  });
}

/// @nodoc
class _$SemesterCopyWithImpl<$Res, $Val extends Semester>
    implements $SemesterCopyWith<$Res> {
  _$SemesterCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Semester
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = null,
    Object? startDate = null,
    Object? endDate = null,
    Object? isActive = null,
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
            startDate: null == startDate
                ? _value.startDate
                : startDate // ignore: cast_nullable_to_non_nullable
                      as int,
            endDate: null == endDate
                ? _value.endDate
                : endDate // ignore: cast_nullable_to_non_nullable
                      as int,
            isActive: null == isActive
                ? _value.isActive
                : isActive // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SemesterImplCopyWith<$Res>
    implements $SemesterCopyWith<$Res> {
  factory _$$SemesterImplCopyWith(
    _$SemesterImpl value,
    $Res Function(_$SemesterImpl) then,
  ) = __$$SemesterImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int? id,
    String name,
    @JsonKey(name: 'start_date') int startDate,
    @JsonKey(name: 'end_date') int endDate,
    @JsonKey(name: 'is_active', fromJson: boolFromInt, toJson: intFromBool)
    bool isActive,
  });
}

/// @nodoc
class __$$SemesterImplCopyWithImpl<$Res>
    extends _$SemesterCopyWithImpl<$Res, _$SemesterImpl>
    implements _$$SemesterImplCopyWith<$Res> {
  __$$SemesterImplCopyWithImpl(
    _$SemesterImpl _value,
    $Res Function(_$SemesterImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Semester
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = null,
    Object? startDate = null,
    Object? endDate = null,
    Object? isActive = null,
  }) {
    return _then(
      _$SemesterImpl(
        id: freezed == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int?,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        startDate: null == startDate
            ? _value.startDate
            : startDate // ignore: cast_nullable_to_non_nullable
                  as int,
        endDate: null == endDate
            ? _value.endDate
            : endDate // ignore: cast_nullable_to_non_nullable
                  as int,
        isActive: null == isActive
            ? _value.isActive
            : isActive // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SemesterImpl implements _Semester {
  const _$SemesterImpl({
    this.id,
    required this.name,
    @JsonKey(name: 'start_date') required this.startDate,
    @JsonKey(name: 'end_date') required this.endDate,
    @JsonKey(name: 'is_active', fromJson: boolFromInt, toJson: intFromBool)
    this.isActive = true,
  });

  factory _$SemesterImpl.fromJson(Map<String, dynamic> json) =>
      _$$SemesterImplFromJson(json);

  @override
  final int? id;
  @override
  final String name;
  @override
  @JsonKey(name: 'start_date')
  final int startDate;
  @override
  @JsonKey(name: 'end_date')
  final int endDate;
  @override
  @JsonKey(name: 'is_active', fromJson: boolFromInt, toJson: intFromBool)
  final bool isActive;

  @override
  String toString() {
    return 'Semester(id: $id, name: $name, startDate: $startDate, endDate: $endDate, isActive: $isActive)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SemesterImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, name, startDate, endDate, isActive);

  /// Create a copy of Semester
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SemesterImplCopyWith<_$SemesterImpl> get copyWith =>
      __$$SemesterImplCopyWithImpl<_$SemesterImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SemesterImplToJson(this);
  }
}

abstract class _Semester implements Semester {
  const factory _Semester({
    final int? id,
    required final String name,
    @JsonKey(name: 'start_date') required final int startDate,
    @JsonKey(name: 'end_date') required final int endDate,
    @JsonKey(name: 'is_active', fromJson: boolFromInt, toJson: intFromBool)
    final bool isActive,
  }) = _$SemesterImpl;

  factory _Semester.fromJson(Map<String, dynamic> json) =
      _$SemesterImpl.fromJson;

  @override
  int? get id;
  @override
  String get name;
  @override
  @JsonKey(name: 'start_date')
  int get startDate;
  @override
  @JsonKey(name: 'end_date')
  int get endDate;
  @override
  @JsonKey(name: 'is_active', fromJson: boolFromInt, toJson: intFromBool)
  bool get isActive;

  /// Create a copy of Semester
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SemesterImplCopyWith<_$SemesterImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
