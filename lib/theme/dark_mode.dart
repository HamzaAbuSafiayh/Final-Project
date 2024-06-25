import 'package:flutter/material.dart';

ThemeData darkMode = ThemeData(
  colorScheme: ColorScheme.dark(
    surface: Colors.grey.shade900,
    onSurface: Colors.white,
    background: Colors.black,
    primary: Colors.grey.shade800,
    secondary: Colors.grey.shade700,
    inversePrimary: Colors.grey.shade500,
    shadow: Colors.grey.shade700,
  ),
  useMaterial3: true,
  textTheme: ThemeData.dark().textTheme.apply(
        bodyColor: Colors.grey.shade300,
        displayColor: Colors.white,
      ),
);
