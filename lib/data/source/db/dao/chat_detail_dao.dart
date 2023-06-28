import 'package:drift/drift.dart';
import 'package:xat/model/chat_model.dart';

import '../global_data_base.dart';
import '../table/chat_detail_table.dart';
import '../table/chats_table.dart';

part 'chat_detail_dao.g.dart';

@DriftAccessor(tables: [ChatDetailTable])
class ChatDetailDao extends DatabaseAccessor<GlobalDatabase>
    with _$ChatDetailDaoMixin {
  ChatDetailDao(super.attachedDatabase);

  Future<List<chat_detail>> getAllChat(List<ChatModel> chat) =>
      select(chatDetailTable).get();

  Future<void> insertChatItems(List<ChatModel> chats) async {
    // await into(chats).insertAllOnConflictUpdate(chats);
  }
}
