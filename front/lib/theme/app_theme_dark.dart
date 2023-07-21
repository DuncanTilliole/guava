import 'package:flutter/material.dart';

Color primary = const Color(0xFF252A23);
Color secondary = const Color(0xFF3B3F39);
Color tertiary = const Color(0xFFFFFFFF);
Color scrim = const Color(0xFFAAF0D1);
Color error = const Color(0xFFA63D40);
Color borderShadow = const Color(0xFF656363);

// Instantiate new  theme data
final ThemeData darkTheme = _darkTheme();

//Define Base theme for app
ThemeData _darkTheme() {
// We'll just overwrite whatever's already there using ThemeData.light()
  final ThemeData base = ThemeData.dark();

  // Make changes to light() theme
  return base.copyWith(
    textTheme: const TextTheme(
      titleLarge: TextStyle(
          fontSize: 25.0, fontFamily: 'Bad Script', color: Color(0xFFFFFFFF)),
      bodyLarge: TextStyle(
          fontSize: 17.0, fontFamily: 'Raleway', color: Color(0xFFFFFFFF)),
      headlineLarge: TextStyle(
          fontSize: 20.0,
          fontFamily: 'Raleway',
          color: Color(0xFFFFFFFF),
          fontWeight: FontWeight.bold),
      headlineMedium: TextStyle(
          fontSize: 16.0,
          fontFamily: 'Raleway',
          color: Color(0xFFFFFFFF),
          fontWeight: FontWeight.bold),
      labelLarge: TextStyle(
          fontSize: 13.0, fontFamily: 'Raleway', color: Color(0xFFFFFFFF)),
    ),
    colorScheme: base.colorScheme.copyWith(
      primary: primary,
      onPrimary: tertiary,
      secondary: secondary,
      onSecondary: tertiary,
      tertiary: tertiary,
      onTertiary: tertiary,
      scrim: scrim,
      onBackground: tertiary,
      error: error,
      shadow: borderShadow,
    ),
  );
}
