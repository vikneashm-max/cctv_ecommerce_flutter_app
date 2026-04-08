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
        primaryColor: const Color(0xFF5538C9),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF5538C9),
          primary: const Color(0xFF5538C9),
          secondary: const Color(0xFF8A72F1),
          surface: Colors.white,
        ),
        textTheme: GoogleFonts.outfitTextTheme(Theme.of(context).textTheme),
        scaffoldBackgroundColor: const Color(0xFFF6F8FE),
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

