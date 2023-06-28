import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:xat/data/entity/chat_entity.dart';
import 'package:xat/data/mapper/chat.dart';
import 'package:xat/provider/db_provider.dart';

import '../../feature/chat/domian/repository/chat_repository.dart';
import '../../lib/net/src/result.dart';
import '../../model/chat_model.dart';
import '../source/db/global_data_base.dart';

part 'chat_repository_impl.g.dart';

@riverpod
class ChatRepositoryImpl extends _$ChatRepositoryImpl
    implements IChatRepository {
  late final chatListDao = ref.watch(chatDaoProvider);

  @override
  Future<List<ChatModel>> build() async {
    var allChatList = await chatListDao.getAllChatList();
    return ChatMapper.transformToModelList(allChatList);
  }

  @override
  Future<bool> createChatItem() {
    return Future.value(true);
  }

  @override
  Future<bool> deleteChatItemById(num uId) {
    return Future.value(true);
  }

  @override
  Future<Result<List<ChatModel>>> getAllChatList() async {
    var allChatList = await chatListDao.getAllChatList();
    return Result.success(ChatMapper.transformToModelList(allChatList));
  }

  @override
  Future<bool> updateChatItem() {
    return Future.value(true);
  }
}
