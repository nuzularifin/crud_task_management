import 'package:equatable/equatable.dart';
import 'package:flutter_crud_task_management/data/model/task_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'task.g.dart';

@JsonSerializable()
class Task extends Equatable {
  final String title;
  final String? description;
  final DateTime dueDate;
  final bool isCompleted;
  final TaskStatus status;

  const Task({
    required this.title,
    required this.description,
    required this.dueDate,
    this.isCompleted = false,
    this.status = TaskStatus.pending,
  });

  @override
  List<Object?> get props => [title, description, dueDate, isCompleted];

  TaskModel toTaskModel() {
    return TaskModel(
      title: title,
      description: description ?? '',
      dueDate: dueDate,
      isCompleted: isCompleted,
      status: status,
    );
  }

  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);

  Map<String, dynamic> toJson() => _$TaskToJson(this);
}
