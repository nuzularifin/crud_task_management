import 'package:flutter_crud_task_management/domain/entities/task.dart';

abstract class TaskRepository {
  Future<void> addTask(Task task);
  Future<List<Task>> getAllTasks();
  Future<void> updateTask(int index, Task task);
  Future<void> deleteTask(String title);
  Future<List<Task>> getAllTasksByTitle(String query);
}
