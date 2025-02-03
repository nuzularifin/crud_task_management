part of 'task_bloc.dart';

abstract class TaskState extends Equatable {
  const TaskState();

  @override
  List<Object?> get props => [];
}

class TaskInitial extends TaskState {}

class TaskLoading extends TaskState {}

class TaskEmpty extends TaskState {}

class TaskLoaded extends TaskState {
  final List<Task> tasks;

  const TaskLoaded({required this.tasks});

  @override
  List<Object?> get props => [tasks];
}

class TaskAdded extends TaskState {}

class TaskUpdated extends TaskState {}

class TaskDeleted extends TaskState {}

class TaskError extends TaskState {
  final String message;

  TaskError({required this.message});

  @override
  List<Object?> get props => [message];
}
