import 'package:depannini_user/core/constants.dart';
import 'package:flutter/material.dart';

class MyTheme {

  MyTheme._();

  static final lightTheme = ThemeData.light().copyWith(
    primaryColor: MyConstants.primaryC,
    scaffoldBackgroundColor: Colors.white,
    colorScheme: ColorScheme.light().copyWith(
      secondary: Colors.black,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: MyConstants.primaryC,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        ),
    ),
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: MyConstants.primaryC,
      selectionHandleColor: MyConstants.primaryC,
    ),
    textTheme: TextTheme(
      headlineLarge: TextStyle(color: Colors.black, fontSize: 30, fontWeight: FontWeight.bold),
      headlineMedium: TextStyle(color: Colors.black, fontSize: 28, fontWeight: FontWeight.bold),
      headlineSmall: TextStyle(color: Colors.black, fontSize: 26, fontWeight: FontWeight.bold),
      titleLarge: TextStyle(color: Colors.black, fontSize: 24, fontWeight: FontWeight.w700),
      titleMedium: TextStyle(color: Colors.black, fontSize: 22, fontWeight: FontWeight.w700),
      titleSmall: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w700),
      bodyLarge: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w500),
      bodyMedium: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w500),
      bodySmall: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.w500),
    ),
  );

  static final darkTheme = ThemeData.dark().copyWith(
    primaryColor: MyConstants.primaryC,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.black45,
    ),
    colorScheme: ColorScheme.dark().copyWith(
      secondary: Colors.white,
    ),
    scaffoldBackgroundColor: Colors.black45,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: MyConstants.primaryC,
        foregroundColor: Colors.white,
      ),
    ),
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: MyConstants.primaryC,
      selectionHandleColor: MyConstants.primaryC,
    ),
    textTheme: TextTheme(
      headlineLarge: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
      headlineMedium: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold),
      headlineSmall: TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold),
      titleLarge: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w700),
      titleMedium: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w700),
      titleSmall: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w700),
      bodyLarge: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500),
      bodyMedium: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
      bodySmall: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500),
    ),
  );

}