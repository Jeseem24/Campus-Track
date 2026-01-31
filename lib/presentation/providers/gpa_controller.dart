import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/entities/subject.dart';
import '../../domain/entities/exam.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/entities/subject.dart';
import '../../domain/entities/exam.dart';
import '../../domain/providers/all_subjects_provider.dart';
import '../providers/exam_controller.dart';

part 'gpa_controller.g.dart';

class SubjectResult {
  final Subject subject;
  final double percentage;
  final int gradePoint;
  final String grade;

  SubjectResult({required this.subject, required this.percentage, required this.gradePoint, required this.grade});
}

class GpaState {
  final double gpa;
  final int totalCredits;
  final List<SubjectResult> details;

  GpaState({required this.gpa, required this.totalCredits, required this.details});
}

@riverpod
Future<GpaState> gpaController(GpaControllerRef ref) async {
  final subjects = await ref.watch(allSubjectsProvider.future);
  final exams = await ref.watch(examControllerProvider.future);

  if (subjects.isEmpty) return GpaState(gpa: 0, totalCredits: 0, details: []);

  int totalCredits = 0;
  double totalWeightedPoints = 0;
  List<SubjectResult> details = [];

  for (var subject in subjects) {
    // 1. Find exams for this subject
    final subExams = exams.where((e) => e.subjectId == subject.id && e.obtainedMarks != null).toList();
    
    // If no exams or incomplete, we currently skip this subject for GPA? 
    // Or we assume 0? Usually we only calculate for completed subjects.
    // Let's assume we average the percentage of all exams for that subject to get the "Subject Score".
    
    if (subExams.isEmpty) continue; // Skip subjects with no results yet

    double totalMax = 0;
    double totalObtained = 0;
    
    for (var e in subExams) {
      totalMax += e.totalMarks;
      totalObtained += e.obtainedMarks!;
    }

    if (totalMax == 0) continue;

    final percentage = (totalObtained / totalMax) * 100;
    final gp = _calculateGradePoint(percentage);
    final grade = _calculateGrade(percentage);

    details.add(SubjectResult(subject: subject, percentage: percentage, gradePoint: gp, grade: grade));

    totalCredits += subject.credits;
    totalWeightedPoints += (gp * subject.credits);
  }

  final gpa = totalCredits == 0 ? 0.0 : totalWeightedPoints / totalCredits;
  
  return GpaState(gpa: gpa, totalCredits: totalCredits, details: details);
}

int _calculateGradePoint(double percentage) {
  if (percentage >= 90) return 10;
  if (percentage >= 80) return 9;
  if (percentage >= 70) return 8;
  if (percentage >= 60) return 7;
  if (percentage >= 50) return 6;
  if (percentage >= 40) return 5; // Pass
  return 0; // Fail
}

String _calculateGrade(double percentage) {
  if (percentage >= 90) return "O";
  if (percentage >= 80) return "A+";
  if (percentage >= 70) return "A";
  if (percentage >= 60) return "B+";
  if (percentage >= 50) return "B";
  if (percentage >= 40) return "C";
  return "U";
}
