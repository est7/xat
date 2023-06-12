import 'package:drift/drift.dart';

import '../global_data_base.dart';
import '../table/prompts_table.dart';

part 'prompt_dao.g.dart';

@DriftAccessor(tables: [PromptsTable])
class PromptDao extends DatabaseAccessor<GlobalDatabase> with _$PromptDaoMixin {
  // 构造方法是必需的，这样主数据库可以创建这个对象的实例。
  PromptDao(GlobalDatabase db) : super(db);
}
