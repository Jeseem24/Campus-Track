import 'package:intl/intl.dart';

class AcademicEvent {
  final String note;
  final bool isHoliday;
  final bool isExam;

  const AcademicEvent({
    required this.note,
    required this.isHoliday,
    this.isExam = false,
  });
}

class AcademicCalendar {
  static AcademicEvent? getEvent(DateTime date) {
    // Normalize to local midnight
    final localDate = DateTime(date.year, date.month, date.day);
    
    // The calendar schedule is only authoritative for the 2026-2027 Odd Semester range
    final startDate = DateTime(2026, 7, 15);
    final endDate = DateTime(2027, 1, 4);
    if (localDate.isBefore(startDate) || localDate.isAfter(endDate)) {
      return null;
    }

    final dateStr = DateFormat('yyyy-MM-dd').format(localDate);

    // Explicit event mappings
    final Map<String, AcademicEvent> explicitEvents = {
      // Commencement & Last Working Day
      "2026-07-15": const AcademicEvent(note: "Classes Commence", isHoliday: false),
      "2026-10-27": const AcademicEvent(note: "Last Working Day", isHoliday: false),

      // Holidays & Cell Activities (July)
      "2026-07-25": const AcademicEvent(note: "Non-Professional Cell Activity", isHoliday: true),

      // Holidays & Cell Activities (August)
      "2026-08-08": const AcademicEvent(note: "Professional Cell Activity", isHoliday: true),
      "2026-08-15": const AcademicEvent(note: "Independence Day", isHoliday: true),
      "2026-08-22": const AcademicEvent(note: "Non-Professional Cell Activity", isHoliday: true),

      // September
      "2026-09-04": const AcademicEvent(note: "Krishna Jayanthi Holiday", isHoliday: true),
      "2026-09-12": const AcademicEvent(note: "Professional Cell Activity", isHoliday: true),
      "2026-09-26": const AcademicEvent(note: "Non-Professional Cell Activity", isHoliday: true),

      // October
      "2026-10-02": const AcademicEvent(note: "Gandhi Jayanthi Holiday", isHoliday: true),
      "2026-10-10": const AcademicEvent(note: "Professional Cell Activity", isHoliday: true),
      "2026-10-18": const AcademicEvent(note: "Ayutha Pooja", isHoliday: true),
      "2026-10-19": const AcademicEvent(note: "Ayutha Pooja Holiday", isHoliday: true),
      "2026-10-20": const AcademicEvent(note: "Vijaya Dasami", isHoliday: true),

      // November
      "2026-11-01": const AcademicEvent(note: "Kanyakumari Day", isHoliday: true),
      "2026-11-08": const AcademicEvent(note: "Deepavali", isHoliday: true),
      "2026-11-09": const AcademicEvent(note: "Deepavali Special Holiday", isHoliday: true),

      // December
      "2026-12-03": const AcademicEvent(note: "St. Xavier's Feast", isHoliday: true),
      "2026-12-04": const AcademicEvent(note: "Special Holiday", isHoliday: true),
      "2026-12-22": const AcademicEvent(note: "Christmas Celebration", isHoliday: false),
      "2026-12-23": const AcademicEvent(note: "Christmas Celebrations", isHoliday: true),
      "2026-12-24": const AcademicEvent(note: "Christmas Eve", isHoliday: true),
      "2026-12-25": const AcademicEvent(note: "Christmas", isHoliday: true),
      "2026-12-26": const AcademicEvent(note: "Alumni Day", isHoliday: false),

      // January
      "2027-01-01": const AcademicEvent(note: "New Year", isHoliday: true),
      "2027-01-04": const AcademicEvent(note: "Reopening Day (Even Semester)", isHoliday: false),
    };

    if (explicitEvents.containsKey(dateStr)) {
      return explicitEvents[dateStr];
    }

    // Christmas Holidays range: 27 December 2026 to 31 December 2026
    if (localDate.isAfter(DateTime(2026, 12, 26)) && localDate.isBefore(DateTime(2027, 1, 1))) {
      return const AcademicEvent(note: "Christmas Holidays", isHoliday: true);
    }

    // Examination Periods
    // CAT-I: 13 August 2026 to 25 August 2026
    if (_isWithinRange(localDate, DateTime(2026, 8, 13), DateTime(2026, 8, 25))) {
      return const AcademicEvent(note: "CAT-I Exam Period", isHoliday: true, isExam: true);
    }
    // CAT-II: 29 September 2026 to 12 October 2026
    if (_isWithinRange(localDate, DateTime(2026, 9, 29), DateTime(2026, 10, 12))) {
      return const AcademicEvent(note: "CAT-II Exam Period", isHoliday: true, isExam: true);
    }
    // Model Practical: 14 October 2026 to 23 October 2026
    if (_isWithinRange(localDate, DateTime(2026, 10, 14), DateTime(2026, 10, 23))) {
      return const AcademicEvent(note: "Model Practical Exam Period", isHoliday: true, isExam: true);
    }
    // Practical Exams: 02 November 2026 to 10 November 2026
    if (_isWithinRange(localDate, DateTime(2026, 11, 2), DateTime(2026, 11, 10))) {
      return const AcademicEvent(note: "Practical Examinations Period", isHoliday: true, isExam: true);
    }
    // Theory Exams: 17 November 2026 to 21 December 2026
    if (_isWithinRange(localDate, DateTime(2026, 11, 17), DateTime(2026, 12, 21))) {
      return const AcademicEvent(note: "Theory Examinations Period", isHoliday: true, isExam: true);
    }

    // Sundays
    if (localDate.weekday == DateTime.sunday) {
      return const AcademicEvent(note: "Sunday", isHoliday: true);
    }

    // Saturdays (Odd Saturdays are holidays)
    if (localDate.weekday == DateTime.saturday) {
      final ordinal = _getSaturdayOrdinal(localDate);
      if (ordinal == 1 || ordinal == 3 || ordinal == 5) {
        final Map<int, String> ordinalNames = {1: "First", 3: "Third", 5: "Fifth"};
        return AcademicEvent(note: "${ordinalNames[ordinal]} Saturday", isHoliday: true);
      }
      
      // Even Saturdays that are explicitly holidays in calendar schedule
      if (dateStr == "2026-11-14") return const AcademicEvent(note: "Second Saturday", isHoliday: true);
      if (dateStr == "2026-11-28") return const AcademicEvent(note: "Fourth Saturday", isHoliday: true);
      if (dateStr == "2026-12-12") return const AcademicEvent(note: "Second Saturday", isHoliday: true);
    }

    return null;
  }

  static bool _isWithinRange(DateTime date, DateTime start, DateTime end) {
    return !date.isBefore(start) && !date.isAfter(end);
  }

  static int _getSaturdayOrdinal(DateTime date) {
    int count = 0;
    int day = date.day;
    while (day > 0) {
      count++;
      day -= 7;
    }
    return count;
  }
}
