import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:xat/feature/chat/domian/model/chat_page_state.dart';
import 'package:xat/feature/chat/domian/usecase/create_chat_usecase.dart';
import 'package:xat/feature/chat/domian/usecase/init_all_chat_usecase.dart';
import 'package:xat/feature/chat/domian/usecase/update_chat_usecase.dart';
import 'package:xat/mixins/loadable.dart';
import 'package:xat/mixins/scope.dart';
import '../../../../model/chat_model.dart';
import '../../domian/usecase/delete_chat_usecase.dart';

part 'chat_viewmodel.g.dart';

@riverpod
class ChatViewModel extends _$ChatViewModel {
  @override
  ChatState build() {
    return getChatSectionList();
  }

  ChatState getChatSectionList() {
    final result = ref.watch(initAllChatListUsecaseProvider).valueOrNull;
    if (result == null) {
      return const ChatLoading();
    }
    var chatState = result.when(
        success: (List<ChatModel> data) => ChatsLoaded(data),
        failure: (msg, code) => ChatsLoadedWithError(msg));

    return chatState;
  }

  Future<void> createChatSection(final ChatModel chatModel) async {
    var result =
        await ref.watch(createChatSectionUsecaseProvider(chatModel).future);
    //result is null will return ;
    result.failureOrNull.let((p0) => state = ChatsLoadedWithError(p0.msg));

    //success 的时候使用ChatsLoaded(state.data+model)
    /*  if (chatState is ChatsAdded) {
      if (state is ChatInitial) {
        state = ChatsLoaded([chatState.model]);
      }
      if (state is ChatsLoaded) {
        ChatsLoaded preList = chatState as ChatsLoaded;
        state =
            preList.copyWith(chatList: preList.chatList + [chatState.model]);
      }
    } else {
      state = chatState;
    }*/
  }

  Future<void> updateChatSection(final ChatModel chatModel) async {
    var result =
        await ref.watch(updateChatSectionUsecaseProvider(chatModel).future);
  }

  deleteChatSection(final int id) async {
    var result = await ref.watch(deleteChatSectionUsecaseProvider(id).future);
  }
}
