import 'package:flutter/material.dart';

class ThemeClass {
  Color secondaryColor = Color.fromARGB(255, 141, 178, 182);
  Color primaryColor = Color.fromARGB(255, 162, 194, 180);
  Color bColor = Color.fromARGB(255, 0, 0, 0);
  Color wColor = Color.fromARGB(255, 255, 255, 255);
  Color gColor = Color.fromARGB(255, 217, 217, 217);

  static ThemeData lightTheme = ThemeData(
    primaryColor: ThemeData.light().scaffoldBackgroundColor,
    colorScheme: const ColorScheme.light().copyWith(
        primary: _themeClass.wColor, secondary: _themeClass.secondaryColor),
  );

  static ThemeData darkTheme = ThemeData(
    primaryColor: ThemeData.dark().scaffoldBackgroundColor,
    colorScheme: const ColorScheme.dark().copyWith(
      primary: _themeClass.bColor,
    ),
  );
}

ThemeClass _themeClass = ThemeClass();
