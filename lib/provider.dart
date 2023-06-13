
// 全局的provider
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:xat/data/repository/prompt_repository.dart';

import 'core/log_util.dart';
import 'core/toast_util.dart';
import 'data/db/dao/chat_dao.dart';
import 'data/db/dao/prompt_dao.dart';
import 'data/db/dao/task_dao.dart';
import 'data/db/global_data_base.dart';

final myLogger = MyLog();
final myToast = MyToast();


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

//可以在其他地方重用 promptRepositoryProvider，
// 并且如果 PromptRepository 需要在初始化时接受一些参数，你只需要在一个地方修改即可。
final promptRepositoryProvider = Provider.autoDispose<IPromptRepository>((ref) {
  return PromptRepository();
});


