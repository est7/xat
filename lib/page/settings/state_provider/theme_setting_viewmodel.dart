import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:xat/model/app_config_model.dart';

import '../../../appconfig/theme_state.dart';
import '../../../util/color_util.dart';

class ThemeNotifier extends StateNotifier<ThemeState> {
  ThemeNotifier() : super(_initialTheme);
  static final _initialTheme = ThemeState(
      followSystemTheme: true,
      customThemeData: enumToThemeData(defaultThemeEnum()),
      lightThemeEnum: LightEnumV1(),
      darkThemeEnum: DarkEnumV2());

  bool followSystemTheme = true;

  late LightEnum lightTheme;

  late ThemeEnum customTheme;

  late DarkEnum darkTheme;

  late ThemeData currentThemeData;

  void changeLightTheme(LightEnum newLightTheme) {
    validateThemeData(newLightTheme: newLightTheme);
  }

  void validateThemeData(
      {bool? newFollowSystemTheme,
      LightEnum? newLightTheme,
      ThemeEnum? newCustomTheme,
      DarkEnum? newDarkTheme}) {
    bool? followSystemTheme;
    LightEnum? lightThemeEnum;
    ThemeData? customThemeData;
    DarkEnum? darkThemeEnum;

    if (newFollowSystemTheme != null &&
        newFollowSystemTheme != state.followSystemTheme) {
      followSystemTheme = newFollowSystemTheme;
    }

    if (newLightTheme?.value != state.lightThemeEnum.value) {
      lightThemeEnum = newLightTheme;
    }

    if (newDarkTheme?.value != state.darkThemeEnum.value) {
      darkThemeEnum = newDarkTheme;
    }

    if (newCustomTheme != null) {
      customThemeData = enumToThemeData(newCustomTheme);
    }

    state = state.copyWith(
      followSystemTheme: followSystemTheme ?? state.followSystemTheme,
      lightThemeEnum: lightThemeEnum ?? state.lightThemeEnum,
      customThemeData: customThemeData ?? state.customThemeData,
      darkThemeEnum: darkThemeEnum ?? state.darkThemeEnum,
    );
  }

  void changeDarkTheme(DarkEnum newDarkTheme) {
    validateThemeData(newDarkTheme: newDarkTheme);
  }

  void changeThemeColor(MaterialColor newColor) {
    customTheme = CustomEnum(newColor);
    validateThemeData(
        newFollowSystemTheme: !state.followSystemTheme,
        newCustomTheme: customTheme);
  }

  void initAppThemeConfig(AppConfig appConfig) {
//如果是跟随系统主题,判断目前是 light 还是 dark,选用不同的 enum
    validateThemeData(
      newFollowSystemTheme: appConfig.followSystemTheme,
      newLightTheme: appConfig.lightTheme,
      newCustomTheme: appConfig.customTheme,
      newDarkTheme: appConfig.darkTheme,
    );
  }

//获取当前系统主题是 dark 还是 light
  bool currentIsDarkTheme() {
    var brightness = WidgetsBinding.instance.window.platformBrightness;
    return brightness == Brightness.dark;
  }

  ///如果是跟随系统主题,判断目前是 light 还是 dark,选用不同的 enum
  ///如果不跟随系统,那么选用 CustomTheme,然后根据 CustomTheme 的值,生成MaterialColor
  ///或许即使自定义的Color 也可以打开暗黑模式?
  /// Color accentColor = isDark ? themeColor[700]! : _themeColor;
  /// state = state.copyWith(customThemeData: enumToThemeData(customTheme));
  Future<void> setThemeMode(
      {bool? newFollowSystemTheme,
      LightEnum? newLightTheme,
      ThemeEnum? newCustomTheme,
      DarkEnum? newDarkTheme}) {
    validateThemeData(
        newFollowSystemTheme: newFollowSystemTheme,
        newLightTheme: newLightTheme,
        newCustomTheme: newCustomTheme,
        newDarkTheme: newDarkTheme);
    return Future.value();
  }
}

final themeStateProvider =
    StateNotifierProvider<ThemeNotifier, ThemeState>((ref) {
  return ThemeNotifier();
});
