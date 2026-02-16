import 'package:flutter_test/flutter_test.dart';
import 'package:campus_track/domain/logic/day_order_calculator.dart';
import 'package:campus_track/domain/entities/academic_day.dart';

void main() {
  group('DayOrderCalculator', () {
    late DayOrderCalculator calculator;

    setUp(() {
      calculator = DayOrderCalculator();
    });

    test('cycles through day orders 1-6 correctly', () {
      final start = DateTime(2024, 1, 1).millisecondsSinceEpoch; // Monday
      final end = DateTime(2024, 1, 10).millisecondsSinceEpoch;
      
      final result = calculator.calculateProjectedDayOrders(
        startDateEpoch: start,
        endDateEpoch: end,
        existingDays: [],
        initialDayOrder: 1,
      );

      // Mon Jan 1 = Day 1
      expect(result[DateTime(2024, 1, 1).millisecondsSinceEpoch], 1);
      // Tue Jan 2 = Day 2
      expect(result[DateTime(2024, 1, 2).millisecondsSinceEpoch], 2);
      // Wed Jan 3 = Day 3
      expect(result[DateTime(2024, 1, 3).millisecondsSinceEpoch], 3);
      // Thu Jan 4 = Day 4
      expect(result[DateTime(2024, 1, 4).millisecondsSinceEpoch], 4);
      // Fri Jan 5 = Day 5
      expect(result[DateTime(2024, 1, 5).millisecondsSinceEpoch], 5);
      // Sat Jan 6 = Day 6
      expect(result[DateTime(2024, 1, 6).millisecondsSinceEpoch], 6);
      // Sun Jan 7 = Holiday (null)
      expect(result[DateTime(2024, 1, 7).millisecondsSinceEpoch], null);
      // Mon Jan 8 = Day 1 (cycles back)
      expect(result[DateTime(2024, 1, 8).millisecondsSinceEpoch], 1);
    });

    test('marks Sundays as holidays', () {
      final start = DateTime(2024, 1, 7).millisecondsSinceEpoch; // Sunday
      final end = DateTime(2024, 1, 14).millisecondsSinceEpoch;
      
      final result = calculator.calculateProjectedDayOrders(
        startDateEpoch: start,
        endDateEpoch: end,
        existingDays: [],
      );

      // Both Sundays should be null
      expect(result[DateTime(2024, 1, 7).millisecondsSinceEpoch], null);
      expect(result[DateTime(2024, 1, 14).millisecondsSinceEpoch], null);
    });

    test('handles manual overrides with carry forward', () {
      final start = DateTime(2024, 1, 1).millisecondsSinceEpoch;
      final end = DateTime(2024, 1, 10).millisecondsSinceEpoch;
      
      // Manual override: Jan 3 is a holiday, carry forward enabled
      final existingDays = [
        AcademicDay(
          dateEpoch: DateTime(2024, 1, 3).millisecondsSinceEpoch,
          semesterId: 1,
          isHoliday: true,
          dayOrder: null,
          isManualOverride: true,
          affectsFuture: true,
        ),
      ];

      final result = calculator.calculateProjectedDayOrders(
        startDateEpoch: start,
        endDateEpoch: end,
        existingDays: existingDays,
        initialDayOrder: 1,
      );

      // Jan 1 = Day 1
      expect(result[DateTime(2024, 1, 1).millisecondsSinceEpoch], 1);
      // Jan 2 = Day 2
      expect(result[DateTime(2024, 1, 2).millisecondsSinceEpoch], 2);
      // Jan 3 = Holiday (manual override)
      expect(result[DateTime(202, 1, 3).millisecondsSinceEpoch], null);
      // Jan 4 = Day 3 (continues from Day 2)
      expect(result[DateTime(2024, 1, 4).millisecondsSinceEpoch], 3);
      // Jan 5 = Day 4
      expect(result[DateTime(2024, 1, 5).millisecondsSinceEpoch], 4);
    });

    test('handles manual overrides without carry forward', () {
      final start = DateTime(2024, 1, 1).millisecondsSinceEpoch;
      final end = DateTime(2024, 1, 10).millisecondsSinceEpoch;
      
      // Manual override: Jan 3 = Day 5, no carry forward
      final existingDays = [
        AcademicDay(
          dateEpoch: DateTime(2024, 1, 3).millisecondsSinceEpoch,
          semesterId: 1,
          isHoliday: false,
          dayOrder: 5,
          isManualOverride: true,
          affectsFuture: false,
        ),
      ];

      final result = calculator.calculateProjectedDayOrders(
        startDateEpoch: start,
        endDateEpoch: end,
        existingDays: existingDays,
        initialDayOrder: 1,
      );

      // Jan 1 = Day 1
      expect(result[DateTime(2024, 1, 1).millisecondsSinceEpoch], 1);
      // Jan 2 = Day 2
      expect(result[DateTime(2024, 1, 2).millisecondsSinceEpoch], 2);
      // Jan 3 = Day 5 (manual override, no carry)
      expect(result[DateTime(2024, 1, 3).millisecondsSinceEpoch], 5);
      // Jan 4 = Day 3 (normal sequence resumes)
      expect(result[DateTime(2024, 1, 4).millisecondsSinceEpoch], 3);
      // Jan 5 = Day 4
      expect(result[DateTime(2024, 1, 5).millisecondsSinceEpoch], 4);
    });

    test('handles gaps in calendar', () {
      final start = DateTime(2024, 1, 1).millisecondsSinceEpoch;
      final end = DateTime(2024, 1, 20).millisecondsSinceEpoch;
      
      // Only define days for Jan 1-5, leave Jan 6-19 as gap
      final manualDays = [
        AcademicDay(
          dateEpoch: DateTime(2024, 1, 1).millisecondsSinceEpoch,
          semesterId: 1,
          isHoliday: false,
          dayOrder: 1,
          isManualOverride: true,
        ),
        AcademicDay(
          dateEpoch: DateTime(2024, 1, 5).millisecondsSinceEpoch,
          semesterId: 1,
          isHoliday: false,
          dayOrder: 4,
          isManualOverride: true,
        ),
      ];

      final result = calculator.calculateProjectedDayOrders(
        startDateEpoch: start,
        endDateEpoch: end,
        existingDays: manualDays,
        initialDayOrder: 1,
      );

      // Should fill in the gaps correctly
      expect(result[DateTime(2024, 1, 1).millisecondsSinceEpoch], 1);
      expect(result[DateTime(2024, 1, 2).millisecondsSinceEpoch], 2);
      expect(result[DateTime(2024, 1, 3).millisecondsSinceEpoch], 3);
      expect(result[DateTime(2024, 1, 4).millisecondsSinceEpoch], 4);
      expect(result[DateTime(2024, 1, 5).millisecondsSinceEpoch], 4); // Manual override
      expect(result[DateTime(2024, 1, 6).millisecondsSinceEpoch], 5);
    });

    test('respects semester boundaries', () {
      final semesterStart = DateTime(2024, 1, 1).millisecondsSinceEpoch;
      final semesterEnd = DateTime(2024, 1, 15).millisecondsSinceEpoch;
      final beyondSemester = DateTime(2024, 1, 20).millisecondsSinceEpoch;
      
      final result = calculator.calculateProjectedDayOrders(
        startDateEpoch: semesterStart,
        endDateEpoch: beyondSemester, // Beyond semester end
        existingDays: [],
        initialDayOrder: 1,
      );

      // Days within semester should have orders
      expect(result[DateTime(2024, 1, 1).millisecondsSinceEpoch], isNotNull);
      expect(result[DateTime(2024, 1, 15).millisecondsSinceEpoch], isNotNull);
      
      // Days beyond semester can still be calculated (for flexibility)
      expect(result[DateTime(2024, 1, 16).millisecondsSinceEpoch], isNotNull);
    });
  });
}
