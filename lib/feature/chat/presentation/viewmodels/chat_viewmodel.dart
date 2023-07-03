import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:xat/feature/chat/domian/model/chat_page_state.dart';
import 'package:xat/feature/chat/domian/usecase/create_chat_usecase.dart';
import 'package:xat/feature/chat/domian/usecase/init_all_chat_usecase.dart';
import 'package:xat/feature/chat/domian/usecase/update_chat_usecase.dart';

import '../../../../lib/net/src/result.dart';
import '../../../../model/chat_model.dart';
import '../../domian/usecase/delete_chat_usecase.dart';

part 'chat_viewmodel.g.dart';

@riverpod
class ChatViewModel extends _$ChatViewModel {
  @override
  FutureOr<ChatState> build() async {
    final result = ref.watch(initAllChatListUsecaseProvider).valueOrNull;
    if (result == null) return const ChatState.loadedWithError("Error");
    var chatState = result.when(
        success: (List<ChatModel> data) => ChatsLoaded(data),
        failure: (msg, code) => ChatsLoadedWithError(msg));
    return chatState;
  }

  Future<Result<ChatModel>> createChatSection(final ChatModel chatModel) async {
    Future<Result<ChatModel>> result =
        ref.watch(createChatSectionUsecaseProvider(chatModel).future);
    return result;
  }

  Future<Result> updateChatSection(final ChatModel chatModel) {
    Future<Result> result =
        ref.watch(updateChatSectionUsecaseProvider(chatModel).future);
    return result;
  }

  deleteChatSection(final int id) async {
    var a = ref.watch(deleteChatSectionUsecaseProvider(id).future);
  }
}
