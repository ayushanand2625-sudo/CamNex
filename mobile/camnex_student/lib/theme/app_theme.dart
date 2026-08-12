import 'package:flutter/material.dart';

class AppTheme {
  // ============================================
  // CAMNEX BRAND COLORS
  // ============================================

  static const Color primaryBlue = Color(0xFF3B82F6);
  static const Color darkBlue = Color(0xFF172033);

  static const Color primaryOrange = Color(0xFFFF6B00);
  static const Color darkOrange = Color(0xFFE85D00);
  static const Color lightOrange = Color(0xFFFFF8F1);

  // ============================================
  // LIGHT THEME COLORS
  // ============================================

  static const Color lightBackground = Color(0xFFF8F6F3);
  static const Color lightCard = Color(0xFFFFFCFA);
  static const Color lightSurface = Color(0xFFFFFFFF);

  static const Color lightTextPrimary = Color(0xFF172033);
  static const Color lightTextSecondary = Color(0xFF64748B);

  static const Color lightBorder = Color(0xFFF1E8DD);

  static const Color lightBlue = Color(0xFFF3F6FF);
  static const Color lightBlueBorder = Color(0xFFB8CDF5);

  // ============================================
  // DARK THEME COLORS
  // Natural system-style dark mode
  // ============================================

  static const Color darkBackground = Color(0xFF121212);
  static const Color darkCard = Color(0xFF1E1E1E);
  static const Color darkSurface = Color(0xFF181818);

  static const Color darkTextPrimary = Color(0xFFF5F5F5);
  static const Color darkTextSecondary = Color(0xFFB0B0B0);

  static const Color darkBorder = Color(0xFF383838);

  static const Color darkInput = Color(0xFF242424);
  static const Color darkHover = Color(0xFF2A2A2A);

  // ============================================
  // STATUS COLORS
  // ============================================

  static const Color danger = Color(0xFFDC2626);
  static const Color success = Color(0xFF16A34A);
  static const Color warning = Color(0xFFF59E0B);

  // ============================================
  // BACKWARD COMPATIBILITY
  // Existing screens can still use these constants
  // ============================================

  static const Color background = lightBackground;
  static const Color card = lightCard;

  static const Color textPrimary = lightTextPrimary;
  static const Color textSecondary = lightTextSecondary;

  static const Color border = lightBorder;

  static const Color white = Colors.white;

  // ============================================
  // LIGHT THEME
  // ============================================

  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,

    scaffoldBackgroundColor: lightBackground,

    primaryColor: primaryBlue,

    colorScheme: const ColorScheme.light(
      primary: primaryBlue,
      secondary: primaryOrange,
      surface: lightCard,
      error: danger,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: lightTextPrimary,
      onError: Colors.white,
    ),

    // ============================================
    // APP BAR
    // ============================================

    appBarTheme: const AppBarTheme(
      backgroundColor: lightSurface,
      foregroundColor: lightTextPrimary,
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      centerTitle: false,
      titleTextStyle: TextStyle(
        color: lightTextPrimary,
        fontSize: 22,
        fontWeight: FontWeight.w700,
      ),
    ),

    // ============================================
    // CARDS
    // ============================================

    cardTheme: CardThemeData(
      color: lightCard,
      elevation: 1,
      margin: EdgeInsets.zero,
      surfaceTintColor: Colors.transparent,
      shadowColor: Colors.black.withValues(alpha: 0.08),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    ),

    // ============================================
    // TEXT
    // ============================================

    textTheme: const TextTheme(
      displayLarge: TextStyle(
        color: lightTextPrimary,
      ),
      displayMedium: TextStyle(
        color: lightTextPrimary,
      ),
      displaySmall: TextStyle(
        color: lightTextPrimary,
      ),
      headlineLarge: TextStyle(
        color: lightTextPrimary,
      ),
      headlineMedium: TextStyle(
        color: lightTextPrimary,
      ),
      headlineSmall: TextStyle(
        color: lightTextPrimary,
      ),
      titleLarge: TextStyle(
        color: lightTextPrimary,
        fontWeight: FontWeight.w700,
      ),
      titleMedium: TextStyle(
        color: lightTextPrimary,
        fontWeight: FontWeight.w600,
      ),
      titleSmall: TextStyle(
        color: lightTextPrimary,
        fontWeight: FontWeight.w600,
      ),
      bodyLarge: TextStyle(
        color: lightTextPrimary,
      ),
      bodyMedium: TextStyle(
        color: lightTextPrimary,
      ),
      bodySmall: TextStyle(
        color: lightTextSecondary,
      ),
      labelLarge: TextStyle(
        color: lightTextPrimary,
        fontWeight: FontWeight.w600,
      ),
    ),

