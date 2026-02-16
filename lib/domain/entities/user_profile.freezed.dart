// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_profile.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

UserProfile _$UserProfileFromJson(Map<String, dynamic> json) {
  return _UserProfile.fromJson(json);
}

/// @nodoc
mixin _$UserProfile {
  @JsonKey(name: 'id')
  int? get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'name')
  String get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'semester')
  int get semester => throw _privateConstructorUsedError;
  @JsonKey(name: 'department')
  String get department => throw _privateConstructorUsedError;
  @JsonKey(name: 'section')
  String? get section => throw _privateConstructorUsedError;
  @JsonKey(name: 'college_name')
  String? get collegeName => throw _privateConstructorUsedError;
  @JsonKey(name: 'wake_time')
  String? get wakeTime => throw _privateConstructorUsedError; // e.g., "07:00"
  @JsonKey(name: 'sleep_time')
  String? get sleepTime => throw _privateConstructorUsedError; // e.g., "23:00"
  @JsonKey(name: 'preferred_study_hours')
  int? get preferredStudyHours => throw _privateConstructorUsedError;

  /// Serializes this UserProfile to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserProfile
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserProfileCopyWith<UserProfile> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserProfileCopyWith<$Res> {
  factory $UserProfileCopyWith(
    UserProfile value,
    $Res Function(UserProfile) then,
  ) = _$UserProfileCopyWithImpl<$Res, UserProfile>;
  @useResult
  $Res call({
    @JsonKey(name: 'id') int? id,
    @JsonKey(name: 'name') String name,
    @JsonKey(name: 'semester') int semester,
    @JsonKey(name: 'department') String department,
    @JsonKey(name: 'section') String? section,
    @JsonKey(name: 'college_name') String? collegeName,
    @JsonKey(name: 'wake_time') String? wakeTime,
    @JsonKey(name: 'sleep_time') String? sleepTime,
    @JsonKey(name: 'preferred_study_hours') int? preferredStudyHours,
  });
}

/// @nodoc
class _$UserProfileCopyWithImpl<$Res, $Val extends UserProfile>
    implements $UserProfileCopyWith<$Res> {
  _$UserProfileCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserProfile
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = null,
    Object? semester = null,
    Object? department = null,
    Object? section = freezed,
    Object? collegeName = freezed,
    Object? wakeTime = freezed,
    Object? sleepTime = freezed,
    Object? preferredStudyHours = freezed,
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
            semester: null == semester
                ? _value.semester
                : semester // ignore: cast_nullable_to_non_nullable
                      as int,
            department: null == department
                ? _value.department
                : department // ignore: cast_nullable_to_non_nullable
                      as String,
            section: freezed == section
                ? _value.section
                : section // ignore: cast_nullable_to_non_nullable
                      as String?,
            collegeName: freezed == collegeName
                ? _value.collegeName
                : collegeName // ignore: cast_nullable_to_non_nullable
                      as String?,
            wakeTime: freezed == wakeTime
                ? _value.wakeTime
                : wakeTime // ignore: cast_nullable_to_non_nullable
                      as String?,
            sleepTime: freezed == sleepTime
                ? _value.sleepTime
                : sleepTime // ignore: cast_nullable_to_non_nullable
                      as String?,
            preferredStudyHours: freezed == preferredStudyHours
                ? _value.preferredStudyHours
                : preferredStudyHours // ignore: cast_nullable_to_non_nullable
                      as int?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$UserProfileImplCopyWith<$Res>
    implements $UserProfileCopyWith<$Res> {
  factory _$$UserProfileImplCopyWith(
    _$UserProfileImpl value,
    $Res Function(_$UserProfileImpl) then,
  ) = __$$UserProfileImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'id') int? id,
    @JsonKey(name: 'name') String name,
    @JsonKey(name: 'semester') int semester,
    @JsonKey(name: 'department') String department,
    @JsonKey(name: 'section') String? section,
    @JsonKey(name: 'college_name') String? collegeName,
    @JsonKey(name: 'wake_time') String? wakeTime,
    @JsonKey(name: 'sleep_time') String? sleepTime,
    @JsonKey(name: 'preferred_study_hours') int? preferredStudyHours,
  });
}

