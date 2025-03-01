import 'package:flutter/material.dart';

class SystemColors {
  const SystemColors();

  static const Color primaryBlue = Color(0xff50C2C9);
  static const Color primaryPrink = Color(0xffFF6584);
  static const Color primaryGreenDark = Color(0xff61865D);
  static const Color primaryGreenLight = Color(0xffE0F1D0);
  static const Color primaryBrwn = Color(0xff86695D);
  static const Color neutralDark = Color(0xff505050);
  static const Color jetBlack = Color(0xff0A0A0A);
  static const Color neutralMedium = Color(0xff9d9d9d);
  static const Color neutralLight = Color(0xffd2d2d2);
  static const Color neutralHover = Color(0xffEAEAEA);
  static const Color neutralBackground = Color(0xffffffff);
  static const Color neutralBackground1 = Color(0xfff3f3f3);
  static const Color labelActive = Color(0xff2378f6);
  static const Color labelActive2 = Color(0xff70a5f4);
  static const Color labelError = Color(0xffef1010);
  static const Color labelError2 = Color(0xffdd8080);
  static const Color labelWarning = Color(0xffffad39);
  static const Color labelWarning2 = Color(0xffffc472);
  static const Color primaryViolet = Color(0xFF575988);
}

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: SystemColors.primaryBlue,
      scaffoldBackgroundColor: SystemColors.neutralBackground,
      appBarTheme: AppBarTheme(
        backgroundColor: SystemColors.primaryBlue,
        foregroundColor: SystemColors.neutralBackground,
        elevation: 0,
      ),
      textTheme: TextTheme(
        headlineLarge: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: SystemColors.jetBlack),
        headlineMedium: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: SystemColors.neutralDark),
        bodyMedium: TextStyle(fontSize: 16, color: SystemColors.neutralDark),
        bodySmall: TextStyle(fontSize: 14, color: SystemColors.neutralMedium),
      ),
      buttonTheme: ButtonThemeData(
        buttonColor: SystemColors.primaryGreenDark,
        textTheme: ButtonTextTheme.primary,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: SystemColors.primaryGreenDark,
          foregroundColor: SystemColors.neutralBackground,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: SystemColors.neutralBackground1,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: SystemColors.neutralMedium),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: SystemColors.labelActive),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: SystemColors.labelError),
        ),
      ),
      iconTheme: IconThemeData(color: SystemColors.primaryPrink),
    );
  }
}
