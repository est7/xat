import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../viewmodels/chat_viewmodel.dart';

class ChatPage extends HookConsumerWidget {
  const ChatPage({
    required this.label,
    required this.detailsPath,
    super.key,
  });

  /// The label
  final String label;

  /// The path to the detail page
  final String detailsPath;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var chatViewModel = ref.watch(chatViewModelProvider.notifier);
    useEffect(() {
      chatViewModel.getAllChatList();
      // 下面这行返回一个 cleanup 函数，当组件卸载时会执行这个函数。
      // 如果你没有需要在卸载时执行的操作，就直接返回空函数即可。
      return () {};
    }, const []); // 依赖列表为空，说明这个 effect 只在组件挂载时执行一次。
    return Scaffold(
      appBar: AppBar(
        title: Text(label),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text('Screen',
                style: Theme
                    .of(context)
                    .textTheme
                    .titleLarge),
            const Padding(padding: EdgeInsets.all(4)),
            TextButton(
              onPressed: () {
                GoRouter.of(context)
                    .go(detailsPath, extra: '${label}-chatId');
              },
              child: const Text('View details'),
            ),
          ],
        ),
      ),
    );
  }
}
