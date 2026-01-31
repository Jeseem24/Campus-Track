import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/theme/app_theme.dart';
import 'presentation/routes/app_router.dart';
import 'core/theme/modern_theme.dart';

import 'core/services/notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await NotificationService().init();
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
