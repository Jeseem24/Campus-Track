import '../entities/academic_day.dart';

abstract class DayRepository {
  Future<void> saveDay(AcademicDay day);
  Future<AcademicDay?> getDay(int dateEpoch);
  Future<List<AcademicDay>> getDaysForSemester(int semesterId);
  Future<void> deleteFutureComputedDays(int afterDateEpoch, int semesterId);
}
