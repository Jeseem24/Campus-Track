// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'exam.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Exam _$ExamFromJson(Map<String, dynamic> json) {
  return _Exam.fromJson(json);
}

/// @nodoc
mixin _$Exam {
  int? get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'subject_id')
  int get subjectId => throw _privateConstructorUsedError;
  String get title =>
      throw _privateConstructorUsedError; // e.g., "Cycle Test 1", "Semester Exam"
  int get date => throw _privateConstructorUsedError; // epoch
  @JsonKey(name: 'total_marks')
  double get totalMarks => throw _privateConstructorUsedError;
  @JsonKey(name: 'obtained_marks')
  double? get obtainedMarks => throw _privateConstructorUsedError;

  /// Serializes this Exam to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Exam
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ExamCopyWith<Exam> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExamCopyWith<$Res> {
  factory $ExamCopyWith(Exam value, $Res Function(Exam) then) =
      _$ExamCopyWithImpl<$Res, Exam>;
  @useResult
  $Res call({
    int? id,
    @JsonKey(name: 'subject_id') int subjectId,
    String title,
    int date,
    @JsonKey(name: 'total_marks') double totalMarks,
    @JsonKey(name: 'obtained_marks') double? obtainedMarks,
  });
}

/// @nodoc
class _$ExamCopyWithImpl<$Res, $Val extends Exam>
    implements $ExamCopyWith<$Res> {
  _$ExamCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Exam
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? subjectId = null,
    Object? title = null,
    Object? date = null,
    Object? totalMarks = null,
    Object? obtainedMarks = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: freezed == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int?,
            subjectId: null == subjectId
                ? _value.subjectId
                : subjectId // ignore: cast_nullable_to_non_nullable
                      as int,
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            date: null == date
                ? _value.date
                : date // ignore: cast_nullable_to_non_nullable
                      as int,
            totalMarks: null == totalMarks
                ? _value.totalMarks
                : totalMarks // ignore: cast_nullable_to_non_nullable
                      as double,
            obtainedMarks: freezed == obtainedMarks
                ? _value.obtainedMarks
                : obtainedMarks // ignore: cast_nullable_to_non_nullable
                      as double?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ExamImplCopyWith<$Res> implements $ExamCopyWith<$Res> {
  factory _$$ExamImplCopyWith(
    _$ExamImpl value,
    $Res Function(_$ExamImpl) then,
  ) = __$$ExamImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int? id,
    @JsonKey(name: 'subject_id') int subjectId,
    String title,
    int date,
    @JsonKey(name: 'total_marks') double totalMarks,
    @JsonKey(name: 'obtained_marks') double? obtainedMarks,
  });
}

/// @nodoc
class __$$ExamImplCopyWithImpl<$Res>
    extends _$ExamCopyWithImpl<$Res, _$ExamImpl>
    implements _$$ExamImplCopyWith<$Res> {
  __$$ExamImplCopyWithImpl(_$ExamImpl _value, $Res Function(_$ExamImpl) _then)
    : super(_value, _then);

  /// Create a copy of Exam
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? subjectId = null,
    Object? title = null,
    Object? date = null,
    Object? totalMarks = null,
    Object? obtainedMarks = freezed,
  }) {
    return _then(
      _$ExamImpl(
        id: freezed == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int?,
        subjectId: null == subjectId
            ? _value.subjectId
            : subjectId // ignore: cast_nullable_to_non_nullable
                  as int,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        date: null == date
            ? _value.date
            : date // ignore: cast_nullable_to_non_nullable
                  as int,
        totalMarks: null == totalMarks
            ? _value.totalMarks
            : totalMarks // ignore: cast_nullable_to_non_nullable
                  as double,
        obtainedMarks: freezed == obtainedMarks
            ? _value.obtainedMarks
            : obtainedMarks // ignore: cast_nullable_to_non_nullable
                  as double?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ExamImpl implements _Exam {
  const _$ExamImpl({
    this.id,
    @JsonKey(name: 'subject_id') required this.subjectId,
    required this.title,
    required this.date,
    @JsonKey(name: 'total_marks') required this.totalMarks,
    @JsonKey(name: 'obtained_marks') this.obtainedMarks,
  });

  factory _$ExamImpl.fromJson(Map<String, dynamic> json) =>
      _$$ExamImplFromJson(json);

  @override
  final int? id;
  @override
  @JsonKey(name: 'subject_id')
  final int subjectId;
  @override
  final String title;
  // e.g., "Cycle Test 1", "Semester Exam"
  @override
  final int date;
  // epoch
  @override
  @JsonKey(name: 'total_marks')
  final double totalMarks;
  @override
  @JsonKey(name: 'obtained_marks')
  final double? obtainedMarks;

  @override
  String toString() {
    return 'Exam(id: $id, subjectId: $subjectId, title: $title, date: $date, totalMarks: $totalMarks, obtainedMarks: $obtainedMarks)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ExamImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.subjectId, subjectId) ||
                other.subjectId == subjectId) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.totalMarks, totalMarks) ||
                other.totalMarks == totalMarks) &&
            (identical(other.obtainedMarks, obtainedMarks) ||
                other.obtainedMarks == obtainedMarks));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    subjectId,
    title,
    date,
    totalMarks,
    obtainedMarks,
  );

  /// Create a copy of Exam
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ExamImplCopyWith<_$ExamImpl> get copyWith =>
      __$$ExamImplCopyWithImpl<_$ExamImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ExamImplToJson(this);
  }
}

abstract class _Exam implements Exam {
  const factory _Exam({
    final int? id,
    @JsonKey(name: 'subject_id') required final int subjectId,
    required final String title,
    required final int date,
    @JsonKey(name: 'total_marks') required final double totalMarks,
    @JsonKey(name: 'obtained_marks') final double? obtainedMarks,
  }) = _$ExamImpl;

  factory _Exam.fromJson(Map<String, dynamic> json) = _$ExamImpl.fromJson;

  @override
  int? get id;
  @override
  @JsonKey(name: 'subject_id')
  int get subjectId;
  @override
  String get title; // e.g., "Cycle Test 1", "Semester Exam"
  @override
  int get date; // epoch
  @override
  @JsonKey(name: 'total_marks')
  double get totalMarks;
  @override
  @JsonKey(name: 'obtained_marks')
  double? get obtainedMarks;

  /// Create a copy of Exam
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ExamImplCopyWith<_$ExamImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
