import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:xat/model/app_config_model.dart';
import 'package:xat/page/settings/state_provider/language_setting_viewmodel.dart';

import '../../../appconfig/theme_state.dart';
import '../../../model/theme_enum.dart';
import '../../../model/theme_hive_model.dart';

class ThemeViewModel extends StateNotifier<ThemeState> {
  ThemeViewModel(this.language) : super(_initialTheme);

  static final _initialTheme = ThemeState(
      followSystemTheme: true,
      customThemeEnum: defaultThemeEnum(),
      lightThemeEnum: LightEnumV1(),
      darkThemeEnum: DarkEnumV2());

  var language;

  bool followSystemTheme = true;

  late LightEnum lightTheme;

  late ThemeEnum customTheme;

  late DarkEnum darkTheme;

  late ThemeData currentThemeData;

  Future<void> validateThemeData({
    bool? newFollowSystemTheme,
    LightEnum? newLightTheme,
    ThemeEnum? newCustomTheme,
    DarkEnum? newDarkTheme,
  }) {
    bool? followSystemTheme =
        _updateState(newFollowSystemTheme, state.followSystemTheme);

    LightEnum? lightThemeEnum =
        _updateState(newLightTheme, state.lightThemeEnum);

    DarkEnum? darkThemeEnum = _updateState(newDarkTheme, state.darkThemeEnum);

    ThemeEnum? customThemeEnum = _updateState(
        newCustomTheme, state.customThemeEnum,
        comparator: (a, b) => a.color?.value != b.color?.value);

    state = state.copyWith(
      followSystemTheme: followSystemTheme ?? state.followSystemTheme,
      lightThemeEnum: lightThemeEnum ?? state.lightThemeEnum,
      darkThemeEnum: darkThemeEnum ?? state.darkThemeEnum,
      customThemeEnum: customThemeEnum ?? state.customThemeEnum,
    );

    return Future.value();
  }

  T? _updateState<T>(T? newValue, T currentValue,
      {bool Function(T, T)? comparator}) {
    comparator ??= (a, b) => a != b;
    return (newValue != null && comparator(newValue, currentValue))
        ? newValue
        : currentValue;
  }

  void initAppThemeConfig(ThemeConfig appConfig) {
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
  setThemeMode(
      {bool? newFollowSystemTheme,
      LightEnum? newLightTheme,
      ThemeEnum? newCustomTheme,
      DarkEnum? newDarkTheme}) {
    validateThemeData(
            newFollowSystemTheme: newFollowSystemTheme,
            newLightTheme: newLightTheme,
            newCustomTheme: newCustomTheme,
            newDarkTheme: newDarkTheme)
        .then((value) => saveToLocalStorage());
  }

  //持久化到 hive
  void saveToLocalStorage() {
    final myAppConfig = ThemeConfig()
      ..followSystemTheme = state.followSystemTheme
      ..lightTheme = state.lightThemeEnum
      ..darkTheme = state.darkThemeEnum
      ..customTheme = state.customThemeEnum;

    saveThemeToLocal(myAppConfig);
  }
}

final themeStateProvider =
    StateNotifierProvider<ThemeViewModel, ThemeState>((ref) {
  var language = ref.read(intlStateProvider);
  return ThemeViewModel(language);
});
