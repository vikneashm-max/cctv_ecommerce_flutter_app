import 'package:flutter/material.dart';

class AppColors {
  // Foundation (Light)
  static const Color foundation = Color(0xFFF9F9FC); 
  
  // Brand Colors
  static const Color primary = Color(0xFF0052FF); 
  static const Color primaryContainer = Color(0xFF0052FF);
  static const Color onPrimary = Colors.white;
  static const Color secondary = Color(0xFFF0F4FF);
  static const Color tertiary = Color(0xFFBF3003); // Added back for product details
  
  // Surface Levels
  static const Color surface = Colors.white;
  static const Color surfaceLevel1 = Colors.white; // Alias for backward compatibility
  static const Color surfaceLevel2 = Color(0xFFF3F3F6); // Alias for backward compatibility
  static const Color surfaceVariant = Color(0xFFF3F3F6); 
  static const Color productCardBackground = Colors.white; 
  
  // Text Colors
  static const Color onSurface = Color(0xFF1A1C1E); 
  static const Color onSurfaceLight = Color(0xFF1A1C1E); // Alias for backward compatibility
  static const Color onSurfaceVariant = Color(0xFF6B6E7B); 
  
  // Others
  static const Color outline = Color(0xFFE2E2E5);
  static const Color error = Color(0xFFBA1A1A);
  static const Color success = Color(0xFF00C853);
}
