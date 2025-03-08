import 'package:blog_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

ThemeData darkThemeData = ThemeData(
  inputDecorationTheme: const InputDecorationTheme(
    hintStyle: TextStyle(color: AppColors.whiteGrey),
    fillColor: AppColors.darkBrown,
    filled: true,
    border: InputBorder.none,
    enabledBorder: InputBorder.none,
    focusedBorder: InputBorder.none,
    disabledBorder: InputBorder.none,
  ),
  chipTheme: const ChipThemeData(
      backgroundColor: AppColors.darkBrown,
      labelStyle: TextStyle(color: AppColors.whiteColor)),
  iconButtonTheme: IconButtonThemeData(
    style: ButtonStyle(
      iconSize: WidgetStateProperty.all(28),
      iconColor: WidgetStateProperty.all(AppColors.whiteColor),
    ),
  ),
  scaffoldBackgroundColor: AppColors.backgroundColor,
  appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.backgroundColor,
      foregroundColor: AppColors.whiteColor),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: AppColors.whiteColor),
    bodyMedium: TextStyle(color: AppColors.whiteColor),
    bodySmall: TextStyle(color: AppColors.whiteColor),
    titleLarge: TextStyle(color: AppColors.whiteColor),
    titleMedium: TextStyle(color: AppColors.whiteColor),
    titleSmall: TextStyle(color: AppColors.whiteColor),
  ),
  primaryTextTheme: const TextTheme(
    bodyLarge: TextStyle(color: AppColors.whiteColor),
    bodyMedium: TextStyle(color: AppColors.whiteColor),
    bodySmall: TextStyle(color: AppColors.whiteColor),
    titleLarge: TextStyle(color: AppColors.whiteColor),
    titleMedium: TextStyle(color: AppColors.whiteColor),
    titleSmall: TextStyle(color: AppColors.whiteColor),
  ),
);
