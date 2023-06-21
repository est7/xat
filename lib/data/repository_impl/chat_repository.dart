import '../../lib/net/src/result.dart';
import '../../model/chat_model.dart';

abstract class IChatRepository {
  Future<Result<List<ChatModel>>> getAllChatList();

  Future<bool> deleteChatItemById(num uId);

  Future<bool> createChatItem();

  Future<bool> updateChatItem();
}

class ChatRepository implements IChatRepository {
  @override
  Future<bool> createChatItem() {
    return Future.value(true);
  }

  @override
  Future<bool> deleteChatItemById(num uId) {
    return Future.value(true);
  }

  @override
  Future<Result<List<ChatModel>>> getAllChatList() {
    return Future.value(const Result.failure(code: 400, msg: 'msg'));
  }

  @override
  Future<bool> updateChatItem() {
    return Future.value(true);
  }
}
