import 'package:flutter/material.dart';

class MyTheme {
  //* Light Theme Data
  static var lightTheme = ThemeData(
    scaffoldBackgroundColor: LightThemeColors.background,
    brightness: Brightness.light,
    primaryColor: Colors.black,
    hintColor: Colors.black54,
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: LightThemeColors.onCard,
      selectionColor: LightThemeColors.onCard,
      selectionHandleColor: LightThemeColors.onCard,
    ),
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
      prefixIconColor: LightThemeColors.accent,
      suffixIconColor: Colors.black45,
      labelStyle: const TextStyle(color: Colors.black),
      hintStyle: TextStyle(
        color: Colors.grey[700],
        fontWeight: FontWeight.normal,
      ),
      border: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.blueGrey),
        borderRadius: BorderRadius.circular(10),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: LightThemeColors.onCard.withOpacity(.6)),
        borderRadius: BorderRadius.circular(10),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: LightThemeColors.accent),
        borderRadius: BorderRadius.circular(10),
      ),
    ),
    colorScheme: ColorScheme(
      brightness: Brightness.light,
      primary: LightThemeColors.card,
      onPrimary: LightThemeColors.onCard,
      secondary: LightThemeColors.accent,
      onSecondary: Colors.black,
      tertiary: Colors.white,
      error: Colors.red,
      onError: Colors.redAccent,
      background: LightThemeColors.background,
      onBackground: Colors.black,
      surface: LightThemeColors.background,
      onSurface: Colors.black,
    ),
    iconTheme: IconThemeData(color: LightThemeColors.accent),
    appBarTheme: const AppBarTheme(
      elevation: 0,
      backgroundColor: Colors.transparent,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: LightThemeColors.background,
      selectedItemColor: LightThemeColors.accent,
      unselectedItemColor: LightThemeColors.onCard,
    ),
  );

  //* Dark Theme Data
  static var darkTheme = ThemeData(
    brightness: Brightness.dark,
    hintColor: Colors.white60,
    scaffoldBackgroundColor: DarkThemeColors.background,
    primaryColor: Colors.white,
    indicatorColor: Colors.white,
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: DarkThemeColors.onCard,
      selectionColor: DarkThemeColors.onCard,
      selectionHandleColor: DarkThemeColors.onCard,
    ),
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
      prefixIconColor: DarkThemeColors.accent,
      suffixIconColor: Colors.white38,
      errorStyle: const TextStyle(color: Colors.red),
      hintStyle: TextStyle(
        color: Colors.grey[500],
        fontWeight: FontWeight.normal,
      ),
      border: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.blueGrey),
        borderRadius: BorderRadius.circular(10),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: DarkThemeColors.card),
        borderRadius: BorderRadius.circular(10),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.blueGrey),
        borderRadius: BorderRadius.circular(10),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.redAccent),
        borderRadius: BorderRadius.circular(10),
      ),
    ),
    colorScheme: ColorScheme(
      brightness: Brightness.dark,
      primary: DarkThemeColors.card,
      onPrimary: DarkThemeColors.onCard,
      secondary: DarkThemeColors.accent,
      onSecondary: const Color(0xEBFFFFFF),
      tertiary: Colors.black,
      error: Colors.redAccent,
      onError: Colors.redAccent,
      background: DarkThemeColors.background,
      onBackground: const Color(0xFFFAFAFA),
      surface: DarkThemeColors.background,
      onSurface: Colors.white,
    ),
    iconTheme: IconThemeData(color: DarkThemeColors.accent),
    appBarTheme: const AppBarTheme(
      elevation: 0,
      backgroundColor: Colors.transparent,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: DarkThemeColors.background,
      selectedItemColor: DarkThemeColors.accent,
      unselectedItemColor: DarkThemeColors.onCard,
    ),
  );
}

class LightThemeColors {
  static var background = const Color(0xFFFFFFFF);
  static var card = const Color(0xFFEDF7F6);
  static var onCard = const Color(0xFF8CCECA);
  static var accent = const Color(0xFF377B7A);
}

class DarkThemeColors {
  static var background = const Color(0xFF222831);
  static var card = const Color(0xFF31363F);
  static var onCard = const Color(0xFF377B7A);
  static var accent = const Color(0xFF8CCECA);
}
