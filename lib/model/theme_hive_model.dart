import 'dart:ui';

import 'package:hive/hive.dart';
import 'package:xat/model/theme_enum.dart';


part 'theme_hive_model.g.dart';

@HiveType(typeId: 0)
class ThemeConfig extends HiveObject {
  @HiveField(0)
  late bool followSystemTheme;

  @HiveField(1)
  late LightEnum lightTheme;

  @HiveField(2)
  late DarkEnum darkTheme;

  @HiveField(3)
  late ThemeEnum customTheme;
}

ThemeConfig defaultThemeConfig = ThemeConfig()
  ..followSystemTheme = true
  ..lightTheme = LightEnumV1()
  ..darkTheme = DarkEnumV1()
  ..customTheme = defaultThemeEnum();


/*
//自动生成了,不用手动写
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
*/
