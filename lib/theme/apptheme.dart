import 'package:flutter/material.dart';

class AppTheme {
  // Fresh neutral palette with soft accent
  static final ColorScheme _lightScheme = ColorScheme.fromSeed(
    seedColor: const Color(0xFF6C5CE7), // soft violet accent
    brightness: Brightness.light,
    background: Colors.white,
    surface: Colors.white,
    onPrimary: Colors.white,
  );

  static ThemeData light() {
    return ThemeData(
      useMaterial3: true,
      colorScheme: _lightScheme,
      scaffoldBackgroundColor: _lightScheme.surface,
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 2,
        centerTitle: true,
      ),
      textTheme: const TextTheme(
        bodyLarge: TextStyle(fontFamily: 'Josefin Sans'),
        bodyMedium: TextStyle(fontFamily: 'Josefin Sans'),
      ),
      cardTheme: CardThemeData(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 6,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 6,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    );
  }
}
