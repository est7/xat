import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import 'language_hive_model.dart';
import 'theme_hive_model.dart';

const themeKey = 'theme_key';
const languageKey = 'language_key';

saveThemeToLocal(ThemeConfig appConfig) async {
  var appConfigBox = await Hive.openBox<ThemeConfig>('theme_config');
  await appConfigBox.put(themeKey, appConfig);
}

saveLanguageToLocal(LanguageConfig appConfig) async {
  var appConfigBox = await Hive.openBox<LanguageConfig>('language_config');
  await appConfigBox.put(languageKey, appConfig);
}

Future<void> initAppHiveConfig() async {
  final cacheDir = (await getApplicationDocumentsDirectory()).path;
  Hive.init(cacheDir);
  Hive.registerAdapter(ThemeConfigAdapter());
  return Future.value();
}

typedef AppConfigRecord = (ThemeConfig, LanguageConfig);

Future<AppConfigRecord> readToLocal() async {
  var themeConfigBox = await Hive.openBox<ThemeConfig>('theme_config');

  var themeConfig =
      themeConfigBox.get(themeKey, defaultValue: defaultThemeConfig);

  var languageConfigBox = await Hive.openBox<LanguageConfig>('language_config');
  var languageConfig =
      languageConfigBox.get(languageKey, defaultValue: defaultLanguageConfig);

  AppConfigRecord record = (themeConfig!, languageConfig!);
  return Future.value(record);
}
