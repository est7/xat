import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:xat/widgets/language_bootom_sheet.dart';
import 'package:xat/widgets/language_setting_sheet.dart';

import '../../../const/constants_theme.dart';
import '../../../model/theme_model.dart';
import '../../../widgets/theme_bottom_sheet.dart';
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
        ),
        Container(
          alignment: Alignment.centerLeft, // 让Text组件从左边开始
          child: const Text('语言设置'),
        ),
        ElevatedButton(
          onPressed: () {
            showLanguageSettingSheet(context, ref);
          },
          child: const Text('语言'),
        )
      ],
    );
  }

  void showAllThemeSettingSheet(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
        isScrollControlled: true,
        useRootNavigator: true,
        context: context,
        builder: (context) => ThemeBottomSheet(
            ref: ref,
            themeList: allThemeList,
            buildTrailing: (context, ref, index, model) {
              if (index == 0) {
                return ref.watch(themeStateProvider).followSystemTheme;
              } else {
                if (ref.watch(themeStateProvider).followSystemTheme) {
                  return false;
                }
                return switch (model.themeEnum) {
                  LightEnum() =>
                    ref.watch(themeStateProvider).customThemeEnum.runtimeType ==
                        model.themeEnum.runtimeType,
                  DarkEnum() =>
                    ref.watch(themeStateProvider).customThemeEnum.runtimeType ==
                        model.themeEnum.runtimeType,
                  CustomEnum() => ref
                          .watch(themeStateProvider)
                          .customThemeEnum
                          .getColorValue() ==
                      model.themeEnum.getColorValue()
                };
              }
            }));
  }


  void showLightThemeSettingSheet(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
        isScrollControlled: true,
        useRootNavigator: true,
        context: context,
        builder: (context) => ThemeBottomSheet(
              ref: ref,
              themeList: defaultLightThemeList,
              buildTrailing: (context, ref, _, model) =>
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
              buildTrailing: (context, ref, _, model) =>
                  ref.watch(themeStateProvider).darkThemeEnum.runtimeType ==
                  model.themeEnum.runtimeType,
            ));
  }

  void showLanguageSettingSheet(BuildContext context, WidgetRef ref) {
    showModalBottomDetail(context: context,
        child:const LanguageSettingListWidget());

  }

}

class ThemeItemModel {
  final String text;
  final IconData icon;
  final ThemeEnum themeEnum;
  final Function(BuildContext, WidgetRef, int, ThemeItemModel) onTap;

  ThemeItemModel(
      {required this.text,
      required this.icon,
      required this.themeEnum,
      required this.onTap});
}
