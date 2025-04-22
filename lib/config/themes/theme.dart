import 'package:comunidadesucv/config/constants/colors.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static bool isLightTheme = false;

  static ThemeData getTheme() {
    if (isLightTheme) {
      return lightTheme();
    } else {
      return darkTheme();
    }
  }

  static TextTheme _buildTextTheme(TextTheme base) {
    return base.copyWith(
      titleLarge: TextStyle(
        fontSize: 30,
        fontFamily: 'Montserrat', // Especificar la fuente
        color: isLightTheme ? AppColors.textLight : AppColors.textDark,
        fontWeight: FontWeight.bold,
      ),
      titleMedium: TextStyle(
        fontSize: 24,
        fontFamily: 'Montserrat',
        color: isLightTheme ? AppColors.textLight : AppColors.textDark,
        fontWeight: FontWeight.w500,
      ),
      titleSmall: TextStyle(
        fontSize: 24,
        fontFamily: 'Montserrat',
        color: isLightTheme ? AppColors.textLight : AppColors.textDark,
        fontWeight: FontWeight.w600,
      ),
      bodyLarge: TextStyle(
        fontSize: 16,
        fontFamily: 'Montserrat',
        color: isLightTheme ? AppColors.textLight : AppColors.textDark,
        fontWeight: FontWeight.bold,
      ),
      bodyMedium: TextStyle(
        fontSize: 16,
        fontFamily: 'Montserrat',
        color: isLightTheme ? AppColors.textLight : AppColors.textDark,
        fontWeight: FontWeight.w500,
      ),
      bodySmall: TextStyle(
        fontSize: 16,
        fontFamily: 'Montserrat',
        color: isLightTheme ? AppColors.textLight : AppColors.textDark,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  static ThemeData lightTheme() {
    final ThemeData base = ThemeData.light();
    return base.copyWith(
      iconTheme: IconThemeData(color: AppColors.iconLight),
      primaryColor: AppColors.primary,
      scaffoldBackgroundColor: AppColors.backgroundLight,
      textTheme: _buildTextTheme(base.textTheme),
      primaryTextTheme: _buildTextTheme(base.textTheme),
      inputDecorationTheme: InputDecorationTheme(
        fillColor: AppColors.backgroundLight,
      ),
    );
  }

  static ThemeData darkTheme() {
    final ThemeData base = ThemeData.dark();
    return base.copyWith(
      appBarTheme: AppBarTheme(color: Colors.grey[700]),
      iconTheme: IconThemeData(color: AppColors.iconDark),
      primaryColor: AppColors.primary,
      scaffoldBackgroundColor: AppColors.backgroundDark,
      textTheme: _buildTextTheme(base.textTheme),
      primaryTextTheme: _buildTextTheme(base.primaryTextTheme),
      inputDecorationTheme: InputDecorationTheme(
        fillColor: AppColors.backgroundDark,
      ),
    );
  }
}
