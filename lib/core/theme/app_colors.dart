import 'package:flutter/material.dart';

class AppColors {
  // Primary Core Colors
  static const Color primaryBlue = Color(0xFF00529C); // Deep blue from UEL logo
  static const Color primaryBlueVariant = Color(0xFF003D75); // Darker blue

  // Background Colors
  static const Color backgroundLight = Color(0xFFF5F7FA); // Soft off-white
  static const Color scaffoldBackground = Color(
    0xFFF0F4F8,
  ); // A bit deeper grey for scaffold
  static const Color cardWhite = Colors.white;

  // Features Background Colors
  static const Color featureIconBackground = Color(
    0xFFEAF1F8,
  ); // Very light blue for icon circles

  // Text Colors
  static const Color textDark = Color(0xFF1E293B);
  static const Color textBody = Color(0xFF475569);
  static const Color textLight = Color(0xFF94A3B8);
  static const Color textWhite = Colors.white;

  // Icon Colors
  static const Color iconPrimary = Color(
    0xFF00529C,
  ); // Blue icons on light background
  static const Color iconUnselected = Color(
    0xFF94A3B8,
  ); // Slate 400 for unselected nav
  static const Color iconSelected = primaryBlue;

  // Accent Colors
  static const Color errorRed = Color(0xFFEF4444);
  static const Color successGreen = Color(0xFF10B981);
  static const Color warningYellow = Color(0xFFF59E0B);
}
