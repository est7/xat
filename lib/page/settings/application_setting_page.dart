import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:xat/page/settings/state_provider/theme_provider.dart';

/// The details screen for either the A or B screen.
class ApplicationSettingPage extends ConsumerWidget {
  final String label;

  final param;

  final extra;

  /// Constructs a [ApplicationSettingPage].
  const ApplicationSettingPage({
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
            showThemeSettingSheet(context, ref);
          },
          child: const Text('主题'),
        ),
        ElevatedButton(
          onPressed: () {
            showLightThemeSettingSheet(context, ref);
            ref.read(themeStateProvider.notifier).followSystem();
          },
          child: const Text('默认浅色主题'),
        ),
        ElevatedButton(
          onPressed: () {
            showDarkThemeSettingSheet(context, ref);
            ref.read(themeStateProvider.notifier).followSystem();
          },
          child: const Text('默认暗色主题'),
        )
      ],
    );
  }

  

  void showThemeSettingSheet(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
        isScrollControlled: true,
        useRootNavigator: true,
        context: context,
        builder: (context) => Wrap(children: [
              ListTile(
                leading: const Icon(Icons.wb_sunny),
                title: const Text('浅色主题'),
                onTap: () {
                  ref
                      .read(themeStateProvider.notifier)
                      .setThemeMode(ThemeMode.light);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.nightlight_round),
                title: const Text('暗色主题'),
                onTap: () {
                  ref
                      .read(themeStateProvider.notifier)
                      .setThemeMode(ThemeMode.dark);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.settings_system_daydream),
                title: const Text('跟随系统'),
                onTap: () {
                  ref.read(themeStateProvider.notifier).followSystem();
                  Navigator.pop(context);
                },
              ),
            ]));
  }

  ListTile themeListTile(WidgetRef ref, IconData icon, String text, ThemeMode mode) {
    return ListTile(
      leading: Icon(icon),
      title: Text(text),
      trailing: ref.watch(themeStateProvider) == mode ? Icon(Icons.check) : null,
      onTap: () {
        ref.read(themeStateProvider.notifier).setThemeMode(mode);
        Navigator.pop(context);
      },
    );
  }



  void showDarkThemeSettingSheet(BuildContext context, WidgetRef ref) {
    List<String> list = ['浅色主题', '暗色主题', '跟随系统'];
    list.map((e) => themeListTile(ref, Icons.wb_sunny, '浅色主题', ThemeMode.light))
    showModalBottomSheet(
        isScrollControlled: true,
        useRootNavigator: true,
        context: context,
        builder: (context) => Wrap(children: [
              themeListTile(ref, Icons.wb_sunny, '浅色主题', ThemeMode.light),
              themeListTile(ref, Icons.nightlight_round, '暗色主题', ThemeMode.dark),
              themeListTile(ref, Icons.settings_system_daydream, '跟随系统', ThemeMode.system),
            ]));

  }

  void showLightThemeSettingSheet(BuildContext context, WidgetRef ref) {

  }
}

