import 'package:flutter/material.dart';

ThemeData appTheme() {
  Color primaryColor = Colors.white;
  Color accentColor = Colors.blue;

  return ThemeData(
    primaryColor: primaryColor,
    accentColor: accentColor,
    
    textTheme: TextTheme(
      subtitle1: TextStyle(color: Color(0x8a000000)),
    ),

    inputDecorationTheme: InputDecorationTheme(
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: accentColor)
      ),
      contentPadding: EdgeInsets.all(10),
    ),

    cardTheme: CardTheme(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25))),
          elevation: 5,
    ),

    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25))))
      )
  );
}