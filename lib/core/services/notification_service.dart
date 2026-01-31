import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz_data;

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  final FlutterLocalNotificationsPlugin _notifications = FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    tz_data.initializeTimeZones();
    
    const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    const initSettings = InitializationSettings(android: androidSettings);

    await _notifications.initialize(
      initSettings,
      onDidReceiveNotificationResponse: (response) {
        // Handle tap - can navigate to specific screen
      },
    );
  }

  Future<bool> requestPermissions() async {
    final android = _notifications.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();
    if (android != null) {
      final granted = await android.requestNotificationsPermission();
      return granted ?? false;
    }
    return false;
  }

  Future<void> showInstantNotification(String title, String body) async {
    const androidDetails = AndroidNotificationDetails(
      'campus_track_channel',
      'CampusTrack Alerts',
      channelDescription: 'General notifications for CampusTrack',
      importance: Importance.max,
      priority: Priority.high,
    );
    
    await _notifications.show(
      0,
      title,
      body,
      const NotificationDetails(android: androidDetails),
    );
  }

  // TODO: Add scheduled notifications later once API is confirmed working
  // For now, instant notifications are available for testing
}
