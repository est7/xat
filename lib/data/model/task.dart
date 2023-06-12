class Task{
  int id;
  String name;
  DateTime dueDate;

  Task({required this.id, required this.name, required this.dueDate});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'dueDate': dueDate,
    };
  }

  @override
  String toString() {
    return 'Task{id: $id, name: $name, dueDate: $dueDate}';
  }
}
