class AttendanceLog {
  final int subjectId;
  final String status;
  AttendanceLog({required this.subjectId, required this.status});
}

abstract class AttendanceRepository {
  Future<void> markAttendance(int dateEpoch, int slotIndex, int subjectId, String status);
  Future<Map<int, AttendanceLog>> getAttendanceForDay(int dateEpoch); // {slotIndex: Log}
  Future<Map<String, dynamic>> getSubjectStats(int subjectId);
  Future<List<Map<String, dynamic>>> getSemesterStats(int semesterId);
}
