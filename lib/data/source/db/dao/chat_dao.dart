import 'package:drift/drift.dart';
import 'package:xat/data/entity/chat_entity.dart';

import '../global_data_base.dart';
import '../table/chats_table.dart';

part 'chat_dao.g.dart';

/**
 * https://juejin.cn/post/7033548047359410184
 * 学习使用 drfit api 进行 CURD
 */
@DriftAccessor(tables: [ChatsTable])
class ChatDao extends DatabaseAccessor<GlobalDatabase> with _$ChatDaoMixin {
  ChatDao(super.attachedDatabase);

  Future<List<chat>> getAllChatList() => select(chatsTable).get();

  Future<int> insertChatItem(ChatsTableCompanion chat) async {
    return await into(chatsTable).insert(chat);
  }

  Future<void> insertChatItems(List<ChatsTableCompanion> chats) async {
    return batch((batch) {
      batch.insertAll(chatsTable, chats);
    });
  }

  Future<void> deleteChatItem(int id) async {
    await (delete(chatsTable)..where((chat) => chat.id.equals(id))).go();
  }

  Future<ChatEntity> getChatItemById(int id) async {
    return (select(chatsTable)..where((chat) => chat.id.equals(id)))
        .getSingle();
  }

/*
  Future<List<ChatEntity>> searchEntity(String keyword) {
    // assume that an entry is important if it has the string "important" somewhere in its content
    final hasKeyWordTitle = chatsTable.name.like(keyword);

    return select(chatsTable).addColumns([hasKeyWordTitle]).map((row) {
      final entry = row.readTable(chatsTable);
      final entryHasKeyWord = row.read(hasKeyWordTitle);

      return null
    }).get();
  }
*/
}
