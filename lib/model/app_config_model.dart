import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

@HiveType(typeId: 0)
class AppConfig extends HiveObject {
  @HiveField(0)
  bool followSystemTheme = true;

  @HiveField(1)
  LightEnum lightTheme = LightEnum.LightEnumV1;

  @HiveField(2)
  DarkEnum darkTheme = DarkEnum.DarkEnumV1;

  @HiveField(3)
  CustomEnum customTheme = const CustomEnum(0xFF000000);
  @HiveField(4)
  String language = '';
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
      ..customTheme = CustomEnum(reader.readInt())
      ..language = reader.readString();
  }

  @override
  void write(BinaryWriter writer, AppConfig obj) {
    writer.writeBool(obj.followSystemTheme);
    writer.writeInt(colorEnumToInt(obj.lightTheme));
    writer.writeInt(colorEnumToInt(obj.darkTheme));
    writer.writeInt(obj.customTheme.value);
    writer.writeString(obj.language);
  }
}

sealed class ThemeEnum {
  final int value;

  const ThemeEnum(this.value);
}

class LightEnum extends ThemeEnum {
  const LightEnum._(int v) : super(v);

  static const LightEnumV1 = LightEnum._(1);
  static const LightEnumV2 = LightEnum._(2);
}

class DarkEnum extends ThemeEnum {
  const DarkEnum._(int v) : super(v);

  static const DarkEnumV1 = DarkEnum._(3);
  static const DarkEnumV2 = DarkEnum._(4);
}

class CustomEnum extends ThemeEnum {
  const CustomEnum(int color) : super(color);
}

// Convert enum to int
int colorEnumToInt(ThemeEnum theme) {
  return switch (theme) {
    LightEnum() => theme.value,
    DarkEnum() => theme.value,
    CustomEnum() => theme.value,
  };
}

// Convert int to enum
ThemeEnum intToColorEnum(int index) {
  switch (index) {
    case 1:
      return LightEnum.LightEnumV1;
    case 2:
      return LightEnum.LightEnumV2;
    case 3:
      return DarkEnum.DarkEnumV1;
    case 4:
      return DarkEnum.DarkEnumV2;
    default:
      return CustomEnum(index);
  }
}
