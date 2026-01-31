// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'attendance.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Attendance _$AttendanceFromJson(Map<String, dynamic> json) {
  return _Attendance.fromJson(json);
}

/// @nodoc
mixin _$Attendance {
  @JsonKey(name: 'date_epoch')
  int get dateEpoch => throw _privateConstructorUsedError;
  @JsonKey(name: 'subject_id')
  int get subjectId => throw _privateConstructorUsedError;
  AttendanceStatus get status => throw _privateConstructorUsedError;

  /// Serializes this Attendance to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Attendance
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AttendanceCopyWith<Attendance> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AttendanceCopyWith<$Res> {
  factory $AttendanceCopyWith(
    Attendance value,
    $Res Function(Attendance) then,
  ) = _$AttendanceCopyWithImpl<$Res, Attendance>;
  @useResult
  $Res call({
    @JsonKey(name: 'date_epoch') int dateEpoch,
    @JsonKey(name: 'subject_id') int subjectId,
    AttendanceStatus status,
  });
}

/// @nodoc
class _$AttendanceCopyWithImpl<$Res, $Val extends Attendance>
    implements $AttendanceCopyWith<$Res> {
  _$AttendanceCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Attendance
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? dateEpoch = null,
    Object? subjectId = null,
    Object? status = null,
  }) {
    return _then(
      _value.copyWith(
            dateEpoch: null == dateEpoch
                ? _value.dateEpoch
                : dateEpoch // ignore: cast_nullable_to_non_nullable
                      as int,
            subjectId: null == subjectId
                ? _value.subjectId
                : subjectId // ignore: cast_nullable_to_non_nullable
                      as int,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as AttendanceStatus,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AttendanceImplCopyWith<$Res>
    implements $AttendanceCopyWith<$Res> {
  factory _$$AttendanceImplCopyWith(
    _$AttendanceImpl value,
    $Res Function(_$AttendanceImpl) then,
  ) = __$$AttendanceImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'date_epoch') int dateEpoch,
    @JsonKey(name: 'subject_id') int subjectId,
    AttendanceStatus status,
  });
}

/// @nodoc
class __$$AttendanceImplCopyWithImpl<$Res>
    extends _$AttendanceCopyWithImpl<$Res, _$AttendanceImpl>
    implements _$$AttendanceImplCopyWith<$Res> {
  __$$AttendanceImplCopyWithImpl(
    _$AttendanceImpl _value,
    $Res Function(_$AttendanceImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Attendance
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? dateEpoch = null,
    Object? subjectId = null,
    Object? status = null,
  }) {
    return _then(
      _$AttendanceImpl(
        dateEpoch: null == dateEpoch
            ? _value.dateEpoch
            : dateEpoch // ignore: cast_nullable_to_non_nullable
                  as int,
        subjectId: null == subjectId
            ? _value.subjectId
            : subjectId // ignore: cast_nullable_to_non_nullable
                  as int,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as AttendanceStatus,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AttendanceImpl implements _Attendance {
  const _$AttendanceImpl({
    @JsonKey(name: 'date_epoch') required this.dateEpoch,
    @JsonKey(name: 'subject_id') required this.subjectId,
    this.status = AttendanceStatus.present,
  });

  factory _$AttendanceImpl.fromJson(Map<String, dynamic> json) =>
      _$$AttendanceImplFromJson(json);

  @override
  @JsonKey(name: 'date_epoch')
  final int dateEpoch;
  @override
  @JsonKey(name: 'subject_id')
  final int subjectId;
  @override
  @JsonKey()
  final AttendanceStatus status;

  @override
  String toString() {
    return 'Attendance(dateEpoch: $dateEpoch, subjectId: $subjectId, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AttendanceImpl &&
            (identical(other.dateEpoch, dateEpoch) ||
                other.dateEpoch == dateEpoch) &&
            (identical(other.subjectId, subjectId) ||
                other.subjectId == subjectId) &&
            (identical(other.status, status) || other.status == status));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, dateEpoch, subjectId, status);

  /// Create a copy of Attendance
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AttendanceImplCopyWith<_$AttendanceImpl> get copyWith =>
      __$$AttendanceImplCopyWithImpl<_$AttendanceImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AttendanceImplToJson(this);
  }
}

abstract class _Attendance implements Attendance {
  const factory _Attendance({
    @JsonKey(name: 'date_epoch') required final int dateEpoch,
    @JsonKey(name: 'subject_id') required final int subjectId,
    final AttendanceStatus status,
  }) = _$AttendanceImpl;

  factory _Attendance.fromJson(Map<String, dynamic> json) =
      _$AttendanceImpl.fromJson;

  @override
  @JsonKey(name: 'date_epoch')
  int get dateEpoch;
  @override
  @JsonKey(name: 'subject_id')
  int get subjectId;
  @override
  AttendanceStatus get status;

  /// Create a copy of Attendance
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AttendanceImplCopyWith<_$AttendanceImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
