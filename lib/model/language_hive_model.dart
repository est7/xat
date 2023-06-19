
import 'dart:ui';
import 'package:hive/hive.dart';

part 'language_hive_model.g.dart';

@HiveType(typeId: 1)
class LanguageConfig extends HiveObject {
  @HiveField(0, defaultValue: true)
  late bool followSystemLanguage;
  @HiveField(1, defaultValue: Locale('en'))
  late Locale locale;
}

LanguageConfig defaultLanguageConfig = LanguageConfig()
  ..followSystemLanguage = true
  ..locale = const Locale('en');
