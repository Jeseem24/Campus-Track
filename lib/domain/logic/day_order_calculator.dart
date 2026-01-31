import '../entities/academic_day.dart';
import '../entities/semester.dart';

class DayOrderCalculator {
  /// Calculates the state of academic days from [startDate] to [endDate].
  /// 
  /// [existingDays] contains known exceptions (holidays, manual overrides).
  /// Returns a Map of epoch -> dayOrder (or null if holiday).
  Map<int, int?> calculateProjectedDayOrders({
    required int startDateEpoch,
    required int endDateEpoch,
    required List<AcademicDay> existingDays,
    int initialDayOrder = 1,
  }) {
    final Map<int, int?> resultMap = {};
    
    // Convert existing days to a Map for O(1) lookup
    final Map<int, AcademicDay> daysMap = {
      for (var d in existingDays) d.dateEpoch: d
    };

    int currentDayOrderTracker = initialDayOrder;

    // Iterate day by day from startDate to endDate
    int iterationEpoch = startDateEpoch;

    // Safety check to prevent infinite loops if dates are bad
    if (endDateEpoch < startDateEpoch) return {};

    while (iterationEpoch <= endDateEpoch) {
      final existingDay = daysMap[iterationEpoch];

      if (existingDay != null) {
        // CASE 1: Known Exception / Manual Entry
        
        if (existingDay.isHoliday) {
          // Rule 7: Holidays do not have a day order.
          // Rule 7: Holidays do not advance the sequence.
          resultMap[iterationEpoch] = null;
          // Tracker remains unchanged.
        } else if (existingDay.isManualOverride) {
          // Rule 8: Manual Day Order Overrides.
          // The app always asks: "Carry forward this change?"
          
          resultMap[iterationEpoch] = existingDay.dayOrder;
          
          if (existingDay.dayOrder != null) {
             if (existingDay.affectsFuture) {
              // Option A: Carry Forward = YES
              // Future day orders continue from this manual value.
              // So if we forcibly set today to 3, tomorrow should start looking for 4.
              currentDayOrderTracker = (existingDay.dayOrder! % 6) + 1;
            } else {
              // Option B: Carry Forward = NO
              // Only this specific day is affected.
              // Future days follow the ORIGINAL sequence.
              
              // This means the tracker should validly increment from its PREVIOUS state
              // as if this day was a normal working day in the background sequence.
              resultMap[iterationEpoch] = existingDay.dayOrder; 
              currentDayOrderTracker = (currentDayOrderTracker % 6) + 1;
            }
          }
        } else {
          // Day exists in DB but just as a record (maybe with a note), no special property.
          // Treated as a normal computed day.
          resultMap[iterationEpoch] = currentDayOrderTracker;
          currentDayOrderTracker = (currentDayOrderTracker % 6) + 1;
        }

      } else {
        // CASE 2: No Record (Default Behavior)
        final date = DateTime.fromMillisecondsSinceEpoch(iterationEpoch);
        
        // Rule: Sundays are HOLIDAYS by default
        if (date.weekday == DateTime.sunday) {
          resultMap[iterationEpoch] = null;
          // Holiday does not advance tracker
        } else {
          // Rule 6: Assumption Rule - Assumed working day.
          resultMap[iterationEpoch] = currentDayOrderTracker;
          // Advance tracker
          currentDayOrderTracker = (currentDayOrderTracker % 6) + 1;
        }
      }

      // Move to next day (Add 24 hours in milliseconds)
      // Note: In production, use strict UTC Date handling to avoid DST issues, 
      // but for this MVP epoch addition is acceptable if inputs are midnight-aligned.
      iterationEpoch += 86400000; 
    }

    return resultMap;
  }
}
