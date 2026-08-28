import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/services/notification_service.dart';

// State class for settings
class SettingsState {
  final bool notificationsEnabled;

  SettingsState({this.notificationsEnabled = false});

  SettingsState copyWith({bool? notificationsEnabled}) {
    return SettingsState(
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
    );
  }
}

// Notifier to manage settings state
class SettingsNotifier extends StateNotifier<SettingsState> {
  SettingsNotifier() : super(SettingsState()) {
    _loadSettings();
  }

  static const _notificationsKey = 'notifications_enabled';

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    final notificationsEnabled = prefs.getBool(_notificationsKey) ?? false;
    state = state.copyWith(notificationsEnabled: notificationsEnabled);
  }

  Future<void> toggleNotifications(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    
    if (value) {
      // Request permissions if enabling
      final granted = await NotificationService().requestPermissions();
      if (granted) {
        state = state.copyWith(notificationsEnabled: true);
        await prefs.setBool(_notificationsKey, true);
        
        // Schedule persistent reminders immediately
        await NotificationService().scheduleDailyPracticeReminder();
        await NotificationService().scheduleDailySummary();
      } else {
        // Permission denied, don't enable
        state = state.copyWith(notificationsEnabled: false);
        await prefs.setBool(_notificationsKey, false);
      }
    } else {
      // Disabling
      state = state.copyWith(notificationsEnabled: false);
      await prefs.setBool(_notificationsKey, false);
      
      // Cancel all notifications
      await NotificationService().cancelAll();
    }
  }
}

// Global provider
final settingsProvider = StateNotifierProvider<SettingsNotifier, SettingsState>((ref) {
  return SettingsNotifier();
});
