// Prompt States
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../model/chat_model.dart';

part 'chat_page_state.freezed.dart';

@freezed
abstract class ChatState with _$ChatState {
  const factory ChatState.initial() = ChatInitial;

  const factory ChatState.loading() = ChatLoading;

  const factory ChatState.loaded(List<ChatModel> chatList) = ChatsLoaded;

  const factory ChatState.add(ChatModel model) = ChatsAdded;

  const factory ChatState.loadedWithError(String message) =
      ChatsLoadedWithError;
}
