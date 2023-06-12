import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PromptPage extends StatelessWidget {
  const PromptPage({
    required this.label,
    required this.detailsPath,
    this.secondDetailsPath,
    super.key,
  });

  /// The label
  final String label;

  /// The path to the detail page
  final String detailsPath;

  /// The path to another detail page
  final String? secondDetailsPath;

  /// GoRouter.of(context).go(detailsPath, extra: '$label-XYZ');
  /// GoRouter.of(context).go(secondDetailsPath!);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(label, style: Theme.of(context).textTheme.titleLarge),
      ),
      body: const Column(
        mainAxisSize: MainAxisSize.min,
        children: [Text('fas')],
      ),
    );
  }
}
