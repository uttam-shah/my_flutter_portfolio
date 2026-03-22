import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // ================= COLORS =================
  static const Color primary = Color(0xFF6366F1);
  static const Color background = Color(0xFF0F172A);
  static const Color surface = Color(0xFF111827);
  static const Color textPrimary = Colors.white;
  static const Color textSecondary = Colors.white70;

  // ================= LIGHT THEME =================
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.dark, // 👈 portfolio style (dark UI)
    scaffoldBackgroundColor: background,

    // ✅ Global Font (Lexend)
    textTheme: GoogleFonts.lexendTextTheme().copyWith(
      // 🔥 HERO TEXT
      displayLarge: const TextStyle(
        fontSize: 66,
        fontWeight: FontWeight.bold,
        height: 1.1,
        color: textPrimary,
      ),

      // 🔥 SECTION TITLES
      headlineLarge: const TextStyle(
        fontSize: 36,
        fontWeight: FontWeight.bold,
        color: textPrimary,
      ),

      // 🔥 CARD / SUB TITLES
      titleLarge: const TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w600,
        color: textPrimary,
      ),

      // 🔥 BODY TEXT
      bodyLarge: const TextStyle(
        fontSize: 16,
        color: textSecondary,
      ),

      // 🔥 SMALL TEXT
      bodyMedium: const TextStyle(
        fontSize: 14,
        color: textSecondary,
      ),
    ),

    // ================= COLOR SCHEME =================
    colorScheme: const ColorScheme.dark(
      primary: primary,
      secondary: primary,
      surface: surface,
    ),

    // ================= APP BAR =================
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
    ),

    // ================= BUTTON =================
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primary,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    ),

    // // ================= CARD =================
    // cardTheme: CardTheme(
    //   color: surface,
    //   elevation: 0,
    //   shape: RoundedRectangleBorder(
    //     borderRadius: BorderRadius.circular(16),
    //   ),
    // ),

    // ================= INPUT =================
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: surface,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
    ),
  );
}