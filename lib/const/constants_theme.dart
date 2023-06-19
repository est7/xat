
import 'package:flutter/material.dart';

import '../model/theme_enum.dart';
import '../page/settings/state_provider/theme_setting_viewmodel.dart';
import '../page/settings/view/application_setting_page.dart';

final List<ThemeItemModel> allThemeList = [
  ThemeItemModel(
      text: '跟随系统',
      icon: Icons.wb_sunny,
      themeEnum: LightEnumV1(),
      onTap: (context, ref, index, model) {
        ref
            .read(themeStateProvider.notifier)
            .setThemeMode(newFollowSystemTheme: true);
      }),
  ThemeItemModel(
      text: '浅色主题1',
      icon: Icons.wb_sunny,
      themeEnum: LightEnumV1(),
      onTap: (context, ref, index, model) {
        ref.read(themeStateProvider.notifier).setThemeMode(
            newFollowSystemTheme: false,
            newCustomTheme: model.themeEnum as LightEnum);
      }),
  ThemeItemModel(
      text: '浅色主题2',
      icon: Icons.wb_sunny,
      themeEnum: LightEnumV2(),
      onTap: (context, ref, index, model) {
        ref.read(themeStateProvider.notifier).setThemeMode(
            newFollowSystemTheme: false,
            newCustomTheme: model.themeEnum as LightEnum);
      }),
  ThemeItemModel(
      text: '深色主题1',
      icon: Icons.nightlight,
      themeEnum: DarkEnumV1(),
      onTap: (context, ref, index, model) {
        ref.read(themeStateProvider.notifier).setThemeMode(
            newFollowSystemTheme: false,
            newCustomTheme: model.themeEnum as DarkEnum);
      }),
  ThemeItemModel(
      text: '深色主题2',
      icon: Icons.nightlight,
      themeEnum: DarkEnumV2(),
      onTap: (context, ref, index, model) {
        ref.read(themeStateProvider.notifier).setThemeMode(
            newFollowSystemTheme: false,
            newCustomTheme: model.themeEnum as DarkEnum);
      }),
  ThemeItemModel(
      text: '自定义V1',
      icon: Icons.sunny_snowing,
      themeEnum: CustomEnumV1(),
      onTap: (context, ref, _, model) {
        ref.read(themeStateProvider.notifier).setThemeMode(
            newFollowSystemTheme: false, newCustomTheme: model.themeEnum);
      }),
  ThemeItemModel(
      text: '自定义V2',
      icon: Icons.sunny_snowing,
      themeEnum: CustomEnumV2(),
      onTap: (context, ref, _, model) {
        ref.read(themeStateProvider.notifier).setThemeMode(
            newFollowSystemTheme: false, newCustomTheme: model.themeEnum);
      })
];

final List<ThemeItemModel> defaultLightThemeList = [
  ThemeItemModel(
      text: '浅色主题1',
      icon: Icons.wb_sunny,
      themeEnum: LightEnumV1(),
      onTap: (context, ref, _, model) {
        ref
            .read(themeStateProvider.notifier)
            .setThemeMode(newLightTheme: model.themeEnum as LightEnum);
      }),
  ThemeItemModel(
      text: '浅色主题2',
      icon: Icons.wb_sunny,
      themeEnum: LightEnumV2(),
      onTap: (context, ref, _, model) {
        ref
            .read(themeStateProvider.notifier)
            .setThemeMode(newLightTheme: model.themeEnum as LightEnum);
      }),
  ThemeItemModel(
      text: '浅色主题3',
      icon: Icons.wb_sunny,
      themeEnum: LightEnumV3(),
      onTap: (context, ref, _, model) {
        ref
            .read(themeStateProvider.notifier)
            .setThemeMode(newLightTheme: model.themeEnum as LightEnum);
      })
];

final List<ThemeItemModel> defaultDarkThemeList = [
  ThemeItemModel(
      text: '深色主题1',
      icon: Icons.nightlight,
      themeEnum: DarkEnumV1(),
      onTap: (context, ref, _, model) {
        ref
            .read(themeStateProvider.notifier)
            .setThemeMode(newDarkTheme: model.themeEnum as DarkEnum);
      }),
  ThemeItemModel(
      text: '深色主题2',
      icon: Icons.nightlight,
      themeEnum: DarkEnumV2(),
      onTap: (context, ref, _, model) {
        ref
            .read(themeStateProvider.notifier)
            .setThemeMode(newDarkTheme: model.themeEnum as DarkEnum);
      }),
  ThemeItemModel(
      text: '深色主题3',
      icon: Icons.nightlight,
      themeEnum: DarkEnumV3(),
      onTap: (context, ref, _, model) {
        ref
            .read(themeStateProvider.notifier)
            .setThemeMode(newDarkTheme: model.themeEnum as DarkEnum);
      })
];