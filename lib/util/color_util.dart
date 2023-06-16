import 'package:flutter/material.dart';

import '../model/app_config_model.dart';

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
    case CustomEnum():
      return ThemeData(
        useMaterial3: true,
        primaryColor: parseIntToColor(themeEnum.value),
        brightness: Brightness.light,
      );
  }
}

MaterialColor createMaterialColor(Color color) {
  Map<int, Color> colorMap = {
    50: color.withOpacity(0.1),
    100: color.withOpacity(0.2),
    200: color.withOpacity(0.3),
    300: color.withOpacity(0.4),
    400: color.withOpacity(0.5),
    500: color.withOpacity(0.6),
    600: color.withOpacity(0.7),
    700: color.withOpacity(0.8),
    800: color.withOpacity(0.9),
    900: color.withOpacity(1),
  };
  return MaterialColor(color.value, colorMap);
}

MaterialColor parseIntToColor(int color) {
  return createMaterialColor(Color(color));
}
