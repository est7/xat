import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../mixins/loadable.dart';

class LoaderHookWidget extends HookConsumerWidget {
  const LoaderHookWidget({
    super.key,
    required this.provider,
    required this.child,
  });

  final Loadable provider;
  final Widget child;

  /**
   *     useEffect(() {
      // chatViewModel.getChatSectionList();
      // 下面这行返回一个 cleanup 函数，当组件卸载时会执行这个函数。
      // 如果你没有需要在卸载时执行的操作，就直接返回空函数即可。
      // 返回一个 cleanup 函数，在组件卸载时取消订阅
      return () {};
      }, []); // 依赖列表为空，说明这个 effect 只在组件挂载时执行一次。
   */
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
         await provider.load();
      });
      return null;
    }, []);
    return child;
  }
}
