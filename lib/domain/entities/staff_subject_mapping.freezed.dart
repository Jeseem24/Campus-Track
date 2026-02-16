// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'staff_subject_mapping.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

StaffSubjectMapping _$StaffSubjectMappingFromJson(Map<String, dynamic> json) {
  return _StaffSubjectMapping.fromJson(json);
}

/// @nodoc
mixin _$StaffSubjectMapping {
  @JsonKey(name: 'id')
  int? get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'staff_name')
  String get staffName => throw _privateConstructorUsedError;
  @JsonKey(name: 'subject_id')
  int get subjectId => throw _privateConstructorUsedError;
  @JsonKey(name: 'communication_style')
  String? get communicationStyle => throw _privateConstructorUsedError;

  /// Serializes this StaffSubjectMapping to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of StaffSubjectMapping
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StaffSubjectMappingCopyWith<StaffSubjectMapping> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StaffSubjectMappingCopyWith<$Res> {
  factory $StaffSubjectMappingCopyWith(
    StaffSubjectMapping value,
    $Res Function(StaffSubjectMapping) then,
  ) = _$StaffSubjectMappingCopyWithImpl<$Res, StaffSubjectMapping>;
  @useResult
  $Res call({
    @JsonKey(name: 'id') int? id,
    @JsonKey(name: 'staff_name') String staffName,
    @JsonKey(name: 'subject_id') int subjectId,
    @JsonKey(name: 'communication_style') String? communicationStyle,
  });
}

/// @nodoc
class _$StaffSubjectMappingCopyWithImpl<$Res, $Val extends StaffSubjectMapping>
    implements $StaffSubjectMappingCopyWith<$Res> {
  _$StaffSubjectMappingCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StaffSubjectMapping
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? staffName = null,
    Object? subjectId = null,
    Object? communicationStyle = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: freezed == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int?,
            staffName: null == staffName
                ? _value.staffName
                : staffName // ignore: cast_nullable_to_non_nullable
                      as String,
            subjectId: null == subjectId
                ? _value.subjectId
                : subjectId // ignore: cast_nullable_to_non_nullable
                      as int,
            communicationStyle: freezed == communicationStyle
                ? _value.communicationStyle
                : communicationStyle // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$StaffSubjectMappingImplCopyWith<$Res>
    implements $StaffSubjectMappingCopyWith<$Res> {
  factory _$$StaffSubjectMappingImplCopyWith(
    _$StaffSubjectMappingImpl value,
    $Res Function(_$StaffSubjectMappingImpl) then,
  ) = __$$StaffSubjectMappingImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'id') int? id,
    @JsonKey(name: 'staff_name') String staffName,
    @JsonKey(name: 'subject_id') int subjectId,
    @JsonKey(name: 'communication_style') String? communicationStyle,
  });
}

/// @nodoc
class __$$StaffSubjectMappingImplCopyWithImpl<$Res>
    extends _$StaffSubjectMappingCopyWithImpl<$Res, _$StaffSubjectMappingImpl>
    implements _$$StaffSubjectMappingImplCopyWith<$Res> {
  __$$StaffSubjectMappingImplCopyWithImpl(
    _$StaffSubjectMappingImpl _value,
    $Res Function(_$StaffSubjectMappingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of StaffSubjectMapping
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? staffName = null,
    Object? subjectId = null,
    Object? communicationStyle = freezed,
  }) {
    return _then(
      _$StaffSubjectMappingImpl(
        id: freezed == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int?,
        staffName: null == staffName
            ? _value.staffName
            : staffName // ignore: cast_nullable_to_non_nullable
                  as String,
        subjectId: null == subjectId
            ? _value.subjectId
            : subjectId // ignore: cast_nullable_to_non_nullable
                  as int,
        communicationStyle: freezed == communicationStyle
            ? _value.communicationStyle
            : communicationStyle // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$StaffSubjectMappingImpl implements _StaffSubjectMapping {
  const _$StaffSubjectMappingImpl({
    @JsonKey(name: 'id') this.id,
    @JsonKey(name: 'staff_name') required this.staffName,
    @JsonKey(name: 'subject_id') required this.subjectId,
    @JsonKey(name: 'communication_style') this.communicationStyle,
  });

  factory _$StaffSubjectMappingImpl.fromJson(Map<String, dynamic> json) =>
      _$$StaffSubjectMappingImplFromJson(json);

  @override
  @JsonKey(name: 'id')
  final int? id;
  @override
  @JsonKey(name: 'staff_name')
  final String staffName;
  @override
  @JsonKey(name: 'subject_id')
  final int subjectId;
  @override
  @JsonKey(name: 'communication_style')
  final String? communicationStyle;

  @override
  String toString() {
    return 'StaffSubjectMapping(id: $id, staffName: $staffName, subjectId: $subjectId, communicationStyle: $communicationStyle)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StaffSubjectMappingImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.staffName, staffName) ||
                other.staffName == staffName) &&
            (identical(other.subjectId, subjectId) ||
                other.subjectId == subjectId) &&
            (identical(other.communicationStyle, communicationStyle) ||
                other.communicationStyle == communicationStyle));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, staffName, subjectId, communicationStyle);

  /// Create a copy of StaffSubjectMapping
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StaffSubjectMappingImplCopyWith<_$StaffSubjectMappingImpl> get copyWith =>
      __$$StaffSubjectMappingImplCopyWithImpl<_$StaffSubjectMappingImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$StaffSubjectMappingImplToJson(this);
  }
}

abstract class _StaffSubjectMapping implements StaffSubjectMapping {
  const factory _StaffSubjectMapping({
    @JsonKey(name: 'id') final int? id,
    @JsonKey(name: 'staff_name') required final String staffName,
    @JsonKey(name: 'subject_id') required final int subjectId,
    @JsonKey(name: 'communication_style') final String? communicationStyle,
  }) = _$StaffSubjectMappingImpl;

  factory _StaffSubjectMapping.fromJson(Map<String, dynamic> json) =
      _$StaffSubjectMappingImpl.fromJson;

  @override
  @JsonKey(name: 'id')
  int? get id;
  @override
  @JsonKey(name: 'staff_name')
  String get staffName;
  @override
  @JsonKey(name: 'subject_id')
  int get subjectId;
  @override
  @JsonKey(name: 'communication_style')
  String? get communicationStyle;

  /// Create a copy of StaffSubjectMapping
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StaffSubjectMappingImplCopyWith<_$StaffSubjectMappingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
