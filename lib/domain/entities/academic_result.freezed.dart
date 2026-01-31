// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'academic_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

AcademicResult _$AcademicResultFromJson(Map<String, dynamic> json) {
  return _AcademicResult.fromJson(json);
}

/// @nodoc
mixin _$AcademicResult {
  int? get id => throw _privateConstructorUsedError;
  String get semesterName =>
      throw _privateConstructorUsedError; // e.g., "Semester 1"
  double get gpa => throw _privateConstructorUsedError;
  double get totalCredits => throw _privateConstructorUsedError;

  /// Serializes this AcademicResult to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AcademicResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AcademicResultCopyWith<AcademicResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AcademicResultCopyWith<$Res> {
  factory $AcademicResultCopyWith(
    AcademicResult value,
    $Res Function(AcademicResult) then,
  ) = _$AcademicResultCopyWithImpl<$Res, AcademicResult>;
  @useResult
  $Res call({int? id, String semesterName, double gpa, double totalCredits});
}

/// @nodoc
class _$AcademicResultCopyWithImpl<$Res, $Val extends AcademicResult>
    implements $AcademicResultCopyWith<$Res> {
  _$AcademicResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AcademicResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? semesterName = null,
    Object? gpa = null,
    Object? totalCredits = null,
  }) {
    return _then(
      _value.copyWith(
            id: freezed == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int?,
            semesterName: null == semesterName
                ? _value.semesterName
                : semesterName // ignore: cast_nullable_to_non_nullable
                      as String,
            gpa: null == gpa
                ? _value.gpa
                : gpa // ignore: cast_nullable_to_non_nullable
                      as double,
            totalCredits: null == totalCredits
                ? _value.totalCredits
                : totalCredits // ignore: cast_nullable_to_non_nullable
                      as double,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AcademicResultImplCopyWith<$Res>
    implements $AcademicResultCopyWith<$Res> {
  factory _$$AcademicResultImplCopyWith(
    _$AcademicResultImpl value,
    $Res Function(_$AcademicResultImpl) then,
  ) = __$$AcademicResultImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int? id, String semesterName, double gpa, double totalCredits});
}

/// @nodoc
class __$$AcademicResultImplCopyWithImpl<$Res>
    extends _$AcademicResultCopyWithImpl<$Res, _$AcademicResultImpl>
    implements _$$AcademicResultImplCopyWith<$Res> {
  __$$AcademicResultImplCopyWithImpl(
    _$AcademicResultImpl _value,
    $Res Function(_$AcademicResultImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AcademicResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? semesterName = null,
    Object? gpa = null,
    Object? totalCredits = null,
  }) {
    return _then(
      _$AcademicResultImpl(
        id: freezed == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int?,
        semesterName: null == semesterName
            ? _value.semesterName
            : semesterName // ignore: cast_nullable_to_non_nullable
                  as String,
        gpa: null == gpa
            ? _value.gpa
            : gpa // ignore: cast_nullable_to_non_nullable
                  as double,
        totalCredits: null == totalCredits
            ? _value.totalCredits
            : totalCredits // ignore: cast_nullable_to_non_nullable
                  as double,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AcademicResultImpl implements _AcademicResult {
  const _$AcademicResultImpl({
    this.id,
    required this.semesterName,
    required this.gpa,
    required this.totalCredits,
  });

  factory _$AcademicResultImpl.fromJson(Map<String, dynamic> json) =>
      _$$AcademicResultImplFromJson(json);

  @override
  final int? id;
  @override
  final String semesterName;
  // e.g., "Semester 1"
  @override
  final double gpa;
  @override
  final double totalCredits;

  @override
  String toString() {
    return 'AcademicResult(id: $id, semesterName: $semesterName, gpa: $gpa, totalCredits: $totalCredits)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AcademicResultImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.semesterName, semesterName) ||
                other.semesterName == semesterName) &&
            (identical(other.gpa, gpa) || other.gpa == gpa) &&
            (identical(other.totalCredits, totalCredits) ||
                other.totalCredits == totalCredits));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, semesterName, gpa, totalCredits);

  /// Create a copy of AcademicResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AcademicResultImplCopyWith<_$AcademicResultImpl> get copyWith =>
      __$$AcademicResultImplCopyWithImpl<_$AcademicResultImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$AcademicResultImplToJson(this);
  }
}

abstract class _AcademicResult implements AcademicResult {
  const factory _AcademicResult({
    final int? id,
    required final String semesterName,
    required final double gpa,
    required final double totalCredits,
  }) = _$AcademicResultImpl;

  factory _AcademicResult.fromJson(Map<String, dynamic> json) =
      _$AcademicResultImpl.fromJson;

  @override
  int? get id;
  @override
  String get semesterName; // e.g., "Semester 1"
  @override
  double get gpa;
  @override
  double get totalCredits;

  /// Create a copy of AcademicResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AcademicResultImplCopyWith<_$AcademicResultImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
