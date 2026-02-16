import 'dart:convert';

class DailyPracticeLog {
  final DateTime date;
  final String? jsProblem;
  final String? dsaProblem;
  final String? aptitudeTopic;

  DailyPracticeLog({
    required this.date,
    this.jsProblem,
    this.dsaProblem,
    this.aptitudeTopic,
  });

  DailyPracticeLog copyWith({
    DateTime? date,
    String? jsProblem,
    String? dsaProblem,
    String? aptitudeTopic,
  }) {
    return DailyPracticeLog(
      date: date ?? this.date,
      jsProblem: jsProblem ?? this.jsProblem,
      dsaProblem: dsaProblem ?? this.dsaProblem,
      aptitudeTopic: aptitudeTopic ?? this.aptitudeTopic,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'date': date.millisecondsSinceEpoch,
      'jsProblem': jsProblem,
      'dsaProblem': dsaProblem,
      'aptitudeTopic': aptitudeTopic,
    };
  }

  factory DailyPracticeLog.fromMap(Map<String, dynamic> map) {
    return DailyPracticeLog(
      date: DateTime.fromMillisecondsSinceEpoch(map['date']),
      jsProblem: map['jsProblem'],
      dsaProblem: map['dsaProblem'],
      aptitudeTopic: map['aptitudeTopic'],
    );
  }

  String toJson() => json.encode(toMap());

  factory DailyPracticeLog.fromJson(String source) => DailyPracticeLog.fromMap(json.decode(source));

  bool get isComplete => 
    (jsProblem != null && jsProblem!.isNotEmpty) || 
    (dsaProblem != null && dsaProblem!.isNotEmpty) || 
    (aptitudeTopic != null && aptitudeTopic!.isNotEmpty);
}
