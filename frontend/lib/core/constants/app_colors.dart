import 'package:flutter/material.dart';

/// Centralized color palette following Saudi Umrah Cab Service design tokens.
class AppColors {
  AppColors._();

  // Primary Saudi Emerald Green Brand Colors
  static const Color primary = Color(0xFF0A6B48);
  static const Color primaryDark = Color(0xFF074E34);
  static const Color primaryLight = Color(0xFF109364);
  static const Color primarySurface = Color(0xFFE8F5E9);

  // Neutral Colors (Slate Grays & Whites)
  static const Color background = Color(0xFFF9FAFB);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color border = Color(0xFFE5E7EB);
  static const Color divider = Color(0xFFF3F4F6);

  // Text Colors
  static const Color textPrimary = Color(0xFF111827);
  static const Color textSecondary = Color(0xFF4B5563);
  static const Color textMuted = Color(0xFF9CA3AF);
  static const Color textOnPrimary = Color(0xFFFFFFFF);

  // Semantic Feedback Colors
  static const Color error = Color(0xFFDC2626);
  static const Color errorLight = Color(0xFFFEE2E2);
  static const Color success = Color(0xFF16A34A);
  static const Color warning = Color(0xFFD97706);
}
