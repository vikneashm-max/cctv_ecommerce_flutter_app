import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screens/main_screen.dart';

void main() {
  runApp(const TNAutomationApp());
}

class TNAutomationApp extends StatelessWidget {
  const TNAutomationApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TN Automation',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        primaryColor: const Color(0xFF7039F7),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF7039F7),
          primary: const Color(0xFF7039F7),
          secondary: const Color(0xFF8A72F1),
          surface: const Color(0xFFFFFFFF),
          surfaceVariant: const Color(0xFFF7F7F7),
          onSurface: const Color(0xFF2A1263),
          onSurfaceVariant: const Color(0xFF7C808E),
        ),
        textTheme: GoogleFonts.outfitTextTheme(Theme.of(context).textTheme).copyWith(
          displayLarge: TextStyle(color: const Color(0xFF2A1263)),
          displayMedium: TextStyle(color: const Color(0xFF2A1263)),
          bodyLarge: TextStyle(color: const Color(0xFF2A1263)),
          bodyMedium: TextStyle(color: const Color(0xFF2A1263)),
        ),
        scaffoldBackgroundColor: const Color(0xFFF8F9FE),
        appBarTheme: const AppBarTheme(
          centerTitle: false,
          surfaceTintColor: Colors.transparent,
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
      ),
      home: const MainScreen(),
    );
  }
}

