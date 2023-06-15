import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:xat/model/app_config_model.dart';

import '../state_provider/theme_setting_viewmodel.dart';

/// The details screen for either the A or B screen.
class ApplicationSettingPage extends ConsumerWidget {
  final String label;

  final param;

  final extra;

  /// Constructs a [ApplicationSettingPage].
  ApplicationSettingPage({
    required this.label,
    this.param,
    this.extra,
    super.key,
  });

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
                  ref.read(themeStateProvider.notifier).followSystem();
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

  ListTile themeListTile(
      BuildContext context, WidgetRef ref, ThemeItemModel model) {
    return ListTile(
      leading: Icon(model.icon),
      title: Text(model.text),
      trailing: model.isSelect ? const Icon(Icons.check) : null,
      onTap: () {
        model.onTap(context, ref, model);
        Navigator.pop(context);
      },
    );
  }

  final List<ThemeItemModel> defaultLightThemeList = [
    ThemeItemModel(
        text: '浅色主题1',
        icon: Icons.wb_sunny,
        themeEnum: LightEnumV1(),
        isSelect: false,
        onTap: (context, ref, model) {
          ref.read(themeStateProvider.notifier).setThemeMode(LightEnumV1());
        }),
    ThemeItemModel(
        text: '浅色主题2',
        icon: Icons.wb_sunny,
        themeEnum: LightEnumV2(),
        isSelect: false,
        onTap: (context, ref, model) {
          ref.read(themeStateProvider.notifier).setThemeMode(LightEnumV2());
        })
  ];
  final List<ThemeItemModel> defaultDarkThemeList = [
    ThemeItemModel(
        text: '深色主题1',
        icon: Icons.nightlight,
        themeEnum: DarkEnumV1(),
        isSelect: false,
        onTap: (context, ref, model) {
          ref.read(themeStateProvider.notifier).setThemeMode(DarkEnumV1());
        }),
    ThemeItemModel(
        text: '深色主题2',
        icon: Icons.nightlight,
        themeEnum: DarkEnumV2(),
        isSelect: false,
        onTap: (context, ref, model) {
          ref.read(themeStateProvider.notifier).setThemeMode(DarkEnumV2());
        })
  ];

  void showLightThemeSettingSheet(BuildContext context, WidgetRef ref) {
    LightEnum lightThemeEnum = ref.watch(themeStateProvider).lightThemeEnum;

    defaultLightThemeList.forEach((element) {
      element.isSelect = element.themeEnum.runtimeType== lightThemeEnum.runtimeType;
    });

    List<ListTile> listTiles = defaultLightThemeList
        .map((model) => themeListTile(context, ref, model))
        .toList();
    showModalBottomSheet(
        isScrollControlled: true,
        useRootNavigator: true,
        context: context,
        builder: (context) => Wrap(children: listTiles));
  }

  void showDarkThemeSettingSheet(BuildContext context, WidgetRef ref) {
    DarkEnum darkThemeEnum = ref.watch(themeStateProvider).darkThemeEnum;

    defaultDarkThemeList.forEach((element) {
      element.isSelect = element.themeEnum.runtimeType == darkThemeEnum.runtimeType;
    });

    List<ListTile> listTiles = defaultLightThemeList
        .map((model) => themeListTile(context, ref, model))
        .toList();
    showModalBottomSheet(
        isScrollControlled: true,
        useRootNavigator: true,
        context: context,
        builder: (context) => Wrap(children: listTiles));
  }
}

class ThemeItemModel {
  final String text;
  final IconData icon;
  bool isSelect;
  final ThemeEnum themeEnum;
  final Function(BuildContext, WidgetRef, ThemeItemModel) onTap;

  ThemeItemModel(
      {required this.text,
      required this.icon,
      required this.themeEnum,
      required this.isSelect,
      required this.onTap});
}
