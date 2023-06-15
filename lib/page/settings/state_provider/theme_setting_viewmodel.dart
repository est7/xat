import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:xat/model/app_config_model.dart';

import '../../../appconfig/theme_state.dart';

class ThemeNotifier extends StateNotifier<ThemeState> {
  ThemeNotifier() : super(_initialTheme);
  static final _initialTheme = ThemeState(
      followSystemTheme: true,
      lightThemeData: enumToThemeData(LightEnumV1()),
      customThemeData: enumToThemeData(defaultThemeEnum()),
      darkThemeData: enumToThemeData(DarkEnumV2()));

  bool followSystemTheme = true;

  late LightEnum lightTheme;

  late ThemeEnum customTheme;

  late DarkEnum darkTheme;

  late ThemeData currentThemeData;

  ///如果是跟随系统主题,判断目前是 light 还是 dark,选用不同的 enum
  ///如果不跟随系统,那么选用 CustomTheme,然后根据 CustomTheme 的值,生成MaterialColor
  void validateThemeData() {
    if (followSystemTheme) {
      if (currentIsDarkTheme()) {
        state = state.copyWith(darkThemeData: enumToThemeData(darkTheme));
      } else {
        state = state.copyWith(darkThemeData: enumToThemeData(darkTheme));
      }
    } else {
      //或许即使自定义的Color 也可以打开暗黑模式?
      // Color accentColor = isDark ? themeColor[700]! : _themeColor;
      state = state.copyWith(customThemeData: enumToThemeData(customTheme));
    }
  }

  void followSystem() {
    followSystemTheme = !followSystemTheme;
    validateThemeData();
  }

  void changeLightTheme(LightEnum newLightTheme) {
    lightTheme = newLightTheme;
    validateThemeData();
  }

  void changeDarkTheme(DarkEnum newDarkTheme) {
    darkTheme = newDarkTheme;
    validateThemeData();
  }

  void changeThemeColor(MaterialColor newColor) {
    followSystemTheme = false;
    customTheme = CustomEnum(newColor);
    validateThemeData();
  }

  void initAppThemeConfig(AppConfig appConfig) {
    followSystemTheme = appConfig.followSystemTheme;
    lightTheme = appConfig.lightTheme;
    customTheme = appConfig.customTheme;
    darkTheme = appConfig.darkTheme;
//如果是跟随系统主题,判断目前是 light 还是 dark,选用不同的 enum
    validateThemeData();
  }

//获取当前系统主题是 dark 还是 light
  bool currentIsDarkTheme() {
    var brightness = WidgetsBinding.instance.window.platformBrightness;
    return brightness == Brightness.dark;
  }

  void setThemeMode(ThemeMode light) {}
}

final themeStateProvider =
    StateNotifierProvider<ThemeNotifier, ThemeState>((ref) {
  return ThemeNotifier();
});

ThemeData enumToThemeData(ThemeEnum themeEnum) {
  switch (themeEnum) {
    case LightEnumV1():
      return ThemeData(
          useMaterial3: true,
          brightness: Brightness.light,
          primaryColor: Colors.red);
    case LightEnumV2():
      return ThemeData(
          useMaterial3: true,
          brightness: Brightness.light,
          primaryColor: Colors.green);
    case DarkEnumV1():
      return ThemeData(
        useMaterial3: true,
        primaryColor: Colors.red,
        brightness: Brightness.dark,
      );
    case DarkEnumV2():
      return ThemeData(
        useMaterial3: true,
        primaryColor: Colors.green,
        brightness: Brightness.dark,
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
