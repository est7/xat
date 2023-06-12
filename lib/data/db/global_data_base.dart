import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:xat/data/db/table/chats_table.dart';
import 'package:xat/data/db/table/prompts_table.dart';
import 'package:xat/data/db/table/tasks_table.dart';

import 'dao/chat_dao.dart';
import 'dao/prompt_dao.dart';
import 'dao/task_dao.dart';

part 'global_data_base.g.dart';

@DriftDatabase(
    tables: [ChatsTable, PromptsTable, TasksTable],
    daos: [ChatDao, PromptDao, TaskDao])
class GlobalDatabase extends _$GlobalDatabase {
  GlobalDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase(file);
  });
}
