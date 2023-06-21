import 'package:drift/drift.dart';
import '../global_data_base.dart';
import '../table/tasks_table.dart';

part 'task_dao.g.dart';

// TaskDao 会被 drift 创建。
// 它包含表需要的所有必要字段。
// <GlobalDatabase> 类型注释是数据库类，会使用这个 DAO。

@DriftAccessor(tables: [TasksTable])
class TaskDao extends DatabaseAccessor<GlobalDatabase> with _$TaskDaoMixin {
  // 构造方法是必需的，这样主数据库可以创建这个对象的实例。
  TaskDao(GlobalDatabase db) : super(db);

  Future<List<Task>> getAllTasks() => select(tasksTable).get();

  Stream<List<Task>> watchAllTasks() => select(tasksTable).watch();

  Future insertTask(Task task) => into(tasksTable).insert(task);

  Future updateTask(Task task) => update(tasksTable).replace(task);

  Future deleteTask(Task task) => delete(tasksTable).delete(task);
}
