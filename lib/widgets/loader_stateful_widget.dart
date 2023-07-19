import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../mixins/loadable.dart';


class LoaderStateWidget extends ConsumerStatefulWidget {
  const LoaderStateWidget({
    super.key,
    required this.provider,
    required this.child,
  });

  final Loadable provider;
  final Widget child;

  @override
  ConsumerState<LoaderStateWidget> createState() =>
      _StateNotifierLoaderState();
}

class _StateNotifierLoaderState extends ConsumerState<LoaderStateWidget> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.provider.load();
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}