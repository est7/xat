import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:xat/widgets/language_bootom_sheet.dart';
import 'package:xat/feature/settings/presentation/widgets/language_setting_sheet.dart';

import '../../../../const/constants_theme.dart';
import '../../../../generated/l10n.dart';
import '../../../../model/theme_enum.dart';
import '../viewmodels/theme_setting_viewmodel.dart';
import '../widgets/theme_bottom_sheet.dart';

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
      appBar: AppBar(title: Text(S.of(context).theme_and_language)),
      body: _buildBody(context, ref),
    );
  }

  _buildBody(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch, // 让Column的子组件填充满可用空间
      children: [
        Container(
          alignment: Alignment.centerLeft, // 让Text组件从左边开始
          child: Text(S.of(context).theme_setting),
        ),
        ElevatedButton(
          onPressed: () {
            showAllThemeSettingSheet(context, ref);
          },
          child: Text(S.of(context).theme),
        ),
        ElevatedButton(
          onPressed: () {
            showLightThemeSettingSheet(context, ref);
          },
          child: Text(S.of(context).default_light_theme),
        ),
        ElevatedButton(
          onPressed: () {
            showDarkThemeSettingSheet(context, ref);
          },
          child: Text(S.of(context).default_Dark_theme),
        ),
        Container(
          alignment: Alignment.centerLeft, // 让Text组件从左边开始
          child: Text(S.of(context).language_setting),
        ),
        ElevatedButton(
          onPressed: () {
            showLanguageSettingSheet(context, ref);
          },
          child: Text(S.of(context).language),
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
    showModalBottomDetail(
        context: context, child: const LanguageSettingListWidget());
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
