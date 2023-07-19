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
  Stream<List<ChatModel>> build() {
    Stream<List<ChatEntity>> allChatList = chatListDao.getAllChatListStream();
    allChatList.listen((event) {
      print(event);
    });
    return allChatList.map(ChatMapper.transformToModelList);
  }

  @override
  Future<Result<ChatModel>> createChatItem(ChatModel chatModel) async {
    var chatsTableCompanion = ChatsTableCompanion.insert(
        name: chatModel.title!, description: chatModel.desc!);
    var rowId = await chatListDao.insertChatItem(chatsTableCompanion);
    return await _getChatItemById(rowId);
  }

  @override
  Future<Result<ChatModel>> deleteChatItemById(num uId) async {
    return Result.failure();
  }

  @override
  Future<Result<List<ChatModel>>> getAllChatList() async {
    var allChatList = await chatListDao.getAllChatList();
    return Result.success(ChatMapper.transformToModelList(allChatList));
  }

  @override
  Future<Result<ChatModel>> updateChatItem(ChatModel chatModel) async {
    return const Result.failure();
  }

  Future<Result<ChatModel>> _getChatItemById(int rowId) {
    return chatListDao.getChatItemById(rowId).then((value) {
      return Result.success(ChatMapper.transformToModel(value));
    }).catchError((error) {
      return const Result.failure(msg: '没有该 Chat Item', code: -1);
    });
  }
}
