import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_crud_task_management/domain/entities/task.dart';
import 'package:flutter_crud_task_management/domain/repositories/task/task_repository.dart';
import 'package:flutter_crud_task_management/presentation/bloc/task/task_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'task_bloc_test.mocks.dart';

@GenerateMocks([TaskRepository])
void main() {
  late MockTaskRepository mockTaskRepository;
  late TaskBloc taskBloc;

  setUp(() {
    mockTaskRepository = MockTaskRepository();
    taskBloc = TaskBloc(mockTaskRepository);
  });

  tearDown(() {
    taskBloc.close();
  });

  final task = Task(
      title: 'test1', description: 'test1description', dueDate: DateTime.now());

  blocTest<TaskBloc, TaskState>(
    'Emits [TaskAdded, TaskLoaded] when AddTaskEvent is followed by GetTasksEvent',
    build: () {
      when(mockTaskRepository.addTask(task)).thenAnswer((_) async {
        when(mockTaskRepository.getAllTasks()).thenAnswer((_) async => [
              Task(
                  title: 'test1',
                  description: 'test1description',
                  dueDate: DateTime.now())
            ]);
      });

      return taskBloc;
    },
    act: (bloc) async {
      bloc.add(AddTaskEvent(task: task));
    },
    expect: () => [
      isA<TaskLoading>(),
      isA<TaskAdded>(),
      isA<TaskLoading>(),
      isA<TaskLoaded>()
          .having((state) => state.tasks.length, 'tasks length', 1),
    ],
    verify: (bloc) {
      verify(mockTaskRepository.addTask(task)).called(1);
      verify(mockTaskRepository.getAllTasks()).called(1);
    },
  );

  blocTest<TaskBloc, TaskState>(
    'Emits [TaskLoading, TaskError] when AddTaskEvent',
    build: () {
      when(mockTaskRepository.addTask(task))
          .thenThrow(Exception('Failed to add task'));
      return taskBloc;
    },
    act: (bloc) async {
      bloc.add(AddTaskEvent(task: task));
    },
    expect: () => [
      isA<TaskLoading>(),
      isA<TaskError>(),
    ],
    verify: (bloc) {
      verify(mockTaskRepository.addTask(task)).called(1);
    },
  );

  blocTest<TaskBloc, TaskState>(
      'Emits [TaskLoading, TaskLoaded] when GetTaskEvent is added',
      build: () {
        when(mockTaskRepository.getAllTasks()).thenAnswer((_) async => [
              Task(
                  title: 'Test Task',
                  description: 'Test Description',
                  dueDate: DateTime.now()),
              Task(
                  title: 'Test Task',
                  description: 'Test Description',
                  dueDate: DateTime.now()),
            ]);
        return taskBloc;
      },
      act: (bloc) => bloc.add(GetTaskEvent()),
      expect: () => [
            isA<TaskLoading>(),
            isA<TaskLoaded>(),
          ],
      verify: (_) {
        verify(mockTaskRepository.getAllTasks()).called(1);
      });

  blocTest<TaskBloc, TaskState>(
    'Emits [TaskLoading, TaskError] when GetTaskEvent is Error',
    build: () {
      when(mockTaskRepository.getAllTasks())
          .thenThrow(Exception('Failed to get task'));
      return taskBloc;
    },
    act: (bloc) => bloc.add(GetTaskEvent()),
    expect: () => [
      isA<TaskLoading>(),
      isA<TaskError>(),
    ],
  );

  blocTest<TaskBloc, TaskState>(
    'Emits [TaskDeleted, TaskLoaded] when DeleteTask is followed by GetTasksEvent',
    build: () {
      when(mockTaskRepository.deleteTask('test1')).thenAnswer((_) async {
        when(mockTaskRepository.getAllTasks()).thenAnswer((_) async => [
              Task(
                  title: 'test1',
                  description: 'test1description',
                  dueDate: DateTime.now())
            ]);
      });

      return taskBloc;
    },
    act: (bloc) async {
      bloc.add(DeleteTaskEvent(title: 'test1'));
    },
    expect: () => [
      isA<TaskLoading>(),
      isA<TaskDeleted>(),
      isA<TaskLoading>(),
      isA<TaskLoaded>()
          .having((state) => state.tasks.length, 'tasks length', 1),
    ],
    verify: (bloc) {
      verify(mockTaskRepository.deleteTask('test1')).called(1);
      verify(mockTaskRepository.getAllTasks()).called(1);
    },
  );

  blocTest<TaskBloc, TaskState>(
    'Emits [TaskLoading, TaskError] when DeleteTaskEvent is called',
    build: () {
      when(mockTaskRepository.deleteTask('test1'))
          .thenThrow(Exception('Failed to delete task'));
      return taskBloc;
    },
    act: (bloc) async {
      bloc.add(DeleteTaskEvent(title: 'test1'));
    },
    expect: () => [
      isA<TaskLoading>(),
      isA<TaskError>(),
    ],
    verify: (bloc) {
      verify(mockTaskRepository.deleteTask('test1')).called(1);
    },
  );

  blocTest<TaskBloc, TaskState>(
    'Emits [TaskUpdated, TaskLoaded] when TaskUpdated is followed by GetTasksEvent',
    build: () {
      when(mockTaskRepository.updateTask(1, task)).thenAnswer((_) async {
        when(mockTaskRepository.getAllTasks()).thenAnswer((_) async => [
              Task(
                  title: 'test1',
                  description: 'test1description',
                  dueDate: DateTime.now())
            ]);
      });

      return taskBloc;
    },
    act: (bloc) async {
      bloc.add(UpdateTaskEvent(index: 1, task: task));
    },
    expect: () => [
      isA<TaskLoading>(),
      isA<TaskUpdated>(),
      isA<TaskLoading>(),
      isA<TaskLoaded>()
          .having((state) => state.tasks.length, 'tasks length', 1),
    ],
    verify: (bloc) {
      verify(mockTaskRepository.updateTask(1, task)).called(1);
      verify(mockTaskRepository.getAllTasks()).called(1);
    },
  );

  blocTest<TaskBloc, TaskState>(
    'Emits [TaskLoading, TaskError] when TaskUpdatedEvent is called',
    build: () {
      when(mockTaskRepository.updateTask(1, task))
          .thenThrow(Exception('Failed to delete task'));
      return taskBloc;
    },
    act: (bloc) async {
      bloc.add(UpdateTaskEvent(index: 1, task: task));
    },
    expect: () => [
      isA<TaskLoading>(),
      isA<TaskError>(),
    ],
    verify: (bloc) {
      verify(mockTaskRepository.updateTask(1, task)).called(1);
    },
  );
}
