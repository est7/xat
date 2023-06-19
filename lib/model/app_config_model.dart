import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'theme_model.dart';

@HiveType(typeId: 0)
class ThemeConfig extends HiveObject {
  @HiveField(0, defaultValue: true)
  late bool followSystemTheme;

  @HiveField(1, defaultValue: LightEnumV1)
  late LightEnum lightTheme;

  @HiveField(2, defaultValue: DarkEnumV1)
  late DarkEnum darkTheme;

  //这里我直接把customTheme改成了int类型，int类型保存的就是 CustomTheme 的 颜色 ARGB
  @HiveField(3, defaultValue: CustomEnum(Color(0xFF942828)))
  late ThemeEnum customTheme;
}

@HiveType(typeId: 1)
class LanguageConfig extends HiveObject {
  @HiveField(0, defaultValue: true)
  late bool followSystemLanguage;
  @HiveField(1, defaultValue: Locale('en'))
  late Locale locale;
}

ThemeConfig defaultThemeConfig = ThemeConfig()
  ..followSystemTheme = true
  ..lightTheme = LightEnumV1()
  ..darkTheme = DarkEnumV1()
  ..customTheme = defaultThemeEnum();

LanguageConfig defaultLanguageConfig = LanguageConfig()
  ..followSystemLanguage = true
  ..locale = const Locale('en');

class ThemeConfigAdapter extends TypeAdapter<ThemeConfig> {
  @override
  final typeId = 0;

  @override
  ThemeConfig read(BinaryReader reader) {
    return ThemeConfig()
      ..followSystemTheme = reader.readBool()
      ..lightTheme = intToColorEnum(reader.readInt()) as LightEnum
      ..darkTheme = intToColorEnum(reader.readInt()) as DarkEnum
      ..customTheme = intToColorEnum(reader.readInt());
  }

  @override
  void write(BinaryWriter writer, ThemeConfig obj) {
    writer.writeBool(obj.followSystemTheme);
    writer.writeInt(colorEnumToInt(obj.lightTheme));
    writer.writeInt(colorEnumToInt(obj.darkTheme));
    writer.writeInt(colorEnumToInt(obj.customTheme));
  }
}

saveThemeToLocal(ThemeConfig appConfig) async {
  var appConfigBox = await Hive.openBox<ThemeConfig>('theme_config');
  await appConfigBox.put('theme_config', appConfig);
}

saveLanguageToLocal(LanguageConfig appConfig) async {
  var appConfigBox = await Hive.openBox<LanguageConfig>('language_config');
  await appConfigBox.put('language_config', appConfig);
}

Future<void> initAppHiveConfig() async {
  WidgetsFlutterBinding.ensureInitialized();
  final cacheDir = (await getApplicationDocumentsDirectory()).path;
  Hive.init(cacheDir);
  Hive.registerAdapter(ThemeConfigAdapter());
  return Future.value();
}

//返回元组
typedef AppConfigRecord = (ThemeConfig, LanguageConfig);

Future<AppConfigRecord> readToLocal() async {
  var themeConfigBox = await Hive.openBox<ThemeConfig>('theme_config');
  var themeConfig = themeConfigBox.getAt(0);

  var languageConfigBox = await Hive.openBox<LanguageConfig>('language_config');
  var languageConfig = languageConfigBox.getAt(1);

  AppConfigRecord record = (themeConfig!, languageConfig!);
  return Future.value(record);
}
