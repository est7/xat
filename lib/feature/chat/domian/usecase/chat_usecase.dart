import '../../../../lib/net/src/result.dart';
import '../../../../model/chat_model.dart';
import '../repository/chat_repository.dart';

class InitChatListUsecase {
  final IChatRepository repository;

  InitChatListUsecase({required this.repository});

  Future<Result<List<ChatModel>>> call() {
    return repository.getAllChatList();
  }
}

class SetChatItemTopUsecase {
  final IChatRepository repository;

  SetChatItemTopUsecase({required this.repository});

  Future<Result> call() {
    return repository.getAllChatList();
  }
}
