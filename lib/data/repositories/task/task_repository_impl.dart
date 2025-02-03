import 'package:flutter_crud_task_management/data/datasources/task/local_task_data_source.dart';
import 'package:flutter_crud_task_management/domain/entities/task.dart';
import 'package:flutter_crud_task_management/domain/repositories/task/task_repository.dart';

class TaskRepositoryImpl implements TaskRepository {
  final LocalTaskDataSource localTaskDataSource;

  TaskRepositoryImpl({required this.localTaskDataSource});

  @override
  Future<void> addTask(Task task) async {
    await localTaskDataSource.addTask(task.toTaskModel());
  }

  @override
  Future<void> deleteTask(String title) async {
    await localTaskDataSource.deleteTask(title);
  }

  @override
  Future<List<Task>> getAllTasks() async {
    final tasks = await localTaskDataSource.getAllTasks();
    return tasks
        .map((model) => Task(
            title: model.title,
            description: model.description,
            dueDate: model.dueDate))
        .toList();
  }

  @override
  Future<void> updateTask(int index, Task task) async {
    await localTaskDataSource.updateTask(index, task.toTaskModel());
  }

  @override
  Future<List<Task>> getAllTasksByTitle(String query) async {
    final result = await localTaskDataSource.getAllTasksByTitle(query);
    return result
        .map((model) => Task(
            title: model.title,
            description: model.description,
            dueDate: model.dueDate))
        .toList();
  }
}
