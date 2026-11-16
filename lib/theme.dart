import 'package:flutter/material.dart';

const blue = Color(0xFF09318D);
const pink = Color(0xFFFD91CC);
const ink = Color(0xFF101F42);
const muted = Color(0xFF465775);
const line = Color(0xFFDFE6F4);
const wash = Color(0xFFF3F6FD);
const white = Colors.white;
const gutter = 20.0;
const gap = 12.0;

final watchlistTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(seedColor: blue)
      .copyWith(primary: blue, secondary: pink, surface: white, onSurface: ink),
  fontFamily: 'DM Sans',
  scaffoldBackgroundColor: wash,
  textTheme: const TextTheme(
    headlineMedium: TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.w800,
      height: 1.08,
    ),
    titleLarge: TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
    titleMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
    bodyMedium: TextStyle(fontSize: 14, height: 1.4),
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: blue,
    foregroundColor: white,
    scrolledUnderElevation: 0,
    titleTextStyle: TextStyle(
      fontFamily: 'DM Sans',
      fontWeight: FontWeight.w800,
      fontSize: 23,
    ),
  ),
  cardTheme: CardThemeData(
    color: white,
    surfaceTintColor: Colors.transparent,
    margin: EdgeInsets.zero,
    elevation: 0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
      side: const BorderSide(color: line),
    ),
  ),
  inputDecorationTheme: InputDecorationThemeData(
    filled: true,
    fillColor: white,
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: line),
    ),
  ),
  filledButtonTheme: FilledButtonThemeData(
    style: FilledButton.styleFrom(
      backgroundColor: pink,
      foregroundColor: ink,
      minimumSize: const Size(0, 48),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      minimumSize: const Size(0, 46),
      side: const BorderSide(color: line),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
  ),
  navigationBarTheme: const NavigationBarThemeData(
    backgroundColor: white,
    indicatorColor: Color(0xFFFCCCE7),
    height: 68,
  ),
);
