import 'package:flutter/material.dart';

class Constants {
  //App related strings
  static String appName = "Social App";

  //Colors for theme
  static Color lightPrimary = const Color(0xfff3f4f9);
  static Color darkPrimary = const Color(0xff2B2B2B);

  static Color lightAccent = Colors.purpleAccent;

  static Color darkAccent = Colors.purple;

  static Color lightBG = const Color(0xfff3f4f9);
  static Color darkBG = const Color(0xff2B2B2B);

  static ThemeData darkTheme = ThemeData(
    fontFamily: 'Lato-Regular',
    brightness: Brightness.dark,
    backgroundColor: darkBG,
    primaryColor: darkPrimary,
    accentColor: darkAccent,
    scaffoldBackgroundColor: darkBG,
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: darkAccent,
    ),
    bottomAppBarTheme: BottomAppBarTheme(
      elevation: 0,
      color: darkBG,
    ),
    appBarTheme: AppBarTheme(
      elevation: 0,
      textTheme: TextTheme(
        headline6: TextStyle(
          color: lightBG,
          fontSize: 20,
          fontWeight: FontWeight.w600,
          fontFamily: 'Lato-Regular',
        ),
      ),
    ),
  );
}
