import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../prompt/domian/repository/prompt_repository.dart';
import '../../domian/model/chat_page_state.dart';
import '../../domian/repository/chat_repository.dart';
import '../../domian/usecase/chat_usecase.dart';

class ChatViewModel extends StateNotifier<ChatState> {
  final InitChatListUsecase _initChatListUsecase;
  final SetChatItemTopUsecase _setChatItemTopUsecase;

  ChatViewModel({
    required InitChatListUsecase initChatListUsecase,
    required SetChatItemTopUsecase setChatItemTopUsecase,
  })  : _initChatListUsecase = initChatListUsecase,
        _setChatItemTopUsecase = setChatItemTopUsecase,
        super(const ChatInitial());

  Future<void> getAllChatList() async {
    var result = await _initChatListUsecase.call();
    result.when(
      success: (data) => state = ChatState.loaded(data),
      failure: (msg, code) =>
          state = const ChatState.loadedWithError("failed get chat list"),
    );
  }




}

final chatViewModelProvider =
    StateNotifierProvider<ChatViewModel, ChatState>((ref) {
  final chatRepository = ref.read(chatRepositoryProvider);
  return ChatViewModel(
      initChatListUsecase: InitChatListUsecase(repository: chatRepository),
      setChatItemTopUsecase: SetChatItemTopUsecase(repository: chatRepository));
});
