import 'package:flutter/material.dart';

class ThemeController {
  static final ValueNotifier<ThemeMode> themeMode =
      ValueNotifier<ThemeMode>(ThemeMode.light);

  static bool get isDarkMode =>
      themeMode.value == ThemeMode.dark;

  static void toggleTheme() {
    themeMode.value = isDarkMode
        ? ThemeMode.light
        : ThemeMode.dark;
  }
}