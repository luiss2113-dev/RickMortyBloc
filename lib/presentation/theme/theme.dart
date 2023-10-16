import 'package:flutter/material.dart';

ThemeData themeApp = ThemeData(
  useMaterial3: true,
  primaryColor: Colors.orange[800],
  colorScheme: const ColorScheme.light(
    primary: Colors.orange,
    secondary: Color.fromARGB(255, 251, 138, 0),
  ),
  textTheme: TextTheme(
    titleLarge: const TextStyle(
      fontWeight: FontWeight.bold,
      color: Colors.orange,
    ),
    displaySmall: TextStyle(
      fontWeight: FontWeight.bold,
      color: Colors.orange[800],
    ),
    displayLarge: TextStyle(
       color: Colors.orange[800],
       fontWeight: FontWeight.w800,
    )
  ),
);
