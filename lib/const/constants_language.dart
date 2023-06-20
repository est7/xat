import 'dart:ui';

const List<Map<String, Object>> languageConfigList = [
  {
    "language": "English",
    "locale": Locale('en'),
  },
  {
    "language": "Español",
    "locale": Locale('es'),
  },
  {
    "language": "简体中文",
    "locale": Locale('zh', 'CN'),
  },
  {
    "language": "繁體中文（台灣）",
    "locale": Locale('zh', 'TW'),
  },
  {
    "language": "繁體中文（香港）",
    "locale": Locale('zh', 'HK'),
  },
];

Locale? findLocale(String str) {
  final localeObj = languageConfigList.firstWhere(
        (element) => element['language'] == str,
    orElse: () => {},
  );
  return localeObj.containsKey('locale') ? localeObj['locale'] as Locale : null;
}