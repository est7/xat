import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../model/chat_model.dart';
import '../../../../widgets/position_retained_scrollphysics.dart';
import '../viewmodels/chat_viewmodel.dart';

class ChatPage extends HookConsumerWidget {
  ChatPage({
    required this.label,
    required this.detailsPath,
    super.key,
  });

  int number = 1;

  /// The label
  final String label;

  /// The path to the detail page
  final String detailsPath;
  ScrollController controller = ScrollController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chatViewModel = ref.read(chatViewModelProvider.notifier);
    useEffect(() {
      // chatViewModel.getChatSectionList();
      // 下面这行返回一个 cleanup 函数，当组件卸载时会执行这个函数。
      // 如果你没有需要在卸载时执行的操作，就直接返回空函数即可。
      // 返回一个 cleanup 函数，在组件卸载时取消订阅
      return () {};
    }, []); // 依赖列表为空，说明这个 effect 只在组件挂载时执行一次。
    return Scaffold(
      appBar: AppBar(
        title: Text(label),
      ),
      body: _buildBody(ref, context),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _createChatSection(ref, context);
        },
        tooltip: 'create_chat',
        child: const Icon(Icons.add),
      ),
    );
  }

  ListView _buildList(List<ChatModel> chats) {
    return ListView.builder(
      itemCount: chats.length,
      controller: controller,
      physics: const PositionRetainedScrollPhysics(),
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

  _createChatSection(WidgetRef ref, BuildContext context) {
    final model = ref.read(chatViewModelProvider.notifier);
    //创建新聊天会话
    bool longPressed = false;
    if (!longPressed) {
      var defaultChatModel = ChatModel(
        uId: 1,
        title: getName().toString(),
        desc: 'avatar',
        sectionId: 2,
      );
      model.createChatSection(defaultChatModel);
    } else {
      showEditChatPromptDialog();
    }
    //跳转
  }

  _buildBody(WidgetRef ref, BuildContext context) {
    final data = ref.watch(chatViewModelProvider);
    return data.when(
      initial: () => const Center(child: CircularProgressIndicator()),
      loading: () => const Center(child: CircularProgressIndicator()),
      loaded: (chatList) {
        return RefreshIndicator(
            onRefresh: () async {
              ref.refresh(chatViewModelProvider);
            },
            child: _buildList(chatList));
      },
      loadedWithError: (message) => Center(child: Text(message.toString())),
      add: (ChatModel model) {},
    );
  }

  int getName() {
    return number++;
  }
}
