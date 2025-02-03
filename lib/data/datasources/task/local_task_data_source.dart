import 'package:flutter_crud_task_management/data/model/task_model.dart';
import 'package:hive/hive.dart';

class LocalTaskDataSource {
  final Box<TaskModel> taskBox;

  LocalTaskDataSource({required this.taskBox});

  Future<void> addTask(TaskModel task) async {
    await taskBox.add(task);
  }

  Future<void> deleteTask(int index) async {
    await taskBox.deleteAt(index);
  }

  Future<List<TaskModel>> getAllTasks() async {
    return taskBox.values.toList();
  }

  Future<void> updateTask(int index, TaskModel task) async {
    await taskBox.putAt(index, task);
  }
}
