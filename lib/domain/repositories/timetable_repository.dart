abstract class TimetableRepository {
  Future<Map<int, int>> getTimetableForDay(int dayOrder); // returns {slotIndex: subjectId}
  Future<void> assignSlot(int dayOrder, int slotIndex, int subjectId);
  Future<void> clearSlot(int dayOrder, int slotIndex);
  Future<void> clearDay(int dayOrder);
}
