import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:xat/appconfig/language_state.dart';
import 'package:xat/model/app_config_model.dart';

class LanguageViewModel extends StateNotifier<LanguageState> {
  LanguageViewModel() : super(_initialState);

  static LanguageState get _initialState => const LanguageState(
        followSystemLanguage: true,
        currentLocale: Locale('en'),
      );

  bool get followSystemSetting => _followSystemSetting;

  Locale get currentLanguage => _currentLanguage;

  /// 语言是否跟随系统
  late bool _followSystemSetting;

  late Locale _currentLanguage;

  void initAppIntlConfig(LanguageConfig languageConfig) {
    _followSystemSetting = languageConfig.followSystemLanguage;
    _currentLanguage = languageConfig.locale;

    state = state.copyWith(
      followSystemLanguage: _followSystemSetting,
      currentLocale: _currentLanguage,
    );
  }

  void setLanguage() {}

  void saveToLocalStorage() {
    final myAppConfig = LanguageConfig()
      ..followSystemLanguage = state.followSystemLanguage
      ..locale = state.currentLocale;
    saveLanguageToLocal(myAppConfig);
  }
}

final intlStateProvider =
    StateNotifierProvider<LanguageViewModel, LanguageState>((ref) {
  return LanguageViewModel();
});
