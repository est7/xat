import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:xat/data/repository_impl/chat_repository_impl.dart';
import '../../../../data/source/db/global_data_base.dart';
import '../../../../lib/net/src/result.dart';
import '../../../../model/chat_model.dart';

part 'delete_chat_usecase.g.dart';

@riverpod
class DeleteChatSectionUsecase extends _$DeleteChatSectionUsecase {
  @override
  Future<Result> build(int uId) async {
    final repository = ref.read(chatRepositoryImplProvider.notifier);
    var result = await repository.deleteChatItemById(uId);
    return result;
  }
}
