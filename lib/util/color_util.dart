import 'package:flutter/material.dart';

import '../model/theme_enum.dart';

ThemeData enumToThemeData(ThemeEnum themeEnum) {
  switch (themeEnum) {
    case LightEnumV1():
      return ThemeData.from(
        colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.purple, brightness: Brightness.light),
        useMaterial3: true,
      );
    case LightEnumV2():
      return ThemeData.from(
        colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.green, brightness: Brightness.light),
        useMaterial3: true,
      );
    case LightEnumV3():
      return ThemeData.from(
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.blue,
          accentColor: Colors.yellow,
          backgroundColor: Colors.grey.shade200,
        ).copyWith(
          onSurface: Colors.grey.shade900,
          onBackground: Colors.grey.shade600,
        ),
      ).copyWith(
        dialogBackgroundColor: Colors.grey.shade300,
        bottomNavigationBarTheme:
            const BottomNavigationBarThemeData(backgroundColor: Colors.white),
        hoverColor: Colors.grey.shade700.withOpacity(0.9),
        toggleableActiveColor: Colors.grey.shade700,
      );
    case DarkEnumV1():
      return ThemeData.from(
        colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.deepOrangeAccent, brightness: Brightness.dark),
        useMaterial3: true,
      );
    case DarkEnumV2():
      return ThemeData.from(
        colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.teal, brightness: Brightness.dark),
        useMaterial3: true,
      );
    case DarkEnumV3():
      return ThemeData.from(
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.blueGrey,
          accentColor: Colors.black,
          backgroundColor: Colors.grey.shade200,
        ).copyWith(
          onSurface: Colors.grey.shade900,
          onBackground: Colors.grey.shade600,
        ),
      ).copyWith(
        dialogBackgroundColor: Colors.grey.shade300,
        bottomNavigationBarTheme:
            const BottomNavigationBarThemeData(backgroundColor: Colors.white),
        hoverColor: Colors.grey.shade700.withOpacity(0.9),
        toggleableActiveColor: Colors.grey.shade700,
      );
    case CustomEnum():
      return ThemeData.from(
        colorScheme: ColorScheme.fromSeed(
            seedColor: themeEnum.color!, brightness: Brightness.light),
        useMaterial3: true,
      );
  }
}

Color parseIntToColor(int color) {
  return Color(color);
}
