import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../data/repositories/attendance_repository_impl.dart';
import '../../data/repositories/subject_repository_impl.dart';
import '../../domain/entities/subject.dart';
import '../providers/active_semester_provider.dart';

part 'attendance_stats_provider.g.dart';

class SubjectStats {
  final Subject subject;
  final int total;
  final int present;
  final int absent;
  final int od;

  SubjectStats({
    required this.subject,
    required this.total,
    required this.present,
    required this.absent,
    required this.od,
  });

  double get percentage {
    if (total == 0) return 100.0; // Default to 100 if no classes yet
    return ((present + od) / total) * 100;
  }
}

@riverpod
Future<List<SubjectStats>> attendanceStats(AttendanceStatsRef ref) async {
  final semester = await ref.watch(activeSemesterProvider.future);
  if (semester == null) return [];

  final subjectRepo = ref.watch(subjectRepositoryProvider);
  final attendanceRepo = ref.watch(attendanceRepositoryProvider);
  
  // 1. Get all subjects map for quick lookup
  final subjects = await subjectRepo.getSubjectsForSemester(semester.id!);
  final subjectMap = {for (var s in subjects) s.id!: s};

  // 2. Get Bulk Stats
  final rawStats = await attendanceRepo.getSemesterStats(semester.id!);
  
  final List<SubjectStats> stats = [];

  for (var raw in rawStats) {
    final subjectId = raw['subject_id'] as int;
    final subject = subjectMap[subjectId];
    
    if (subject == null) continue; 
    if (subject.credits == 0) continue; 

    stats.add(SubjectStats(
      subject: subject,
      total: raw['total'],
      present: raw['present'],
      absent: raw['absent'],
      od: raw['od'],
    ));
  }
  
  // Edge case: If a subject has 0 classes scheduled so far, it won't be in rawStats.
  // Add them with 0s if they exist in subjectMap but not rawStats?
  // User might want to see them.
  for (var subject in subjects) {
    if (subject.credits == 0) continue;
    if (stats.any((s) => s.subject.id == subject.id)) continue;
    
    stats.add(SubjectStats(
      subject: subject,
      total: 0,
       present: 0,
       absent: 0,
       od: 0
    ));
  }

  return stats;
}
