import 'package:flutter/material.dart';

ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    colorScheme: ColorScheme.dark(
      surface: Colors.grey.shade900,
      primary: Colors.teal,
      secondary: Colors.orangeAccent.shade100,
      tertiary: Colors.white,
      primaryContainer: Colors.grey.shade800
    )
);