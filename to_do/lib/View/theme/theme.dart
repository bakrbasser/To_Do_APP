import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  AppTheme._privateConstructor();
  static AppTheme instance = AppTheme._privateConstructor();

  ThemeData theme = ThemeData(
    scaffoldBackgroundColor: AppColors.instance.screensBackground,
    textTheme: AppFonts.instance.textTheme,
    appBarTheme: AppBarTheme(
        backgroundColor: AppColors.instance.screensBackground,
        foregroundColor: Colors.white),
  );
}

class AppColors {
  AppColors._privateConstructor();
  static AppColors instance = AppColors._privateConstructor();

  final Color screensBackground = const Color(0xff121212);
}

class AppFonts {
  AppFonts._privateConstructor();
  static AppFonts instance = AppFonts._privateConstructor();

  late final textTheme = TextTheme(
    titleLarge: _titleLarge,
    titleMedium: _titleMedium,
    titleSmall: _titleSmall,
    bodyLarge: _bodyLarge,
    bodyMedium: _bodyMedium,
    bodySmall: _bodySmall,
  );

  final _titleLarge = GoogleFonts.lato(
      color: Colors.white, fontWeight: FontWeight.bold, fontSize: 40);
  final _titleMedium = GoogleFonts.lato(
      color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20);
  final _titleSmall = GoogleFonts.lato(
      color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16);
  final _bodyLarge = GoogleFonts.lato(color: Colors.white, fontSize: 20);
  final _bodyMedium = GoogleFonts.lato(color: Colors.white, fontSize: 16);
  final _bodySmall = GoogleFonts.lato(color: Colors.white, fontSize: 14);
}
