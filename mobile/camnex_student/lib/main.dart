import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'theme/app_theme.dart';
import 'screens/splash_screen.dart';

import 'providers/student_provider.dart';
import 'providers/parent_homework_provider.dart';
import 'providers/theme_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => StudentProvider(),
        ),

        ChangeNotifierProvider(
          create: (_) => ParentHomeworkProvider(),
        ),

        ChangeNotifierProvider(
          create: (_) => ThemeProvider(),
        ),
      ],
      child: const CamNexApp(),
    ),
  );
}

class CamNexApp extends StatelessWidget {
  const CamNexApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider =
        Provider.of<ThemeProvider>(context);

    return MaterialApp(
      title: 'CamNex',

      debugShowCheckedModeBanner: false,

      theme: AppTheme.lightTheme,

      darkTheme: AppTheme.darkTheme,

      themeMode: themeProvider.isDarkMode
          ? ThemeMode.dark
          : ThemeMode.light,

      home: const SplashScreen(),
    );
  }
}