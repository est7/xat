import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:xat/appconfig/language_state.dart';
import 'package:xat/model/app_config_model.dart';

import '../../../const/constants_language.dart';
import '../../../model/language_hive_model.dart';

class LanguageViewModel extends StateNotifier<LanguageState> {
  LanguageViewModel() : super(_initialState);

  static LanguageState get _initialState => const LanguageState(
      followSystemLanguage: true, currentLanguageString: "English");

  /// 语言是否跟随系统
  late bool _followSystemSetting;

  late String _currentLanguage;

  void initAppIntlConfig(LanguageConfig languageConfig) {
    _followSystemSetting = languageConfig.followSystemLanguage;
    _currentLanguage = languageConfig.currentLanguageStr;

    state = state.copyWith(
      followSystemLanguage: _followSystemSetting,
      currentLanguageString: _currentLanguage,
    );
  }

  void setFollowSystemLanguage(bool followSystemLanguage) {
    _followSystemSetting = followSystemLanguage;
    state = state.copyWith(followSystemLanguage: _followSystemSetting);
    saveToLocalStorage();
  }

  void setLanguage(String language) {
    _currentLanguage = language;
    _followSystemSetting = false;
    state = state.copyWith(
        followSystemLanguage: _followSystemSetting,
        currentLanguageString: _currentLanguage);
    saveToLocalStorage();
  }

  void saveToLocalStorage() {
    final myAppConfig = LanguageConfig()
      ..followSystemLanguage = state.followSystemLanguage
      ..currentLanguageStr = state.currentLanguageString;
    saveLanguageToLocal(myAppConfig);
  }
}

final intlStateProvider =
    StateNotifierProvider<LanguageViewModel, LanguageState>((ref) {
  return LanguageViewModel();
});
