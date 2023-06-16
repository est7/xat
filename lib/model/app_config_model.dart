import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../page/settings/state_provider/theme_setting_viewmodel.dart';
import '../util/color_util.dart';

@HiveType(typeId: 0)
class AppConfig extends HiveObject {
  @HiveField(0)
  late bool followSystemTheme;

  @HiveField(1)
  late LightEnum lightTheme;

  @HiveField(2)
  late DarkEnum darkTheme;

  //这里我直接把customTheme改成了int类型，int类型保存的就是 CustomTheme 的 颜色 ARGB
  @HiveField(3)
  late ThemeEnum customTheme;

  @HiveField(4)
  late String language;
}

class AppConfigAdapter extends TypeAdapter<AppConfig> {
  @override
  final typeId = 0;

  @override
  AppConfig read(BinaryReader reader) {
    return AppConfig()
      ..followSystemTheme = reader.readBool()
      ..lightTheme = intToColorEnum(reader.readInt()) as LightEnum
      ..darkTheme = intToColorEnum(reader.readInt()) as DarkEnum
      ..customTheme = intToColorEnum(reader.readInt())
      ..language = reader.readString();
  }

  @override
  void write(BinaryWriter writer, AppConfig obj) {
    writer.writeBool(obj.followSystemTheme);
    writer.writeInt(colorEnumToInt(obj.lightTheme));
    writer.writeInt(colorEnumToInt(obj.darkTheme));
    writer.writeInt(colorEnumToInt(obj.customTheme));
    writer.writeString(obj.language);
  }
}

sealed class ThemeEnum {
  final int value;
  final MaterialColor color;

  const ThemeEnum(this.value, this.color);
}

sealed class LightEnum extends ThemeEnum {
  const LightEnum(int v, MaterialColor c) : super(v, c);
}

class LightEnumV1 extends LightEnum {
  LightEnumV1() : super(1, Colors.red);
}

class LightEnumV2 extends LightEnum {
  LightEnumV2() : super(2, Colors.green);
}

sealed class DarkEnum extends ThemeEnum {
  const DarkEnum(int v, MaterialColor c) : super(v, c);
}

class DarkEnumV1 extends DarkEnum {
  DarkEnumV1() : super(11, Colors.red);
}

class DarkEnumV2 extends DarkEnum {
  DarkEnumV2() : super(12, Colors.green);
}

class CustomEnum extends ThemeEnum {
  const CustomEnum(MaterialColor c) : super(0, c);
}

// Convert enum to int
int colorEnumToInt(ThemeEnum theme) {
  return switch (theme) {
    LightEnum() => theme.value, //这里的theme.value就是上面的1，2
    DarkEnum() => theme.value, //这里的theme.value就是上面的11，12
    CustomEnum() => theme.color.value, //这里的theme.color.value就是MaterialColor c
  };
}

// Convert int to enum
ThemeEnum intToColorEnum(int index) {
  switch (index) {
    case 1:
      return LightEnumV1();
    case 2:
      return LightEnumV2();
    case 11:
      return DarkEnumV1();
    case 12:
      return DarkEnumV2();
    default:
      return CustomEnum(createMaterialColor(parseIntToColor(index)));
  }
}

ThemeEnum defaultThemeEnum() {
  return CustomEnum(createMaterialColor(Colors.grey));
}
