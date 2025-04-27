import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    surface:const Color.fromRGBO(253, 253, 253,20),
    primary: Colors.teal,
    secondary: Colors.orangeAccent.shade100,
    tertiary: Colors.black87,
    primaryContainer: Colors.white
  )
);

