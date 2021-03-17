import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';

import '../bloc/label/bloc.dart';
import '../bloc/repository_interface/i_task_repository.dart';
import '../bloc/repository_interface/i_user_repository.dart';
import '../bloc/section/bloc.dart';
import '../bloc/submit_task/bloc.dart';
import '../bloc/task/bloc.dart';
import '../data/data_source/task/local_task_data_source.dart';
import '../data/data_source/task/remote_task_data_source.dart';
import '../data/data_source/user/local_user_data_source.dart';
import '../data/data_source/user/remote_user_data_source.dart';
import '../data/local/source/task/cache_task_data_source_impl.dart';
import '../data/local/source/task/local_task_service.dart';
import '../data/local/source/user/cache_user_data_source_impl.dart';
import '../data/local/source/user/local_user_service.dart';
import '../data/remote/task/remote_task_data_source_impl.dart';
import '../data/remote/task/remote_task_service.dart';
import '../data/remote/user/remote_user_data_source_impl.dart';
import '../data/remote/user/remote_user_service.dart';
import '../data/repositories/task_repository_impl.dart';
import '../data/repositories/user_repository_impl.dart';
import 'injection.config.dart';

final getIt = GetIt.instance;

@InjectableInit()
Future<void> configureDependencies() async {
  $initGetIt(getIt);

  getIt.registerLazySingleton<DateFormat>(() => DateFormat('MMM yyyy'));
  getIt.registerSingleton<Logger>(Logger());
  getIt.registerSingleton<Dio>(Dio());

  // User
  getIt.registerLazySingleton<RemoteUserService>(
      () => RemoteUserService(getIt.get<Dio>()));

  getIt.registerLazySingleton<RemoteUserDataSource>(
      () => RemoteUserDataSourceImpl(getIt.get<RemoteUserService>()));

  getIt.registerLazySingleton<LocalUserDataSource>(
      () => LocalUserDataSourceImplement(getIt.get<LocalUserService>()));

  getIt.registerLazySingleton<IUserRepository>(() => UserRepositoryImpl(
      getIt.get<RemoteUserDataSource>(), getIt.get<LocalUserDataSource>()));

  // Task
  getIt.registerLazySingleton<RemoteTaskService>(
      () => RemoteTaskService(getIt.get<Dio>()));

  getIt.registerLazySingleton<RemoteTaskDataSource>(
      () => RemoteTaskDataSourceImpl(getIt.get<RemoteTaskService>()));

  getIt.registerLazySingleton<LocalTaskDataSource>(
      () => LocalTaskDataSourceImplement(getIt.get<LocalTaskService>()));

  getIt.registerLazySingleton<ITaskRepository>(() => TaskRepositoryImpl(
      getIt.get<RemoteTaskDataSource>(), getIt.get<LocalTaskDataSource>()));

  getIt.registerLazySingleton<TaskBloc>(
      () => TaskBloc(taskRepository: getIt.get<ITaskRepository>()));

  getIt.registerLazySingleton<TaskSubmitBloc>(
      () => TaskSubmitBloc(taskRepository: getIt.get<ITaskRepository>()));

  // Project

  getIt.registerLazySingleton<AddLabelBloc>(
      () => AddLabelBloc(taskRepository: getIt.get<ITaskRepository>()));

  getIt.registerLazySingleton<AddSectionBloc>(
      () => AddSectionBloc(taskRepository: getIt.get<ITaskRepository>()));
}
