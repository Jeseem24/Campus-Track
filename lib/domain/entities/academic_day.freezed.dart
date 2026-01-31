// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'academic_day.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

AcademicDay _$AcademicDayFromJson(Map<String, dynamic> json) {
  return _AcademicDay.fromJson(json);
}

/// @nodoc
mixin _$AcademicDay {
  @JsonKey(name: 'date_epoch')
  int get dateEpoch => throw _privateConstructorUsedError;
  @JsonKey(name: 'semester_id')
  int get semesterId => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_holiday', fromJson: boolFromInt, toJson: intFromBool)
  bool get isHoliday => throw _privateConstructorUsedError;
  @JsonKey(name: 'day_order')
  int? get dayOrder => throw _privateConstructorUsedError;
  @JsonKey(
    name: 'is_manual_override',
    fromJson: boolFromInt,
    toJson: intFromBool,
  )
  bool get isManualOverride => throw _privateConstructorUsedError;
  @JsonKey(name: 'affects_future', fromJson: boolFromInt, toJson: intFromBool)
  bool get affectsFuture => throw _privateConstructorUsedError;
  String? get note => throw _privateConstructorUsedError;

  /// Serializes this AcademicDay to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AcademicDay
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AcademicDayCopyWith<AcademicDay> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AcademicDayCopyWith<$Res> {
  factory $AcademicDayCopyWith(
    AcademicDay value,
    $Res Function(AcademicDay) then,
  ) = _$AcademicDayCopyWithImpl<$Res, AcademicDay>;
  @useResult
  $Res call({
    @JsonKey(name: 'date_epoch') int dateEpoch,
    @JsonKey(name: 'semester_id') int semesterId,
    @JsonKey(name: 'is_holiday', fromJson: boolFromInt, toJson: intFromBool)
    bool isHoliday,
    @JsonKey(name: 'day_order') int? dayOrder,
    @JsonKey(
      name: 'is_manual_override',
      fromJson: boolFromInt,
      toJson: intFromBool,
    )
    bool isManualOverride,
    @JsonKey(name: 'affects_future', fromJson: boolFromInt, toJson: intFromBool)
    bool affectsFuture,
    String? note,
  });
}

/// @nodoc
class _$AcademicDayCopyWithImpl<$Res, $Val extends AcademicDay>
    implements $AcademicDayCopyWith<$Res> {
  _$AcademicDayCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AcademicDay
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? dateEpoch = null,
    Object? semesterId = null,
    Object? isHoliday = null,
    Object? dayOrder = freezed,
    Object? isManualOverride = null,
    Object? affectsFuture = null,
    Object? note = freezed,
  }) {
    return _then(
      _value.copyWith(
            dateEpoch: null == dateEpoch
                ? _value.dateEpoch
                : dateEpoch // ignore: cast_nullable_to_non_nullable
                      as int,
            semesterId: null == semesterId
                ? _value.semesterId
                : semesterId // ignore: cast_nullable_to_non_nullable
                      as int,
            isHoliday: null == isHoliday
                ? _value.isHoliday
                : isHoliday // ignore: cast_nullable_to_non_nullable
                      as bool,
            dayOrder: freezed == dayOrder
                ? _value.dayOrder
                : dayOrder // ignore: cast_nullable_to_non_nullable
                      as int?,
            isManualOverride: null == isManualOverride
                ? _value.isManualOverride
                : isManualOverride // ignore: cast_nullable_to_non_nullable
                      as bool,
            affectsFuture: null == affectsFuture
                ? _value.affectsFuture
                : affectsFuture // ignore: cast_nullable_to_non_nullable
                      as bool,
            note: freezed == note
                ? _value.note
                : note // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AcademicDayImplCopyWith<$Res>
    implements $AcademicDayCopyWith<$Res> {
  factory _$$AcademicDayImplCopyWith(
    _$AcademicDayImpl value,
    $Res Function(_$AcademicDayImpl) then,
  ) = __$$AcademicDayImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'date_epoch') int dateEpoch,
    @JsonKey(name: 'semester_id') int semesterId,
    @JsonKey(name: 'is_holiday', fromJson: boolFromInt, toJson: intFromBool)
    bool isHoliday,
    @JsonKey(name: 'day_order') int? dayOrder,
    @JsonKey(
      name: 'is_manual_override',
      fromJson: boolFromInt,
      toJson: intFromBool,
    )
    bool isManualOverride,
    @JsonKey(name: 'affects_future', fromJson: boolFromInt, toJson: intFromBool)
    bool affectsFuture,
    String? note,
  });
}

