import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ModernTheme {
  // Brand Colors
  static const Color primary = Color(0xFF2D3436); // Obsidian Grey
  static const Color onPrimary = Colors.white;
  static const Color secondary = Color(0xFF6C5CE7); // Soft Purple Accent
  static const Color background = Color(0xFFF8F9FA); // Off-white clean background
  static const Color surface = Colors.white;
  static const Color error = Color(0xFFD63031);
  
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      
      // Color Scheme
      colorScheme: ColorScheme.fromSeed(
        seedColor: secondary,
        primary: primary,
        secondary: secondary,
        background: background,
        surface: surface,
        error: error,
        brightness: Brightness.light,
      ),

      // Typography
      textTheme: GoogleFonts.poppinsTextTheme().copyWith(
        displayLarge: const TextStyle(fontWeight: FontWeight.bold, letterSpacing: -1.0),
        titleLarge: const TextStyle(fontWeight: FontWeight.w600),
      ),

      // Card Theme (Minimalist)
      cardTheme: CardThemeData(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: Colors.grey.shade200, width: 1),
        ),
        color: surface,
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      ),

      // AppBar Theme
      appBarTheme: const AppBarTheme(
        backgroundColor: background,
        foregroundColor: primary,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: TextStyle(
          color: primary,
          fontSize: 24,
          fontWeight: FontWeight.bold,
          fontFamily: 'Poppins'
        )
      ),

      // Button Themes
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: primary,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          elevation: 0,
        ),
      ),
      
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: primary,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          side: const BorderSide(color: primary, width: 1.5),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        ),
      ),

      // Input Decoration
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.grey.shade100,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: primary, width: 1.5),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      ),
      
      scaffoldBackgroundColor: background,
    );
  }
}
