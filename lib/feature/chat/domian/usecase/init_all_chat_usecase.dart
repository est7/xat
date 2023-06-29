import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:xat/data/repository_impl/chat_repository_impl.dart';
import '../../../../data/source/db/global_data_base.dart';
import '../../../../lib/net/src/result.dart';
import '../../../../model/chat_model.dart';

part 'init_all_chat_usecase.g.dart';

@riverpod
class InitAllChatListUsecase extends _$InitAllChatListUsecase {
  @override
  Future<Result<List<ChatModel>>> build() async {
    final repository = ref.watch(chatRepositoryImplProvider);
    return Result.success(repository.valueOrNull ?? []);
  }
}
