import 'package:flutter/material.dart';
import '../services/theme_service.dart';

class AppColors {
  static bool get _isDark => ThemeService().isDarkMode;

  // Foundation & Surfaces
  static Color get foundation => _isDark ? const Color(0xFF121315) : const Color(0xFFF8F9FE);
  static Color get surfaceLevel1 => _isDark ? const Color(0xFF1B1C1E) : const Color(0xFFFFFFFF);
  static Color get surfaceLevel2 => _isDark ? const Color(0xFF1F2022) : const Color(0xFFF1F4F9);
  static Color get surfaceLevel3 => _isDark ? const Color(0xFF292A2C) : const Color(0xFFE8EEF6);
  
  // Brand Colors
  static Color get primary => _isDark ? const Color(0xFFADC7FF) : const Color(0xFF1A73E8);
  static Color get primaryContainer => _isDark ? const Color(0xFF1A73E8) : const Color(0xFFD3E3FD);
  static Color get tertiary => _isDark ? const Color(0xFFFFB691) : const Color(0xFFE96E22);
  
  // Text Colors
  static Color get onSurface => _isDark ? const Color(0xFFE3E2E5) : const Color(0xFF1A1C1E);
  static Color get onSurfaceVariant => _isDark ? const Color(0xFF94A3B8) : const Color(0xFF44474E);
  
  // Status Colors
  static Color get error => _isDark ? const Color(0xFFFFB4AB) : const Color(0xFFBA1A1A);
  static Color get success => const Color(0xFF10B981);
  
  // Glassmorphism
  static Color glassBackground(double opacity) => surfaceLevel2.withOpacity(opacity);
}

