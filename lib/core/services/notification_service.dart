import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz_data;
import 'package:timezone/timezone.dart' as tz;
import '../../domain/entities/task.dart';
import '../../domain/entities/exam.dart';

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  final FlutterLocalNotificationsPlugin _notifications = FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    tz_data.initializeTimeZones();
    
    const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );
    
    const initSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _notifications.initialize(
      initSettings,
      onDidReceiveNotificationResponse: (response) {
        print('🔔 Notification tapped: ${response.payload}');
      },
    );

    // Create channel explicitly for Android
    final android = _notifications.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();
    if (android != null) {
      await android.createNotificationChannel(
        const AndroidNotificationChannel(
          'campus_track_channel',
          'CampusTrack Alerts',
          description: 'General notifications for CampusTrack',
          importance: Importance.max,
        ),
      );
    }
  }

  Future<bool> requestPermissions() async {
    final android = _notifications.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();
    if (android != null) {
      final granted = await android.requestNotificationsPermission();
      print("🔔 Permission request result: $granted");
      return granted ?? false;
    }
    return false;
  }

  Future<void> showInstantNotification(String title, String body) async {
    print("🔔 Showing notification: $title - $body"); // Debug log for user
    const androidDetails = AndroidNotificationDetails(
      'campus_track_channel',
      'CampusTrack Alerts',
      channelDescription: 'General notifications for CampusTrack',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
    );
    
    await _notifications.show(
      DateTime.now().millisecond, // Unique ID
      title,
      body,
      const NotificationDetails(android: androidDetails),
    );
  }

  /// Schedule daily morning summary at 8 AM
  Future<void> scheduleDailySummary() async {
    await _notifications.zonedSchedule(
      1, // ID
      '📚 Good Morning!',
      'Here are your tasks for today',
      _scheduleDaily(8, 0), // 8:00 AM
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'daily_summary',
          'Daily Summary',
          channelDescription: 'Morning summary of tasks',
          importance: Importance.high,
          priority: Priority.high,
        ),
        iOS: DarwinNotificationDetails(),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  /// Schedule assignment reminder
  Future<void> scheduleAssignmentReminder(Task task, DateTime deadline) async {
    if (task.id == null) return;

    // Reminder 1 day before
    final oneDayBefore = deadline.subtract(const Duration(days: 1));
    if (oneDayBefore.isAfter(DateTime.now())) {
      await _notifications.zonedSchedule(
        task.id! * 10 + 1,
        '⚠️ Assignment Due Tomorrow',
        task.title,
        tz.TZDateTime.from(oneDayBefore, tz.local),
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'assignments',
            'Assignments',
            channelDescription: 'Assignment reminders',
            importance: Importance.high,
            priority: Priority.high,
          ),
          iOS: DarwinNotificationDetails(),
        ),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        payload: 'task:${task.id}',
      );
    }

    // Reminder 3 days before
    final threeDaysBefore = deadline.subtract(const Duration(days: 3));
    if (threeDaysBefore.isAfter(DateTime.now())) {
      await _notifications.zonedSchedule(
        task.id! * 10 + 2,
        '📅 Assignment Due in 3 Days',
        task.title,
        tz.TZDateTime.from(threeDaysBefore, tz.local),
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'assignments',
            'Assignments',
            channelDescription: 'Assignment reminders',
            importance: Importance.defaultImportance,
            priority: Priority.defaultPriority,
          ),
          iOS: DarwinNotificationDetails(),
        ),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        payload: 'task:${task.id}',
      );
    }
  }

  /// Schedule exam reminder
  Future<void> scheduleExamReminder(Exam exam) async {
    if (exam.id == null) return;

    final examDate = DateTime.fromMillisecondsSinceEpoch(exam.date);

    // 1 week before
    final oneWeekBefore = examDate.subtract(const Duration(days: 7));
    if (oneWeekBefore.isAfter(DateTime.now())) {
      await _notifications.zonedSchedule(
        exam.id! * 100 + 1,
        '📖 Exam in 1 Week',
        '${exam.title} - Start preparing!',
        tz.TZDateTime.from(oneWeekBefore, tz.local),
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'exams',
            'Exams',
            channelDescription: 'Exam reminders',
            importance: Importance.max,
            priority: Priority.max,
          ),
          iOS: DarwinNotificationDetails(),
        ),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        payload: 'exam:${exam.id}',
      );
    }

    // Day before
    final dayBefore = examDate.subtract(const Duration(days: 1));
    if (dayBefore.isAfter(DateTime.now())) {
      await _notifications.zonedSchedule(
        exam.id! * 100 + 3,
        '🔥 Exam Tomorrow!',
        '${exam.title} - Final revision',
        tz.TZDateTime.from(dayBefore, tz.local),
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'exams',
            'Exams',
            channelDescription: 'Exam reminders',
            importance: Importance.max,
            priority: Priority.max,
          ),
          iOS: DarwinNotificationDetails(),
        ),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        payload: 'exam:${exam.id}',
      );
    }
  }

  /// Show AI suggestion notification
  Future<void> showSuggestion(String title, String body) async {
    await _notifications.show(
      DateTime.now().millisecondsSinceEpoch ~/ 1000,
      '💡 $title',
      body,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'suggestions',
          'AI Suggestions',
          channelDescription: 'Smart suggestions from AI',
          importance: Importance.defaultImportance,
          priority: Priority.defaultPriority,
        ),
        iOS: DarwinNotificationDetails(),
      ),
    );
  }

  /// Cancel all notifications
  Future<void> cancelAll() async {
    await _notifications.cancelAll();
  }

  // Helper to schedule daily recurring notification
  tz.TZDateTime _scheduleDaily(int hour, int minute) {
    final now = tz.TZDateTime.now(tz.local);
    var scheduledDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      hour,
      minute,
    );

    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }

    return scheduledDate;
  }
  // Schedule Daily Practice Reminder (6 PM)
  Future<void> scheduleDailyPracticeReminder() async {
    await _notifications.zonedSchedule(
      777, // Special ID for practice
      '🚀 Daily Growth Time!',
      'Time to solve 1 JS, 1 DSA, and practice Aptitude! 💪',
      _scheduleDaily(18, 0), // 18:00 = 6 PM
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'daily_practice',
          'Daily Practice',
          channelDescription: 'Reminders for daily technical practice',
          importance: Importance.high,
          priority: Priority.high,
        ),
        iOS: DarwinNotificationDetails(),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }
}
