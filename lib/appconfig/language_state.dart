
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'language_state.freezed.dart';

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
class LanguageState with _$LanguageState {
  const factory LanguageState({
    required bool followSystemLanguage,
    required Locale currentLocale,
  }) = _LanguageState;
}