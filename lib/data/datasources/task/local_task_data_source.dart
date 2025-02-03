import 'package:flutter_crud_task_management/data/model/task_model.dart';
import 'package:hive/hive.dart';

class LocalTaskDataSource {
  final Box<TaskModel> taskBox;

  LocalTaskDataSource({required this.taskBox});

  Future<void> addTask(TaskModel task) async {
    await taskBox.add(task);
  }

  Future<void> deleteTask(String title) async {
    final taskKey = taskBox.keys.firstWhere(
      (key) => taskBox.get(key)?.title.toLowerCase() == title.toLowerCase(),
      orElse: () => null,
    );
    await taskBox.delete(taskKey);
  }

  Future<List<TaskModel>> getAllTasks() async {
    return taskBox.values.toList();
  }

  Future<void> updateTask(int index, TaskModel task) async {
    await taskBox.putAt(index, task);
  }

  Future<List<TaskModel>> getAllTasksByTitle(String query) async {
    if (query.isEmpty || query.length < 2) {
      return taskBox.values.toList();
    } else {
      return taskBox.values
          .where((task) => task.title.toLowerCase().contains(
                query.toLowerCase(),
              ))
          .toList();
    }
  }
}
