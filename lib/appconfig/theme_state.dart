
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'theme_state.freezed.dart';

/*class ThemeState {
  final bool followSystemTheme;
  final ThemeData customThemeData;
  final ThemeData lightThemeData;
  final ThemeData darkThemeData;

  ThemeState({required this.followSystemTheme,
    required this.customThemeData,
    required this.lightThemeData,
    required this.darkThemeData});
}*/

@freezed
class ThemeState with _$ThemeState {
  const factory ThemeState({
    required bool followSystemTheme,
    required ThemeData customThemeData,
    required ThemeData lightThemeData,
    required ThemeData darkThemeData,
  }) = _ThemeState;
}
