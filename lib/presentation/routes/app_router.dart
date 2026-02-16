import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../screens/home_screen.dart';
import '../screens/settings_screen.dart'; // New Import
import '../screens/setup/semester_setup_screen.dart';
import '../screens/calendar_screen.dart';
import '../screens/timetable_editor_screen.dart'; // New Import
// import '../screens/ai_assistant_screen.dart'; // AI Assistant Import - DISABLED
// import '../screens/daily_practice_screen.dart'; // Daily Practice Import - DISABLED


import '../screens/subjects_screen.dart';
import '../../domain/providers/active_semester_provider.dart';
import '../../domain/entities/semester.dart';

part 'app_router.g.dart';

@riverpod
GoRouter appRouter(AppRouterRef ref) {
  final activeSemesterAsync = ref.watch(activeSemesterProvider);

  return GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) {
          // Logic: Check state
          return activeSemesterAsync.when(
            data: (semester) {
              if (semester == null) {
                return const SemesterSetupScreen();
              }
              return const HomeScreen();
            },
            loading: () => const Scaffold(body: Center(child: CircularProgressIndicator())),
            error: (err, stack) => Scaffold(body: Center(child: Text("Error: $err"))),
          );
        },
      ),
      GoRoute(
        path: '/setup',
        builder: (context, state) => const SemesterSetupScreen(),
      ),
      GoRoute(
        path: '/calendar',
        builder: (context, state) => const CalendarScreen(),
      ),

      GoRoute(
        path: '/subjects',
        builder: (context, state) => const SubjectsScreen(),
      ),
      GoRoute(
        path: '/timetable-editor',
        builder: (context, state) => const TimetableEditorScreen(),
      ),
      GoRoute(
        path: '/settings',
        builder: (context, state) => const SettingsScreen(),
      ),
      // GoRoute(
      //   path: '/ai-assistant',
      //   builder: (context, state) => const AIAssistantScreen(),
      // ),
      // GoRoute(
      //   path: '/daily-practice',
      //   builder: (context, state) => const DailyPracticeScreen(),
      // ),
    ],
  );
}
