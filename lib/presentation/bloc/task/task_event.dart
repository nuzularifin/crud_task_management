part of 'task_bloc.dart';

class TaskEvent extends Equatable {
  const TaskEvent();

  @override
  List<Object?> get props => [];
}

class AddTaskEvent extends TaskEvent {
  final Task task;
  const AddTaskEvent({required this.task});

  @override
  List<Object?> get props => [task];
}

class GetTaskEvent extends TaskEvent {}

class UpdateTaskEvent extends TaskEvent {
  final Task task;
  final int index;

  const UpdateTaskEvent({required this.task, required this.index});

  @override
  List<Object?> get props => [task, index];
}

class DeleteTaskEvent extends TaskEvent {
  final int index;
  const DeleteTaskEvent({required this.index});

  @override
  List<Object?> get props => [index];
}
