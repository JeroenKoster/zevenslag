import 'package:flutter/material.dart';

class AppTheme {
  static const Color greenFelt = Color(0xFF1B5E20); // Colors.green.shade900
  static const Color greenFeltLight =
      Color(0xFF2E7D32); // Colors.green.shade800
  static const Color cardColor = Colors.white;
  static const Color cardBackBlue = Color(0xFF0D47A1); // Colors.blue.shade900
  static const Color accentYellow = Colors.yellow;

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: greenFelt,
        primary: greenFelt,
        secondary: accentYellow,
        surface: greenFeltLight,
      ),
      scaffoldBackgroundColor: greenFelt,
      appBarTheme: const AppBarTheme(
        backgroundColor: greenFeltLight, // Slightly lighter for app bar
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: accentYellow,
          foregroundColor: Colors.black,
          textStyle: const TextStyle(fontWeight: FontWeight.bold),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
      // Add other component themes here
    );
  }
}

// Extension for custom game colors if needed later
extension GameColors on ThemeData {
  Color get feltColor => AppTheme.greenFelt;
  Color get cardBack => AppTheme.cardBackBlue;
}
