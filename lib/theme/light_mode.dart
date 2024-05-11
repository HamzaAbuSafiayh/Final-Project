import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  colorScheme: ColorScheme.light(
    background: Colors.grey.shade300,
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
