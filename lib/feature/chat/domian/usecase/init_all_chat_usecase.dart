import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:xat/data/repository_impl/chat_repository_impl.dart';
import '../../../../lib/net/src/result.dart';
import '../../../../model/chat_model.dart';

part 'init_all_chat_usecase.g.dart';

@riverpod
class InitAllChatListUsecase extends _$InitAllChatListUsecase {
  @override
  FutureOr<Result<List<ChatModel>>> build() async {
    final repository = ref.watch(chatRepositoryImplProvider).valueOrNull;
    if (repository == null) return const Result.failure();
    return Result.success(repository);
  }
}


@riverpod
class StreamUsecase extends _$StreamUsecase {
  @override
  FutureOr<Result<List<ChatModel>>> build() async {
    final repository = ref.watch(DBStreamProvider).valueOrNull;
    if (repository == null) return const Result.failure();
    return Result.success(repository);
  }
}
