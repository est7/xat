import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../provider/theme_state.dart';

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
      appBar: AppBar(title: const Text("Theme/Language")),
      body: _buildBody(ref),
    );
  }

  _buildBody(WidgetRef ref) {
    return Column(
      children: [
        const Text('UserDarkMode'),
        TextButton(
          onPressed: () {
            ref.read(themeStateProvider.notifier).toggleUserDarkMode();
          },
          child: const Text('toggleUserDarkMode'),
        ),
      ],
    );
  }
}
