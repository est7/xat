import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../model/message_model.dart';
import '../widgets/message_item.dart';

class ChatDetailPage extends StatelessWidget {
  ChatDetailPage({super.key, this.withScaffold = true});

  final bool withScaffold;

  final List<MessageModel> messages = [
    MessageModel(
        uId: 1, content: "Hello", isUser: true, timestamp: DateTime.now()),
    MessageModel(
        uId: 2,
        content: "How are you?",
        isUser: false,
        timestamp: DateTime.now()),
    MessageModel(
        uId: 3,
        content: "Fine,Thank you. And you?",
        isUser: true,
        timestamp: DateTime.now()),
    MessageModel(
        uId: 3,
        content: "I am fine.",
        isUser: false,
        timestamp: DateTime.now()),
  ];
  final _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (withScaffold) {
      return Scaffold(
        bottomNavigationBar: null,
        appBar: AppBar(
          title: const Text('Chat Screen'),
        ),
        body: _build(context),
      );
    } else {
      return Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: _build(context),
      );
    }
  }

  _build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Expanded(
            // 聊天消息列表
            child: ListView.separated(
              itemBuilder: (context, index) {
                return MessageItem(message: messages[index]);
              },
              itemCount: messages.length, // 消息数量
              separatorBuilder: (context, index) => const Divider(
                // 分割线
                height: 16,
              ),
            ),
          ),
          // 输入框
          TextField(
            controller: _textController,
            decoration: InputDecoration(
                hintText: 'Type a message', // 显示在输入框内的提示文字
                suffixIcon: IconButton(
                  onPressed: () {
                    // 这里处理发送事件
                    if (_textController.text.isNotEmpty) {
                      _sendMessage(_textController.text);
                    }
                  },
                  icon: const Icon(
                    Icons.send,
                  ),
                )),
          ),
        ],
      ),
    );
  }

  void _sendMessage(String text) {
    final message = MessageModel(
        uId: 2, content: text, isUser: true, timestamp: DateTime.now());
    messages.add(message);
    _textController.clear();
  }
}
