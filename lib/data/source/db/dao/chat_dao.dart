import 'package:drift/drift.dart';
import 'package:xat/model/chat_model.dart';

import '../global_data_base.dart';
import '../table/chats_table.dart';

part 'chat_dao.g.dart';

@DriftAccessor(tables: [ChatsTable])
class ChatDao extends DatabaseAccessor<GlobalDatabase> with _$ChatDaoMixin {
  ChatDao(super.attachedDatabase);

  Future<void> insertChatItem(List<ChatModel> chat) async {
    // await into(chat).insertAllOnConflictUpdate(chat);
  }

  Future<void> insertChatItems(List<ChatModel> chats) async {
    // await into(chats).insertAllOnConflictUpdate(chats);
  }
}