    // ============================================
    // ICONS
    // ============================================

    iconTheme: const IconThemeData(
      color: lightTextPrimary,
    ),

    // ============================================
    // DIVIDER
    // ============================================

    dividerTheme: const DividerThemeData(
      color: lightBorder,
      thickness: 1,
      space: 1,
    ),

    // ============================================
    // ELEVATED BUTTON
    // ============================================

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryBlue,
        foregroundColor: Colors.white,
        elevation: 0,
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 14,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        textStyle: const TextStyle(
          fontWeight: FontWeight.w600,
        ),
      ),
    ),

    // ============================================
    // OUTLINED BUTTON
    // ============================================

    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: primaryBlue,
        side: const BorderSide(
          color: primaryBlue,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 14,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        textStyle: const TextStyle(
          fontWeight: FontWeight.w600,
        ),
      ),
    ),

    // ============================================
    // TEXT BUTTON
    // ============================================

    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: primaryBlue,
        textStyle: const TextStyle(
          fontWeight: FontWeight.w600,
        ),
      ),
    ),

    // ============================================
    // INPUT FIELDS
    // ============================================

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: lightCard,

      hintStyle: const TextStyle(
        color: lightTextSecondary,
      ),

      labelStyle: const TextStyle(
        color: lightTextSecondary,
      ),

      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(
          color: lightBorder,
        ),
      ),

      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(
          color: lightBorder,
        ),
      ),

      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(
          color: primaryBlue,
          width: 2,
        ),
      ),

      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(
          color: danger,
        ),
      ),

      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(
          color: danger,
          width: 2,
        ),
      ),
    ),

    // ============================================
    // SWITCH
    // ============================================

    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith<Color?>(
        (states) {
          if (states.contains(WidgetState.selected)) {
            return primaryBlue;
          }

          return Colors.grey.shade400;
        },
      ),
      trackColor: WidgetStateProperty.resolveWith<Color?>(
        (states) {
          if (states.contains(WidgetState.selected)) {
            return primaryBlue.withValues(alpha: 0.35);
          }

          return Colors.grey.shade300;
        },
      ),
    ),

    // ============================================
    // LIST TILE
    // ============================================

    listTileTheme: const ListTileThemeData(
      iconColor: lightTextPrimary,
      textColor: lightTextPrimary,
    ),

    // ============================================
    // DIALOG
    // ============================================

    dialogTheme: DialogThemeData(
      backgroundColor: lightCard,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    ),

    // ============================================
    // SNACKBAR
    // ============================================

    snackBarTheme: const SnackBarThemeData(
      backgroundColor: Color(0xFF323232),
      contentTextStyle: TextStyle(
        color: Colors.white,
      ),
      behavior: SnackBarBehavior.floating,
    ),
  );

  // ============================================
  // DARK THEME
  // ============================================

  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,

    scaffoldBackgroundColor: darkBackground,

    primaryColor: primaryBlue,

    colorScheme: const ColorScheme.dark(
      primary: primaryBlue,
      secondary: primaryOrange,
      surface: darkCard,
      error: Color(0xFFFF6B6B),
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: darkTextPrimary,
      onError: Colors.white,
    ),

    // ============================================
    // APP BAR
    // ============================================

    appBarTheme: const AppBarTheme(
      backgroundColor: darkSurface,
      foregroundColor: darkTextPrimary,
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      centerTitle: false,
      titleTextStyle: TextStyle(
        color: darkTextPrimary,
        fontSize: 22,
        fontWeight: FontWeight.w700,
      ),
    ),

    // ============================================
    // CARDS
    // ============================================

    cardTheme: CardThemeData(
      color: darkCard,
      elevation: 0,
      margin: EdgeInsets.zero,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(
          color: darkBorder,
          width: 1,
        ),
      ),
    ),

    // ============================================
    // TEXT
    // ============================================

    textTheme: const TextTheme(
      displayLarge: TextStyle(
        color: darkTextPrimary,
      ),
      displayMedium: TextStyle(
        color: darkTextPrimary,
      ),
      displaySmall: TextStyle(
        color: darkTextPrimary,
      ),
      headlineLarge: TextStyle(
        color: darkTextPrimary,
      ),
      headlineMedium: TextStyle(
        color: darkTextPrimary,
      ),
      headlineSmall: TextStyle(
        color: darkTextPrimary,
      ),
      titleLarge: TextStyle(
        color: darkTextPrimary,
        fontWeight: FontWeight.w700,
      ),
      titleMedium: TextStyle(
        color: darkTextPrimary,
        fontWeight: FontWeight.w600,
      ),
      titleSmall: TextStyle(
        color: darkTextPrimary,
        fontWeight: FontWeight.w600,
      ),
      bodyLarge: TextStyle(
        color: darkTextPrimary,
      ),
      bodyMedium: TextStyle(
        color: darkTextPrimary,
      ),
      bodySmall: TextStyle(
        color: darkTextSecondary,
      ),
      labelLarge: TextStyle(
        color: darkTextPrimary,
        fontWeight: FontWeight.w600,
      ),
    ),

    // ============================================
    // ICONS
    // ============================================

    iconTheme: const IconThemeData(
      color: darkTextPrimary,
    ),

    // ============================================
    // DIVIDER
    // ============================================

    dividerTheme: const DividerThemeData(
      color: darkBorder,
      thickness: 1,
      space: 1,
    ),

    // ============================================
    // ELEVATED BUTTON
    // ============================================

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryBlue,
        foregroundColor: Colors.white,
        elevation: 0,
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 14,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        textStyle: const TextStyle(
          fontWeight: FontWeight.w600,
        ),
      ),
    ),

    // ============================================
    // OUTLINED BUTTON
    // ============================================

    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: primaryBlue,
        side: const BorderSide(
          color: Color(0xFF4D8DFF),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 14,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        textStyle: const TextStyle(
          fontWeight: FontWeight.w600,
        ),
      ),
    ),

    // ============================================
    // TEXT BUTTON
    // ============================================

    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: const Color(0xFF78A9FF),
        textStyle: const TextStyle(
          fontWeight: FontWeight.w600,
        ),
      ),
    ),

    // ============================================
    // INPUT FIELDS
    // ============================================

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: darkInput,

      hintStyle: const TextStyle(
        color: darkTextSecondary,
      ),

      labelStyle: const TextStyle(
        color: darkTextSecondary,
      ),

      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(
          color: darkBorder,
        ),
      ),

      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(
          color: darkBorder,
        ),
      ),

      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(
          color: primaryBlue,
          width: 2,
        ),
      ),

      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(
          color: danger,
        ),
      ),

      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(
          color: danger,
          width: 2,
        ),
      ),
    ),

    // ============================================
    // SWITCH
    // ============================================

    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith<Color?>(
        (states) {
          if (states.contains(WidgetState.selected)) {
            return primaryBlue;
          }

          return const Color(0xFF9CA3AF);
        },
      ),
      trackColor: WidgetStateProperty.resolveWith<Color?>(
        (states) {
          if (states.contains(WidgetState.selected)) {
            return primaryBlue.withValues(alpha: 0.45);
          }

          return const Color(0xFF454B54);
        },
      ),
    ),

    // ============================================
    // LIST TILE
    // ============================================

    listTileTheme: const ListTileThemeData(
      iconColor: darkTextPrimary,
      textColor: darkTextPrimary,
    ),

    // ============================================
    // DIALOG
    // ============================================

    dialogTheme: DialogThemeData(
      backgroundColor: darkCard,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: const BorderSide(
          color: darkBorder,
        ),
      ),
    ),

    // ============================================
    // SNACKBAR
    // ============================================

    snackBarTheme: const SnackBarThemeData(
      backgroundColor: Color(0xFF2A2A2A),
      contentTextStyle: TextStyle(
        color: Colors.white,
      ),
      behavior: SnackBarBehavior.floating,
    ),
  );
}