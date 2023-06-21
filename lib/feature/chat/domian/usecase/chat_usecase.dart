import '../../../../data/repository_impl/chat_repository.dart';
import '../../../../lib/net/src/result.dart';
import '../../../../model/chat_model.dart';

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
