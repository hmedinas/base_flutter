import 'package:base_flutter/core/constants/app_contans.dart';
import 'package:flutter/material.dart';

class AppTheme {
  // que no se instancie
  AppTheme._();

  static final ThemeData baseTheme = ThemeData.light().copyWith(
    primaryColor: AppColors.background,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      primary: AppColors.primary,
    ),
    appBarTheme: AppBarTheme(color: AppColors.background),
    inputDecorationTheme: const InputDecorationTheme(
      floatingLabelStyle: TextStyle(color: AppColors.background),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.background),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(10),
          topLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.background),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(10),
          topRight: Radius.circular(10),
          bottomRight: Radius.circular(10),
          topLeft: Radius.circular(10),
        ),
      ),
    ),
  );

   static final TextStyle initLoginTitle = TextStyle(
    fontWeight: FontWeight.bold,
    color: Color(0xff058DC7),
    fontSize: 20,
  );
}
