import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:xat/widgets/setting_custom_item.dart';

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
        title: Text(label),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text('Screen $label', style: Theme.of(context).textTheme.titleLarge),
          SettingCustomItem(
              title: "openai_setting",
              position: Position.single,
              onClick: () =>
                  GoRouter.of(context).go('/settings/openai_setting')),
          SettingCustomItem(
              title: "azure_setting",
              position: Position.single,
              description: "description",
              onClick: () =>
                  GoRouter.of(context).go('/settings/azure_setting')),
          SettingCustomItem(
              title: "chat_setting",
              position: Position.single,
              description: "description",
              onClick: () => GoRouter.of(context).go('/settings/chat_setting')),
        ],
      ),
    );
  }
}
