import '../../feature/chat/domian/repository/chat_repository.dart';
import '../../lib/net/src/result.dart';
import '../../model/chat_model.dart';


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
