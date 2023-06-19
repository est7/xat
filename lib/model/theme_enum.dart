import 'dart:ui';

import '../util/color_util.dart';

sealed class ThemeEnum {
  final int value;
  final Color? color;

  const ThemeEnum(this.value, {this.color});

  int getColorValue() {
    return color?.value ?? 0;
  }
}

sealed class LightEnum extends ThemeEnum {
  const LightEnum(int v, {Color? c}) : super(v);
}

class LightEnumV1 extends LightEnum {
  LightEnumV1() : super(1);
}

class LightEnumV2 extends LightEnum {
  LightEnumV2() : super(2);
}

class LightEnumV3 extends LightEnum {
  LightEnumV3() : super(3);
}

sealed class DarkEnum extends ThemeEnum {
  const DarkEnum(int v, {Color? c}) : super(v);
}

class DarkEnumV1 extends DarkEnum {
  DarkEnumV1() : super(11);
}

class DarkEnumV2 extends DarkEnum {
  DarkEnumV2() : super(12);
}

class DarkEnumV3 extends DarkEnum {
  DarkEnumV3() : super(13);
}

class CustomEnum extends ThemeEnum {
  const CustomEnum(Color c) : super(0, color: c);
}

// Convert enum to int
int colorEnumToInt(ThemeEnum theme) {
  return switch (theme) {
    LightEnum() => theme.value, //这里的theme.value就是上面的1，2
    DarkEnum() => theme.value, //这里的theme.value就是上面的11，12
    CustomEnum() => theme.color!.value, //这里的theme.color.value就是MaterialColor c
  };
}

// Convert int to enum
ThemeEnum intToColorEnum(int index) {
  switch (index) {
    case 1:
      return LightEnumV1();
    case 2:
      return LightEnumV2();
    case 3 :
      return LightEnumV3();
    case 11:
      return DarkEnumV1();
    case 12:
      return DarkEnumV2();
    case 13:
      return DarkEnumV3();
    default:
      return CustomEnum(parseIntToColor(index));
  }
}

ThemeEnum defaultThemeEnum() {
  return const CustomEnum(Color(0xFF42A5F5));
}

ThemeEnum CustomEnumV1() {
  return const CustomEnum(Color(0xFFFF00FF));
}

ThemeEnum CustomEnumV2() {
  return const CustomEnum(Color(0xFF0000FF));
}
