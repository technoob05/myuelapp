import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_text_styles.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: AppColors.scaffoldBackground,
      primaryColor: AppColors.primaryBlue,
      colorScheme: const ColorScheme.light(
        primary: AppColors.primaryBlue,
        secondary: AppColors.primaryBlueVariant,

        surface: AppColors.cardWhite,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.primaryBlue,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: AppTextStyles.headerTitle,
        iconTheme: const IconThemeData(color: AppColors.textWhite),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: AppColors.cardWhite,
        selectedItemColor: AppColors.iconSelected,
        unselectedItemColor: AppColors.iconUnselected,
        selectedLabelStyle: AppTextStyles.bodySmall.copyWith(
          fontWeight: FontWeight.w600,
          color: AppColors.iconSelected,
        ),
        unselectedLabelStyle: AppTextStyles.bodySmall.copyWith(
          color: AppColors.iconUnselected,
        ),
        type: BottomNavigationBarType.fixed,
        elevation: 16,
      ),
      cardTheme: CardThemeData(
        color: AppColors.cardWhite,
        elevation: 2,
        shadowColor: Colors.black.withValues(alpha: 0.05),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
    );
  }
}
