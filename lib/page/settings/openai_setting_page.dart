import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:xat/page/settings/provider/openai_setting_viewmodel.dart';

/// The details screen for either the A or B screen.
class OpenaiSettingPage extends ConsumerWidget {
  /// Constructs a [OpenaiSettingPage].
  const OpenaiSettingPage({
    required this.label,
    this.param,
    this.extra,
    this.withScaffold = true,
    super.key,
  });

  /// The label to display in the center of the screen.
  final String label;

  /// Optional param
  final String? param;

  /// Optional extra object
  final Object? extra;

  /// Wrap in scaffold
  final bool withScaffold;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final int counter = ref.watch(openaiSettingProvider).counter;

    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: (BuildContext context, WidgetRef ref) {
        return Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextButton(
                onPressed: () {
                  GoRouter.of(context).pop();
                },
                child: const Text('< Back1',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              ),
              Text('Details for $label - Counter: $counter',
                  style: Theme.of(context).textTheme.titleLarge),
              const Padding(padding: EdgeInsets.all(4)),
              TextButton(
                onPressed: () {
                  ref
                      .read(openaiSettingProvider.notifier)
                      .increment();
                },
                child: const Text('Increment counter'),
              ),
              const Padding(padding: EdgeInsets.all(8)),
              if (param != null)
                Text('Parameter: ${param!}',
                    style: Theme.of(context).textTheme.titleMedium),
              const Padding(padding: EdgeInsets.all(8)),
              if (extra != null)
                Text('Extra: ${extra!}',
                    style: Theme.of(context).textTheme.titleMedium),
            ],
          ),
        );
      }(context, ref),
    );
  }
}
