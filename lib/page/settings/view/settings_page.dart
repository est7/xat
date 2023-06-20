import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:xat/widgets/setting_custom_item.dart';

import '../../../generated/l10n.dart';

class SettingsPage extends ConsumerWidget {
  /// Creates a RootScreen
  const SettingsPage({
    required this.label,
    required this.detailsPath,
    super.key,
  });

  /// The label
  final String label;

  /// The path to the detail page
  final String detailsPath;

  @override
  Widget build(BuildContext context, ref) {
    // final viewModel  = ref(settingViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(label, style: Theme.of(context).textTheme.titleLarge),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SettingCustomItem(
              title: S.of(context).openai_setting,
              description: S.of(context).openai_setting_desc,
              position: Position.single,
              onClick: () =>
                  GoRouter.of(context).go('/settings/openai_setting')),
          SettingCustomItem(
              title: S.of(context).azure_setting,
              position: Position.single,
              description: S.of(context).azure_setting_desc,
              onClick: () =>
                  GoRouter.of(context).go('/settings/azure_setting')),
          SettingCustomItem(
              title: S.of(context).chat_setting,
              position: Position.single,
              description: S.of(context).chat_setting_desc,
              onClick: () => GoRouter.of(context).go('/prompt/prompt_detail')),
          SettingCustomItem(
              title: S.of(context).theme_and_language,
              position: Position.single,
              onClick: () =>
                  GoRouter.of(context).go('/settings/application_setting'))
        ],
      ),
    );
  }
}
