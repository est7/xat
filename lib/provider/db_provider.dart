import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../data/db/dao/chat_dao.dart';
import '../data/db/dao/prompt_dao.dart';
import '../data/db/dao/task_dao.dart';
import '../data/db/global_data_base.dart';

/// 数据库
final gDB = Provider((ref) {
  return GlobalDatabase();
});

final chatDaoProvider = Provider((ref) {
  final db = ref.watch(gDB);
  return ChatDao(db);
});

final promptDaoProvider = Provider((ref) {
  final db = ref.watch(gDB);
  return PromptDao(db);
});

final taskDaoProvider = Provider((ref) {
  final db = ref.watch(gDB);
  return TaskDao(db);
});