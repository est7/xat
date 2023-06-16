import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../model/app_config_model.dart';
import '../page/settings/state_provider/theme_setting_viewmodel.dart';
import '../page/settings/view/application_setting_page.dart';

class ThemeBottomSheet extends StatelessWidget {
  final WidgetRef ref;
  final List<ThemeItemModel> themeList;
  final bool Function(BuildContext, WidgetRef, ThemeItemModel) buildTrailing;

  const ThemeBottomSheet({
    Key? key,
    required this.ref,
    required this.themeList,
    required this.buildTrailing,
  }) : super(key: key);

  ListTile lightThemeListTile(BuildContext context, WidgetRef ref,
      ThemeItemModel model, LightEnum lightThemeEnum) {
    return ListTile(
      leading: Icon(model.icon),
      title: Text(model.text),
      trailing:
          buildTrailing(context, ref, model) ? const Icon(Icons.check) : null,
      onTap: () {
        model.onTap(context, ref, model);
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, watch, child) {
      final lightThemeEnum = ref.watch(themeStateProvider).lightThemeEnum;
      return Wrap(
        children: themeList
            .map((model) =>
                lightThemeListTile(context, ref, model, lightThemeEnum))
            .toList(),
      );
    });
  }
}
