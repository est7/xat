import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
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
  Future<List<ChatModel>> build() {
    return _getAllChatList();
  }

  Result<List> _getAllChatList() {
    final chatsAsyncValue = ref.watch(initAllChatListUsecaseProvider);
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
    state = const AsyncLoading();
    var a =  ref.watch(deleteChatSectionUsecaseProvider(id).future);
    await AsyncValue.guard(a);
  }
}
