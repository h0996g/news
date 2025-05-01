import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:news/const/colors.dart';

class AppThemes {
  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: Colors.white,
    brightness: Brightness.light,
    primaryColor: primaryColor,
    indicatorColor: primaryColor,
    appBarTheme: const AppBarTheme(
      surfaceTintColor: Colors.transparent,
      backgroundColor: primaryColor,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.light,
      ),
      foregroundColor: Colors.white,
    ),
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: primaryColor,
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,

    brightness: Brightness.dark,
    primaryColor: primaryColor,
  );
}
