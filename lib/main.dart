import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screens/main_screen.dart';
import 'screens/login_screen.dart';
import 'services/theme_service.dart';

void main() {
  runApp(const TNAutomationApp());
}

class TNAutomationApp extends StatelessWidget {
  const TNAutomationApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: ThemeService().themeMode,
      builder: (context, mode, child) {
        final isDark = mode == ThemeMode.dark;
        return MaterialApp(
          title: 'TN Automation',
          debugShowCheckedModeBanner: false,
          themeMode: mode,
          theme: ThemeData(
            useMaterial3: true,
            brightness: isDark ? Brightness.dark : Brightness.light,
            primaryColor: isDark ? const Color(0xFFADC7FF) : const Color(0xFF1A73E8),
            scaffoldBackgroundColor: isDark ? const Color(0xFF121315) : const Color(0xFFF8F9FE),
            colorScheme: ColorScheme.fromSeed(
              seedColor: const Color(0xFF1A73E8),
              brightness: isDark ? Brightness.dark : Brightness.light,
            ),
            textTheme: GoogleFonts.interTextTheme(
              isDark ? ThemeData.dark().textTheme : ThemeData.light().textTheme,
            ),
          ),
          home: LoginScreen(),
        );
      },
    );
  }
}


