// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exam.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ExamImpl _$$ExamImplFromJson(Map<String, dynamic> json) => _$ExamImpl(
  id: (json['id'] as num?)?.toInt(),
  subjectId: (json['subject_id'] as num).toInt(),
  title: json['title'] as String,
  date: (json['date'] as num).toInt(),
  totalMarks: (json['total_marks'] as num).toDouble(),
  obtainedMarks: (json['obtained_marks'] as num?)?.toDouble(),
);

Map<String, dynamic> _$$ExamImplToJson(_$ExamImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'subject_id': instance.subjectId,
      'title': instance.title,
      'date': instance.date,
      'total_marks': instance.totalMarks,
      'obtained_marks': instance.obtainedMarks,
    };
