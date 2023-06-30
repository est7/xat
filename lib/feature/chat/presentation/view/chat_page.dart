import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../model/chat_model.dart';
import '../../domian/model/chat_page_state.dart';
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
    var chatViewModel = ref.watch(chatViewModelProvider);
    useEffect(() {
      // chatViewModel.getAllChatList();
      // 下面这行返回一个 cleanup 函数，当组件卸载时会执行这个函数。
      // 如果你没有需要在卸载时执行的操作，就直接返回空函数即可。
      return () {};
    }, const []); // 依赖列表为空，说明这个 effect 只在组件挂载时执行一次。
    return Scaffold(
      appBar: AppBar(
        title: Text(label),
      ),
      body: _buildBody(ref, chatViewModel, context),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _createChatSection(ref, context);
        },
        tooltip: 'create_chat',
        child: const Icon(Icons.add),
      ),
    );
  }

/*
  Widget _buildBody(WidgetRef ref, ChatState state, BuildContext context) {
    return state.when(
      initial: () => const Center(child: Text('initial')),
      loading: () => const Center(child: CircularProgressIndicator()),
      loaded: (chats) => RefreshIndicator(
          onRefresh: () async {
            await ref.read(chatViewModelProvider.notifier).getAllChatList();
          },
          child: _buildList(chats)),
      loadedWithError: (error) => Center(child: Text(error)),
    );
  }
*/

  ListView _buildList(List<ChatModel> chats) {
    return ListView.builder(
      itemCount: chats.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            GoRouter.of(context).go(detailsPath, extra: '${label}-chatId');
          },
          onLongPress: showEditChatPromptDialog,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            margin: EdgeInsets.all(10),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      chats[index].title ?? '',
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    SizedBox(height: 10),
                    Text(
                      chats[index].desc ?? '',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void showEditChatPromptDialog() {
    //todo
  }

  final defaultChatModel = const ChatModel(
    uId: 1,
    title: 'name',
    desc: 'avatar',
    sectionId: 2,
  );

  _createChatSection(WidgetRef ref, BuildContext context) {
    final model = ref.watch(chatViewModelProvider.notifier);
    //创建新聊天会话
    bool longPressed = false;
    if (!longPressed) {
      // chatViewModel.getAllChatList();
      model.createChatSection(defaultChatModel);
    } else {
      showEditChatPromptDialog();
    }
    //跳转
  }

  _buildBody(
      WidgetRef ref, AsyncValue<List<ChatModel>> state, BuildContext context) {
    return state.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(child: Text(error.toString())),
      data: (chats) => RefreshIndicator(
          onRefresh: () async {
            ref.refresh(chatViewModelProvider);
          },
          child: _buildList(chats)),
    );
  }
}
