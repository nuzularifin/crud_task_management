import 'package:hive/hive.dart';

part 'task_model.g.dart';

@HiveType(typeId: 0)
class TaskModel extends HiveObject {
  @HiveField(0)
  String title;

  @HiveField(1)
  String description;

  @HiveField(2)
  DateTime dueDate;

  @HiveField(3)
  bool isCompleted = false;

  @HiveField(4)
  TaskStatus status;

  TaskModel(
      {required this.title,
      required this.description,
      required this.dueDate,
      required this.isCompleted,
      required this.status});
  // Initializing a new task;
}

@HiveType(typeId: 1)
enum TaskStatus {
  @HiveField(0)
  pending,
  @HiveField(1)
  inProgress,
  @HiveField(2)
  completed,
}
