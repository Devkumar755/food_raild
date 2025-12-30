import 'package:flutter/material.dart';
import 'package:food_rail/core/resources/app_colors.dart';

class AppThemes {
  static ThemeData lightTheme = ThemeData(
    fontFamily: 'Metropolis',
    brightness: Brightness.light,
    primaryColor: AppColors.primaryColor,
    primaryColorLight: AppColors.primaryColor,
    primaryColorDark: AppColors.primaryColor,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.primaryColor,
      foregroundColor: Colors.white,
    ),
    textTheme: TextTheme(
      bodyLarge: TextStyle(color: AppColors.primaryFontColor),
      bodyMedium: TextStyle(color: AppColors.secondaryFontColor),
      bodySmall: TextStyle(color: AppColors.placeholderColor),
    ),
    colorScheme: ColorScheme.light(
      primary: AppColors.primaryColor,
      secondary: AppColors.primaryColor,
      surface: Colors.white,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: AppColors.primaryFontColor,
    ),
  );

  static ThemeData darkTheme = ThemeData(
    fontFamily: 'Metropolis',
    brightness: Brightness.dark,
    primaryColor: AppColors.primaryColor,
    primaryColorLight: AppColors.primaryColor,
    primaryColorDark: AppColors.primaryColor,
    scaffoldBackgroundColor: Colors.black,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.black,
      foregroundColor: AppColors.primaryColor,
    ),
    textTheme: TextTheme(
      bodyLarge: TextStyle(color: Colors.white),
      bodyMedium: TextStyle(color: AppColors.secondaryFontColor),
      bodySmall: TextStyle(color: AppColors.placeholderColor),
    ),
    colorScheme: ColorScheme.dark(
      primary: AppColors.primaryColor,
      secondary: AppColors.primaryColor,
      surface: Colors.black,     
      onPrimary: Colors.black,
      onSecondary: Colors.black,
      onSurface: Colors.white,
    
    ),
  );
}