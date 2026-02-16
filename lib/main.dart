import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
// import 'package:receive_sharing_intent/receive_sharing_intent.dart';
// import 'dart:async';
import 'core/theme/app_theme.dart';
import 'presentation/routes/app_router.dart';
import 'core/theme/modern_theme.dart';

import 'core/services/notification_service.dart';

// Provider for shared text (for future WhatsApp share feature)
final sharedTextProvider = StateProvider<String?>((ref) => null);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Load environment variables for AI features
  try {
    await dotenv.load(fileName: ".env");
  } catch (e) {
    debugPrint("Failed to load .env file: $e");
  }
  
  // Initialize notification service
  try {
    await NotificationService().init();
    // Schedule persistent reminders
    await NotificationService().scheduleDailyPracticeReminder();
  } catch (e) {
    debugPrint("Notification Service failed to initialize: $e");
  }

  runApp(
    const ProviderScope(
      child: CampusTrackApp(),
    ),
  );
}

class CampusTrackApp extends ConsumerWidget {
  const CampusTrackApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);

    return MaterialApp.router(
      title: 'CampusTrack',
      theme: ModernTheme.lightTheme,
      // darkTheme: ModernTheme.darkTheme, // Todo: Implement Dark
      themeMode: ThemeMode.light, // Force light for now as ModernTheme only has light
      routerConfig: router,
    );
  }
}

/* WhatsApp Share Feature - Coming in Next Update!
class CampusTrackApp extends ConsumerStatefulWidget {
  const CampusTrackApp({super.key});

  @override
  ConsumerState<CampusTrackApp> createState() => _CampusTrackAppState();
}

class _CampusTrackAppState extends ConsumerState<CampusTrackApp> {
  late StreamSubscription<String> _intentDataStreamSubscription;

  @override
  void initState() {
    super.initState();
    
    // Listen for shared text while app is closed
    ReceiveSharingIntent.getInitialText().then((String? value) {
      if (value != null &&  value.isNotEmpty) {
        debugPrint("Received shared text (app was closed): $value");
        ref.read(sharedTextProvider.notifier).state = value;
      }
    });

    // Listen for shared text while app is open
    _intentDataStreamSubscription = ReceiveSharingIntent.instance.getTextStream().listen(
      (String value) {
        debugPrint("Received shared text (app open): $value");
        ref.read(sharedTextProvider.notifier).state = value;
      },
      onError: (err) {
        debugPrint("Error receiving shared text: $err");
      },
    );
  }

  @override
  void dispose() {
    _intentDataStreamSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final router = ref.watch(appRouterProvider);

    return MaterialApp.router(
      title: 'CampusTrack',
      theme: ModernTheme.lightTheme,
      themeMode: ThemeMode.light,
      routerConfig: router,
    );
  }
}
*/
