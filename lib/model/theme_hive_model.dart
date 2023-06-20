import 'dart:ui';

import 'package:hive/hive.dart';

import 'theme_enum.dart';



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

ThemeConfig defaultThemeConfig = ThemeConfig()
  ..followSystemTheme = true
  ..lightTheme = LightEnumV1()
  ..darkTheme = DarkEnumV1()
  ..customTheme = defaultThemeEnum();


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
