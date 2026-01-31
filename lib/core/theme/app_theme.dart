import 'package:flutter/material.dart';

class AppTheme {
  static final lightTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xFF6750A4), // M3 Purple
      brightness: Brightness.light,
    ),
    scaffoldBackgroundColor: const Color(0xFFFDFBFE),
  );

  static final darkTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xFFD0BCFF),
      brightness: Brightness.dark,
    ),
    scaffoldBackgroundColor: const Color(0xFF1C1B1F),
  );
}
