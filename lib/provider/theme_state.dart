import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ThemeState extends StateNotifier<ThemeData> {
  ThemeState() : super(_initialTheme);

  static final _initialTheme = ThemeData.light(useMaterial3: true);

  bool _userDarkMode = false;
  MaterialColor _themeColor = Colors.red;

  void themeData() {
    bool isDark = _userDarkMode;
    Brightness brightness = isDark ? Brightness.dark : Brightness.light;

    MaterialColor themeColor = _themeColor;
    Color accentColor = isDark ? themeColor[700]! : _themeColor;

    ThemeData themeData = ThemeData(
      useMaterial3: true,
      brightness: brightness,
      primaryColor: themeColor,
      hintColor: accentColor,
    );

    state = themeData;
  }

  void toggleUserDarkMode() {
    _userDarkMode = !_userDarkMode;
    themeData();
  }

  void changeThemeColor(MaterialColor newColor) {
    _themeColor = newColor;
    themeData();
  }
}

final themeStateProvider = StateNotifierProvider<ThemeState, ThemeData>((ref) {
  return ThemeState();
});
