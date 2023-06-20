import 'dart:ui';
import 'package:hive/hive.dart';

part 'language_hive_model.g.dart';

@HiveType(typeId: 1)
class LanguageConfig extends HiveObject {
  @HiveField(0, defaultValue: true)
  late bool followSystemLanguage;
  @HiveField(1, defaultValue: "English")
  late String currentLanguageStr;
}

/*
class LanguageConfigAdapter extends TypeAdapter<LanguageConfig> {
  @override
  final typeId = 1;

  @override
  LanguageConfig read(BinaryReader reader) {
    return LanguageConfig()
      ..followSystemLanguage = reader.readBool()
      ..currentLanguageStr = reader.readString();
  }

  @override
  void write(BinaryWriter writer, LanguageConfig obj) {
    writer.writeBool(obj.followSystemLanguage);
    writer.writeString(obj.currentLanguageStr);
  }
}
*/

LanguageConfig defaultLanguageConfig = LanguageConfig()
  ..followSystemLanguage = true
  ..currentLanguageStr = "English";
