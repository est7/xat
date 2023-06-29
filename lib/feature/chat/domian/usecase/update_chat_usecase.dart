import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:xat/data/repository_impl/chat_repository_impl.dart';
import '../../../../data/source/db/global_data_base.dart';
import '../../../../lib/net/src/result.dart';
import '../../../../model/chat_model.dart';

part 'update_chat_usecase.g.dart';

@riverpod
class UpdateChatSectionUsecase extends _$UpdateChatSectionUsecase {
  @override
  Future<Result> build(ChatModel chatModel) async {
    final repository = ref.read(chatRepositoryImplProvider.notifier);
    var result = await repository.updateChatItem(chatModel);
    return result;
  }
}
