import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:xat/data/repository_impl/chat_repository_impl.dart';
import '../../../../data/source/db/global_data_base.dart';
import '../../../../model/chat_model.dart';

part 'all_chat_usecase.g.dart';

@riverpod
class InitChatListUsecase extends _$InitChatListUsecase {
  @override
  Future<List<ChatModel>> build() async {
    final repository = ref.watch(chatRepositoryImplProvider);
    return repository.valueOrNull ?? [];
  }
}