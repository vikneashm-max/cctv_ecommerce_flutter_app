import 'package:flutter/material.dart';

class ThemeService {
  static final ThemeService _instance = ThemeService._internal();
  factory ThemeService() => _instance;
  ThemeService._internal();

  final ValueNotifier<ThemeMode> themeMode = ValueNotifier(ThemeMode.dark);

  void toggleTheme() {
    themeMode.value = themeMode.value == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
  }

  bool get isDarkMode => themeMode.value == ThemeMode.dark;
}
