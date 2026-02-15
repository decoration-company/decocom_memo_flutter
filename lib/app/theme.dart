import 'package:flutter/material.dart';

ThemeData buildAppTheme() {
  const basePink = Color(0xFFE84A7F);
  final colorScheme = ColorScheme.fromSeed(seedColor: basePink);

  return ThemeData(
    useMaterial3: true,
    colorScheme: colorScheme,
    scaffoldBackgroundColor: const Color(0xFFFFF8F9),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: TextStyle(
        color: basePink,
        fontWeight: FontWeight.w700,
        fontSize: 28,
      ),
    ),
  );
}
