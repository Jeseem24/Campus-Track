import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/entities/daily_practice_log.dart';

// Provider for the list of all logs (history)
final dailyPracticeLogsProvider = StateNotifierProvider<DailyPracticeNotifier, Map<DateTime, DailyPracticeLog>>((ref) {
  return DailyPracticeNotifier();
});

// Provider for today's log (derived)
final todayPracticeLogProvider = Provider<DailyPracticeLog>((ref) {
  final logs = ref.watch(dailyPracticeLogsProvider);
  final today = DateTime.now();
  final todayKey = DateTime(today.year, today.month, today.day);
  
  return logs[todayKey] ?? DailyPracticeLog(date: todayKey);
});

class DailyPracticeNotifier extends StateNotifier<Map<DateTime, DailyPracticeLog>> {
  DailyPracticeNotifier() : super({}) {
    _loadLogs();
  }

  static const String _storageKey = 'daily_practice_logs';

  Future<void> _loadLogs() async {
    final prefs = await SharedPreferences.getInstance();
    final String? logsJson = prefs.getString(_storageKey);

    if (logsJson != null) {
      final List<dynamic> decoded = json.decode(logsJson);
      final Map<DateTime, DailyPracticeLog> loadedLogs = {};
      
      for (var item in decoded) {
        final log = DailyPracticeLog.fromMap(item);
        // Normalize date to midnight for consistent keys
        final dateKey = DateTime(log.date.year, log.date.month, log.date.day);
        loadedLogs[dateKey] = log;
      }
      state = loadedLogs;
    }
  }

  Future<void> _saveLogs() async {
    final prefs = await SharedPreferences.getInstance();
    final List<Map<String, dynamic>> logsList = state.values.map((log) => log.toMap()).toList();
    await prefs.setString(_storageKey, json.encode(logsList));
  }

  Future<void> updateJsProblem(String problemName) async {
    final today = DateTime.now();
    final todayKey = DateTime(today.year, today.month, today.day);
    
    final currentLog = state[todayKey] ?? DailyPracticeLog(date: todayKey);
    final updatedLog = currentLog.copyWith(jsProblem: problemName);
    
    state = {...state, todayKey: updatedLog};
    await _saveLogs();
  }

  Future<void> updateDsaProblem(String problemName) async {
    final today = DateTime.now();
    final todayKey = DateTime(today.year, today.month, today.day);
    
    final currentLog = state[todayKey] ?? DailyPracticeLog(date: todayKey);
    final updatedLog = currentLog.copyWith(dsaProblem: problemName);
    
    state = {...state, todayKey: updatedLog};
    await _saveLogs();
  }

  Future<void> updateAptitudeTopic(String topic) async {
    final today = DateTime.now();
    final todayKey = DateTime(today.year, today.month, today.day);
    
    final currentLog = state[todayKey] ?? DailyPracticeLog(date: todayKey);
    final updatedLog = currentLog.copyWith(aptitudeTopic: topic);
    
    state = {...state, todayKey: updatedLog};
    await _saveLogs();
  }
}
