import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:xat/data/repository_impl/chat_repository_impl.dart';
import '../../../../data/source/db/global_data_base.dart';
import '../../../../model/chat_model.dart';

part 'create_chat_usecase.g.dart';

@riverpod
class CreateChatListUsecase extends _$CreateChatListUsecase {
  @override
  Future<void> build() async {
    final repository = ref.read(chatRepositoryImplProvider);
    return repository.?? [];
  }
}