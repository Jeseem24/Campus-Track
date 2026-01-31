import '../entities/exam.dart';

abstract class ExamRepository {
  Future<int> createExam(Exam exam);
  Future<void> updateExam(Exam exam);
  Future<void> deleteExam(int id);
  Future<List<Exam>> getExamsForSemester(int semesterId);
  Future<List<Exam>> getExamsForSubject(int subjectId);
}
