import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:xat/feature/chat/domian/usecase/create_chat_usecase.dart';
import 'package:xat/feature/chat/domian/usecase/init_all_chat_usecase.dart';
import 'package:xat/feature/chat/domian/usecase/update_chat_usecase.dart';

import '../../../../model/chat_model.dart';
import '../../domian/model/chat_page_state.dart';
import '../../domian/usecase/delete_chat_usecase.dart';

part 'chat_viewmodel.g.dart';

@riverpod
class ChatViewModel extends _$ChatViewModel {
  @override
  ChatState build() {
    return const ChatState.initial();
  }

  Future<void> getAllChatList() async {
    var result = await ref.read(initAllChatListUsecaseProvider.future);
    result.when(
      success: (data) => state = ChatState.loaded(data),
      failure: (msg, code) =>
          state = const ChatState.loadedWithError("failed get chat list"),
    );
  }

  Future<void> createChatSection(final ChatModel chatModel) async {
    return ref.watch(createChatSectionUsecaseProvider(chatModel).future);
  }

  Future<void> updateChatSection(final ChatModel chatModel) async {
    return ref.watch(updateChatSectionUsecaseProvider(chatModel).future);
  }

  Future<void> deleteChatSection(final int id) async {
    return ref.watch(deleteChatSectionUsecaseProvider(id).future);
  }
}
