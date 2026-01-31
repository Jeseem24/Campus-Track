import '../entities/semester.dart';

abstract class SemesterRepository {
  Future<Semester?> getActiveSemester();
  Future<List<Semester>> getAllSemesters();
  Future<int> createSemester(Semester semester);
  Future<void> updateSemester(Semester semester);
  Future<void> deleteSemester(int id);
}
