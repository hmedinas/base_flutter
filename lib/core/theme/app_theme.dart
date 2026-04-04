import 'package:hm_flutter_base/core/constants/app_contans.dart';
import 'package:flutter/material.dart';

class AppTheme {
  // que no se instancie
  AppTheme._();

  static final ThemeData baseTheme = ThemeData.light().copyWith(
    primaryColor: AppColors.background,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.background,
      foregroundColor: AppColors.titleGraphic,
      elevation: 0.5,
    ),

    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      primary: AppColors.primary,
    ),
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
