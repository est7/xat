import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:xat/data/repository_impl/chat_repository_impl.dart';
import '../../../../data/source/db/global_data_base.dart';
import '../../../../lib/net/src/result.dart';
import '../../../../model/chat_model.dart';

part 'create_chat_usecase.g.dart';

@riverpod
class CreateChatSectionUsecase extends _$CreateChatSectionUsecase {
  @override
  Future<Result<ChatModel>> build(ChatModel chatModel) {
    final repository = ref.read(chatRepositoryImplProvider.notifier);
    return repository.createChatItem(chatModel);
  }
}
