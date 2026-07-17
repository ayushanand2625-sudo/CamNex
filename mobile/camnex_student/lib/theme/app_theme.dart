import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    primaryColor: Color(0xFF0057D9),

    colorScheme: ColorScheme.light(
      primary: Color(0xFF0057D9),
      secondary: Color(0xFFFF6B00),
    ),

    scaffoldBackgroundColor: Colors.white,

    appBarTheme: AppBarTheme(
      backgroundColor: Color(0xFF0057D9),
      foregroundColor: Colors.white,
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xFFFF6B00),
        foregroundColor: Colors.white,
      ),
    ),
  );
}