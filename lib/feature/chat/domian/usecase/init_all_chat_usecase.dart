import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:xat/data/repository_impl/chat_repository_impl.dart';
import '../../../../lib/net/src/result.dart';
import '../../../../model/chat_model.dart';

part 'init_all_chat_usecase.g.dart';

@riverpod
class InitAllChatListUsecase extends _$InitAllChatListUsecase {
  @override
  Future<Result<List<ChatModel>>> build() async {
    final repository = await ref.read(chatRepositoryImplProvider.future);
    return repository;
  }
}

/*
@riverpod
class InitAllChatListUsecase extends _$InitAllChatListUsecase {
  @override
  Future<Result<List<ChatModel>>> build() async {
    // 获取到来自 chatRepositoryImplProvider 的结果，是异步的，所以使用 await
    final Result<List<ChatModel>> result = await ref.watch(chatRepositoryImplProvider.future);
    // 返回结果，如果结果为空，返回失败的Result。
    return result;
  }
}*/
