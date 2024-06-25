import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  colorScheme: ColorScheme.light(
    onSurface: Colors.black,
    surface: Colors.grey.shade100,
    background: Colors.white,
    primary: Colors.grey.shade200,
    secondary: Colors.grey.shade400,
    inversePrimary: Colors.grey.shade500,
  ),
  useMaterial3: true,
  textTheme: ThemeData.light().textTheme.apply(
        bodyColor: Colors.grey.shade800,
        displayColor: Colors.black,
      ),
);
