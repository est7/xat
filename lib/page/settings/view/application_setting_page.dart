import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:xat/model/app_config_model.dart';

import '../../../widgets/theme_bottom_sheet.dart';
import '../state_provider/theme_setting_viewmodel.dart';

class ApplicationSettingPage extends ConsumerWidget {
  final String label;
  /// Constructs a [ApplicationSettingPage].
  ApplicationSettingPage({
    Key? key,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(title: const Text("Theme/Language")),
      body: _buildBody(context, ref),
    );
  }

  _buildBody(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch, // 让Column的子组件填充满可用空间
      children: [
        Container(
          alignment: Alignment.centerLeft, // 让Text组件从左边开始
          child: const Text('主题设置'),
        ),
        ElevatedButton(
          onPressed: () {
            showAllThemeSettingSheet(context, ref);
          },
          child: const Text('主题'),
        ),
        ElevatedButton(
          onPressed: () {
            showLightThemeSettingSheet(context, ref);
          },
          child: const Text('默认浅色主题'),
        ),
        ElevatedButton(
          onPressed: () {
            showDarkThemeSettingSheet(context, ref);
          },
          child: const Text('默认暗色主题'),
        )
      ],
    );
  }

  void showAllThemeSettingSheet(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
        isScrollControlled: true,
        useRootNavigator: true,
        context: context,
        builder: (context) => Wrap(children: [
              ListTile(
                leading: const Icon(Icons.settings_system_daydream),
                title: const Text('跟随系统'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.wb_sunny),
                title: const Text('浅色主题'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.nightlight_round),
                title: const Text('暗色主题'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ]));
  }

  final List<ThemeItemModel> defaultLightThemeList = [
    ThemeItemModel(
        text: '浅色主题1',
        icon: Icons.wb_sunny,
        themeEnum: LightEnumV1(),
        onTap: (context, ref, model) {
          ref
              .read(themeStateProvider.notifier)
              .setThemeMode(newLightTheme: LightEnumV1());
        }),
    ThemeItemModel(
        text: '浅色主题2',
        icon: Icons.wb_sunny,
        themeEnum: LightEnumV2(),
        onTap: (context, ref, model) {
          ref
              .read(themeStateProvider.notifier)
              .setThemeMode(newLightTheme: LightEnumV2());
        })
  ];

  final List<ThemeItemModel> defaultDarkThemeList = [
    ThemeItemModel(
        text: '深色主题1',
        icon: Icons.nightlight,
        themeEnum: DarkEnumV1(),
        onTap: (context, ref, model) {
          ref
              .read(themeStateProvider.notifier)
              .setThemeMode(newDarkTheme: DarkEnumV1());
        }),
    ThemeItemModel(
        text: '深色主题2',
        icon: Icons.nightlight,
        themeEnum: DarkEnumV2(),
        onTap: (context, ref, model) {
          ref
              .read(themeStateProvider.notifier)
              .setThemeMode(newDarkTheme: DarkEnumV2());
        })
  ];

  void showLightThemeSettingSheet(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
        isScrollControlled: true,
        useRootNavigator: true,
        context: context,
        builder: (context) => ThemeBottomSheet(
              ref: ref,
              themeList: defaultLightThemeList,
              buildTrailing: (context, ref, model) =>
                  ref.watch(themeStateProvider).lightThemeEnum.runtimeType ==
                  model.themeEnum.runtimeType,
            ));
  }

  void showDarkThemeSettingSheet(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
        isScrollControlled: true,
        useRootNavigator: true,
        context: context,
        builder: (context) => ThemeBottomSheet(
              ref: ref,
              themeList: defaultDarkThemeList,
              buildTrailing: (context, ref, model) =>
                  ref.watch(themeStateProvider).darkThemeEnum.runtimeType ==
                  model.themeEnum.runtimeType,
            ));
  }
}

class ThemeItemModel {
  final String text;
  final IconData icon;
  final ThemeEnum themeEnum;
  final Function(BuildContext, WidgetRef, ThemeItemModel) onTap;

  ThemeItemModel(
      {required this.text,
      required this.icon,
      required this.themeEnum,
      required this.onTap});
}
