import '../entities/subject.dart';

abstract class SubjectRepository {
  Future<List<Subject>> getSubjectsForSemester(int semesterId);
  Future<Subject?> getSubject(int id);
  Future<int> createSubject(Subject subject);
  Future<void> updateSubject(Subject subject);
  Future<void> deleteSubject(int id);
}