/// @nodoc
class __$$AcademicDayImplCopyWithImpl<$Res>
    extends _$AcademicDayCopyWithImpl<$Res, _$AcademicDayImpl>
    implements _$$AcademicDayImplCopyWith<$Res> {
  __$$AcademicDayImplCopyWithImpl(
    _$AcademicDayImpl _value,
    $Res Function(_$AcademicDayImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AcademicDay
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? dateEpoch = null,
    Object? semesterId = null,
    Object? isHoliday = null,
    Object? dayOrder = freezed,
    Object? isManualOverride = null,
    Object? affectsFuture = null,
    Object? note = freezed,
  }) {
    return _then(
      _$AcademicDayImpl(
        dateEpoch: null == dateEpoch
            ? _value.dateEpoch
            : dateEpoch // ignore: cast_nullable_to_non_nullable
                  as int,
        semesterId: null == semesterId
            ? _value.semesterId
            : semesterId // ignore: cast_nullable_to_non_nullable
                  as int,
        isHoliday: null == isHoliday
            ? _value.isHoliday
            : isHoliday // ignore: cast_nullable_to_non_nullable
                  as bool,
        dayOrder: freezed == dayOrder
            ? _value.dayOrder
            : dayOrder // ignore: cast_nullable_to_non_nullable
                  as int?,
        isManualOverride: null == isManualOverride
            ? _value.isManualOverride
            : isManualOverride // ignore: cast_nullable_to_non_nullable
                  as bool,
        affectsFuture: null == affectsFuture
            ? _value.affectsFuture
            : affectsFuture // ignore: cast_nullable_to_non_nullable
                  as bool,
        note: freezed == note
            ? _value.note
            : note // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AcademicDayImpl implements _AcademicDay {
  const _$AcademicDayImpl({
    @JsonKey(name: 'date_epoch') required this.dateEpoch,
    @JsonKey(name: 'semester_id') required this.semesterId,
    @JsonKey(name: 'is_holiday', fromJson: boolFromInt, toJson: intFromBool)
    required this.isHoliday,
    @JsonKey(name: 'day_order') this.dayOrder,
    @JsonKey(
      name: 'is_manual_override',
      fromJson: boolFromInt,
      toJson: intFromBool,
    )
    this.isManualOverride = false,
    @JsonKey(name: 'affects_future', fromJson: boolFromInt, toJson: intFromBool)
    this.affectsFuture = false,
    this.note,
  });

  factory _$AcademicDayImpl.fromJson(Map<String, dynamic> json) =>
      _$$AcademicDayImplFromJson(json);

  @override
  @JsonKey(name: 'date_epoch')
  final int dateEpoch;
  @override
  @JsonKey(name: 'semester_id')
  final int semesterId;
  @override
  @JsonKey(name: 'is_holiday', fromJson: boolFromInt, toJson: intFromBool)
  final bool isHoliday;
  @override
  @JsonKey(name: 'day_order')
  final int? dayOrder;
  @override
  @JsonKey(
    name: 'is_manual_override',
    fromJson: boolFromInt,
    toJson: intFromBool,
  )
  final bool isManualOverride;
  @override
  @JsonKey(name: 'affects_future', fromJson: boolFromInt, toJson: intFromBool)
  final bool affectsFuture;
  @override
  final String? note;

  @override
  String toString() {
    return 'AcademicDay(dateEpoch: $dateEpoch, semesterId: $semesterId, isHoliday: $isHoliday, dayOrder: $dayOrder, isManualOverride: $isManualOverride, affectsFuture: $affectsFuture, note: $note)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AcademicDayImpl &&
            (identical(other.dateEpoch, dateEpoch) ||
                other.dateEpoch == dateEpoch) &&
            (identical(other.semesterId, semesterId) ||
                other.semesterId == semesterId) &&
            (identical(other.isHoliday, isHoliday) ||
                other.isHoliday == isHoliday) &&
            (identical(other.dayOrder, dayOrder) ||
                other.dayOrder == dayOrder) &&
            (identical(other.isManualOverride, isManualOverride) ||
                other.isManualOverride == isManualOverride) &&
            (identical(other.affectsFuture, affectsFuture) ||
                other.affectsFuture == affectsFuture) &&
            (identical(other.note, note) || other.note == note));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    dateEpoch,
    semesterId,
    isHoliday,
    dayOrder,
    isManualOverride,
    affectsFuture,
    note,
  );

  /// Create a copy of AcademicDay
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AcademicDayImplCopyWith<_$AcademicDayImpl> get copyWith =>
      __$$AcademicDayImplCopyWithImpl<_$AcademicDayImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AcademicDayImplToJson(this);
  }
}

abstract class _AcademicDay implements AcademicDay {
  const factory _AcademicDay({
    @JsonKey(name: 'date_epoch') required final int dateEpoch,
    @JsonKey(name: 'semester_id') required final int semesterId,
    @JsonKey(name: 'is_holiday', fromJson: boolFromInt, toJson: intFromBool)
    required final bool isHoliday,
    @JsonKey(name: 'day_order') final int? dayOrder,
    @JsonKey(
      name: 'is_manual_override',
      fromJson: boolFromInt,
      toJson: intFromBool,
    )
    final bool isManualOverride,
    @JsonKey(name: 'affects_future', fromJson: boolFromInt, toJson: intFromBool)
    final bool affectsFuture,
    final String? note,
  }) = _$AcademicDayImpl;

  factory _AcademicDay.fromJson(Map<String, dynamic> json) =
      _$AcademicDayImpl.fromJson;

  @override
  @JsonKey(name: 'date_epoch')
  int get dateEpoch;
  @override
  @JsonKey(name: 'semester_id')
  int get semesterId;
  @override
  @JsonKey(name: 'is_holiday', fromJson: boolFromInt, toJson: intFromBool)
  bool get isHoliday;
  @override
  @JsonKey(name: 'day_order')
  int? get dayOrder;
  @override
  @JsonKey(
    name: 'is_manual_override',
    fromJson: boolFromInt,
    toJson: intFromBool,
  )
  bool get isManualOverride;
  @override
  @JsonKey(name: 'affects_future', fromJson: boolFromInt, toJson: intFromBool)
  bool get affectsFuture;
  @override
  String? get note;

  /// Create a copy of AcademicDay
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AcademicDayImplCopyWith<_$AcademicDayImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
