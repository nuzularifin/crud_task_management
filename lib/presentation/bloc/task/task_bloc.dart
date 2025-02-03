import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_crud_task_management/domain/repositories/task/task_repository.dart';
import '../../../domain/entities/task.dart';
import 'package:equatable/equatable.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final TaskRepository taskRepository;

  TaskBloc(this.taskRepository) : super(TaskInitial()) {
    on<AddTaskEvent>(_onAddTask);
    on<GetTaskEvent>(_onGetTask);
    on<DeleteTaskEvent>(_onDeleteTask);
    on<UpdateTaskEvent>(_onUpdateTask);
    on<SearchTaskEvent>(_onSearchTask);
  }

  void _onAddTask(AddTaskEvent event, Emitter<TaskState> emit) async {
    emit(TaskLoading());
    try {
      await taskRepository.addTask(event.task);
      emit(TaskAdded());
      add(GetTaskEvent());
    } catch (e) {
      emit(TaskError(
        message: 'Failed to add task: $e',
      ));
    }
  }

  void _onGetTask(GetTaskEvent event, Emitter<TaskState> emit) async {
    emit(TaskLoading());
    try {
      final tasks = await taskRepository.getAllTasks();
      if (tasks.isEmpty) {
        emit(TaskEmpty());
      } else {
        emit(TaskLoaded(tasks: tasks));
      }
    } catch (e) {
      emit(TaskError(
        message: 'Failed to get task: $e',
      ));
    }
  }

  void _onDeleteTask(DeleteTaskEvent event, Emitter<TaskState> emit) async {
    emit(TaskLoading());
    try {
      await taskRepository.deleteTask(event.title);
      emit(TaskDeleted());
      add(GetTaskEvent());
    } catch (e) {
      emit(TaskError(
        message: 'Failed to delete task: $e',
      ));
    }
  }

  void _onUpdateTask(UpdateTaskEvent event, Emitter<TaskState> emit) async {
    emit(TaskLoading());
    try {
      await taskRepository.updateTask(event.index, event.task);
      emit(TaskUpdated());
      add(GetTaskEvent());
    } catch (e) {
      emit(TaskError(
        message: 'Failed to update task: $e',
      ));
    }
  }

  void _onSearchTask(SearchTaskEvent event, Emitter<TaskState> emit) async {
    emit(TaskLoading());
    try {
      final tasks = await taskRepository.getAllTasksByTitle(event.query);
      emit(TaskLoaded(tasks: tasks));
    } catch (e) {
      emit(TaskError(
        message: 'Failed to search task: $e',
      ));
    }
  }
}
