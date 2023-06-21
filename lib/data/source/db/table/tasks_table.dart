import 'package:drift/drift.dart';


//@DataClassName：这个注解用于指定生成的数据类的名称。如果你的表类的名称是 "Tasks"，
// 那么默认生成的数据类的名称将是 "Task"。
// 但是，如果你想让生成的数据类有一个特定的名称，
// 你可以使用 @DataClassName('MyTask') 来进行指定。
// 需要注意的是，生成的数据类将会被用作表示从该表中检索的行的数据对象。
@DataClassName("Task")
class TasksTable extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get name => text().withLength(min: 1, max: 50)();

  DateTimeColumn get dueDate => dateTime().nullable()();
}
