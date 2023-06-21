import 'package:drift/drift.dart';

@DataClassName("prompt")
class PromptsTable extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get name => text().withLength(min: 1, max: 50)();

  TextColumn get description => text().withLength(min: 1, max: 20000)();

  DateTimeColumn get dueDate => dateTime().nullable()();
}
