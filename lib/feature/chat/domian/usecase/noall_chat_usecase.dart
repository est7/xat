import '../../../../lib/net/src/result.dart';
import '../../../../model/chat_model.dart';
import '../repository/chat_repository.dart';



class SetChatItemTopUsecase {
  final IChatRepository repository;

  SetChatItemTopUsecase({required this.repository});

  Future<Result> call() {
    return repository.getAllChatList();
  }
}