/// @nodoc
class __$$UserProfileImplCopyWithImpl<$Res>
    extends _$UserProfileCopyWithImpl<$Res, _$UserProfileImpl>
    implements _$$UserProfileImplCopyWith<$Res> {
  __$$UserProfileImplCopyWithImpl(
    _$UserProfileImpl _value,
    $Res Function(_$UserProfileImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UserProfile
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = null,
    Object? semester = null,
    Object? department = null,
    Object? section = freezed,
    Object? collegeName = freezed,
    Object? wakeTime = freezed,
    Object? sleepTime = freezed,
    Object? preferredStudyHours = freezed,
  }) {
    return _then(
      _$UserProfileImpl(
        id: freezed == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int?,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        semester: null == semester
            ? _value.semester
            : semester // ignore: cast_nullable_to_non_nullable
                  as int,
        department: null == department
            ? _value.department
            : department // ignore: cast_nullable_to_non_nullable
                  as String,
        section: freezed == section
            ? _value.section
            : section // ignore: cast_nullable_to_non_nullable
                  as String?,
        collegeName: freezed == collegeName
            ? _value.collegeName
            : collegeName // ignore: cast_nullable_to_non_nullable
                  as String?,
        wakeTime: freezed == wakeTime
            ? _value.wakeTime
            : wakeTime // ignore: cast_nullable_to_non_nullable
                  as String?,
        sleepTime: freezed == sleepTime
            ? _value.sleepTime
            : sleepTime // ignore: cast_nullable_to_non_nullable
                  as String?,
        preferredStudyHours: freezed == preferredStudyHours
            ? _value.preferredStudyHours
            : preferredStudyHours // ignore: cast_nullable_to_non_nullable
                  as int?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$UserProfileImpl implements _UserProfile {
  const _$UserProfileImpl({
    @JsonKey(name: 'id') this.id,
    @JsonKey(name: 'name') required this.name,
    @JsonKey(name: 'semester') required this.semester,
    @JsonKey(name: 'department') required this.department,
    @JsonKey(name: 'section') this.section,
    @JsonKey(name: 'college_name') this.collegeName,
    @JsonKey(name: 'wake_time') this.wakeTime,
    @JsonKey(name: 'sleep_time') this.sleepTime,
    @JsonKey(name: 'preferred_study_hours') this.preferredStudyHours,
  });

  factory _$UserProfileImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserProfileImplFromJson(json);

  @override
  @JsonKey(name: 'id')
  final int? id;
  @override
  @JsonKey(name: 'name')
  final String name;
  @override
  @JsonKey(name: 'semester')
  final int semester;
  @override
  @JsonKey(name: 'department')
  final String department;
  @override
  @JsonKey(name: 'section')
  final String? section;
  @override
  @JsonKey(name: 'college_name')
  final String? collegeName;
  @override
  @JsonKey(name: 'wake_time')
  final String? wakeTime;
  // e.g., "07:00"
  @override
  @JsonKey(name: 'sleep_time')
  final String? sleepTime;
  // e.g., "23:00"
  @override
  @JsonKey(name: 'preferred_study_hours')
  final int? preferredStudyHours;

  @override
  String toString() {
    return 'UserProfile(id: $id, name: $name, semester: $semester, department: $department, section: $section, collegeName: $collegeName, wakeTime: $wakeTime, sleepTime: $sleepTime, preferredStudyHours: $preferredStudyHours)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserProfileImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.semester, semester) ||
                other.semester == semester) &&
            (identical(other.department, department) ||
                other.department == department) &&
            (identical(other.section, section) || other.section == section) &&
            (identical(other.collegeName, collegeName) ||
                other.collegeName == collegeName) &&
            (identical(other.wakeTime, wakeTime) ||
                other.wakeTime == wakeTime) &&
            (identical(other.sleepTime, sleepTime) ||
                other.sleepTime == sleepTime) &&
            (identical(other.preferredStudyHours, preferredStudyHours) ||
                other.preferredStudyHours == preferredStudyHours));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    semester,
    department,
    section,
    collegeName,
    wakeTime,
    sleepTime,
    preferredStudyHours,
  );

  /// Create a copy of UserProfile
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserProfileImplCopyWith<_$UserProfileImpl> get copyWith =>
      __$$UserProfileImplCopyWithImpl<_$UserProfileImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserProfileImplToJson(this);
  }
}

abstract class _UserProfile implements UserProfile {
  const factory _UserProfile({
    @JsonKey(name: 'id') final int? id,
    @JsonKey(name: 'name') required final String name,
    @JsonKey(name: 'semester') required final int semester,
    @JsonKey(name: 'department') required final String department,
    @JsonKey(name: 'section') final String? section,
    @JsonKey(name: 'college_name') final String? collegeName,
    @JsonKey(name: 'wake_time') final String? wakeTime,
    @JsonKey(name: 'sleep_time') final String? sleepTime,
    @JsonKey(name: 'preferred_study_hours') final int? preferredStudyHours,
  }) = _$UserProfileImpl;

  factory _UserProfile.fromJson(Map<String, dynamic> json) =
      _$UserProfileImpl.fromJson;

  @override
  @JsonKey(name: 'id')
  int? get id;
  @override
  @JsonKey(name: 'name')
  String get name;
  @override
  @JsonKey(name: 'semester')
  int get semester;
  @override
  @JsonKey(name: 'department')
  String get department;
  @override
  @JsonKey(name: 'section')
  String? get section;
  @override
  @JsonKey(name: 'college_name')
  String? get collegeName;
  @override
  @JsonKey(name: 'wake_time')
  String? get wakeTime; // e.g., "07:00"
  @override
  @JsonKey(name: 'sleep_time')
  String? get sleepTime; // e.g., "23:00"
  @override
  @JsonKey(name: 'preferred_study_hours')
  int? get preferredStudyHours;

  /// Create a copy of UserProfile
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserProfileImplCopyWith<_$UserProfileImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
