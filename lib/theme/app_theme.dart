import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get theme => ThemeData(
    primarySwatch: Colors.green,
    colorScheme: ColorScheme.fromSwatch(
      primarySwatch: Colors.green,
    ).copyWith(secondary: Colors.greenAccent),
    scaffoldBackgroundColor: Colors.green[50],
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.green,
      foregroundColor: Colors.white,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Colors.green,
    ),
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: Colors.green,
    ),
  );
}
