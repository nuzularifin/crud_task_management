import 'package:dio/dio.dart';
import 'package:flutter_crud_task_management/data/datasources/login/remote_login_data_source.dart';
import 'package:flutter_crud_task_management/data/datasources/task/local_task_data_source.dart';
import 'package:flutter_crud_task_management/data/model/task_model.dart';
import 'package:flutter_crud_task_management/data/repositories/login/login_repository_impl.dart';
import 'package:flutter_crud_task_management/data/repositories/task/task_repository_impl.dart';
import 'package:flutter_crud_task_management/domain/repositories/login/login_repository.dart';
import 'package:flutter_crud_task_management/domain/repositories/task/task_repository.dart';
import 'package:flutter_crud_task_management/presentation/bloc/login/login_bloc.dart';
import 'package:flutter_crud_task_management/presentation/bloc/task/task_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

final sl = GetIt.instance;

Future<void> initializeDepedencies() async {
  final appDocumentDir = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);
  Hive.registerAdapter(TaskModelAdapter());
  Hive.registerAdapter(TaskStatusAdapter());

  // Hive
  final taskBox = await Hive.openBox<TaskModel>('tasks');
  sl.registerLazySingleton<Box<TaskModel>>(() => taskBox);

  // dio
  sl.registerFactory(() => Dio());

  // data sources
  sl.registerSingleton<RemoteLoginDataSource>(RemoteLoginDataSource());
  sl.registerLazySingleton<LocalTaskDataSource>(
      () => LocalTaskDataSource(taskBox: Hive.box('tasks')));

  // repositories
  sl.registerLazySingleton<LoginRepository>(() => LoginRepositoryImpl(
        remoteLoginDataSource: sl(),
      ));
  sl.registerLazySingleton<TaskRepository>(() => TaskRepositoryImpl(
        localTaskDataSource: sl.get(),
      ));

  // bloc
  sl.registerFactory(() => LoginBloc(sl()));
  sl.registerFactory(() => TaskBloc(sl()));
}
