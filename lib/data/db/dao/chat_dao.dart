import 'package:drift/drift.dart';
import 'package:xat/data/db/table/chats_table.dart';

import '../global_data_base.dart';

part 'chat_dao.g.dart';

@DriftAccessor(tables: [ChatsTable])
class ChatDao extends DatabaseAccessor<GlobalDatabase> with _$ChatDaoMixin {
  ChatDao(super.attachedDatabase);
}
