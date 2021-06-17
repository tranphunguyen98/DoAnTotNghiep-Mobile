import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:totodo/bloc/habit/bloc.dart';
import 'package:totodo/bloc/home/home_bloc.dart';
import 'package:totodo/data/data_source/habit/local_habit_data_source.dart';
import 'package:totodo/data/data_source/habit/remote_habit_data_source.dart';
import 'package:totodo/data/data_source/task/local_task_data_source.dart';
import 'package:totodo/data/data_source/task/remote_task_data_source.dart';
import 'package:totodo/data/data_source/user/local_user_data_source.dart';
import 'package:totodo/data/data_source/user/remote_user_data_source.dart';
import 'package:totodo/data/local/mapper/local_task_mapper.dart';
import 'package:totodo/data/local/source/habit/cache_habit_data_source_impl.dart';
import 'package:totodo/data/local/source/habit/local_habit_service.dart';
import 'package:totodo/data/local/source/task/cache_task_data_source_impl.dart';
import 'package:totodo/data/local/source/task/local_task_service.dart';
import 'package:totodo/data/local/source/user/cache_user_data_source_impl.dart';
import 'package:totodo/data/local/source/user/local_user_service.dart';
import 'package:totodo/data/remote/source/habit/remote_habit_data_source_impl.dart';
import 'package:totodo/data/remote/source/habit/remote_habit_service.dart';
import 'package:totodo/data/remote/source/task/remote_task_data_source_impl.dart';
import 'package:totodo/data/remote/source/task/remote_task_service.dart';
import 'package:totodo/data/remote/source/user/remote_user_data_source_impl.dart';
import 'package:totodo/data/remote/source/user/remote_user_service.dart';
import 'package:totodo/data/repository_implement/habit_repository_impl.dart';
import 'package:totodo/data/repository_implement/task_repository_impl.dart';
import 'package:totodo/data/repository_implement/user_repository_impl.dart';
import 'package:totodo/data/repository_interface/i_habit_repository.dart';
import 'package:totodo/data/repository_interface/i_task_repository.dart';
import 'package:totodo/data/repository_interface/i_user_repository.dart';

import 'injection.config.dart';

final getIt = GetIt.instance;

@InjectableInit()
Future<void> configureDependencies() async {
  $initGetIt(getIt);

  const String kBaseUrl = 'https://personal-task-management-be.herokuapp.com/';
  // const String kBaseUrl = 'http://192.168.43.26:3006/';
  // const String kBaseUrl = 'http://192.168.1.3:3006/';

  getIt.registerLazySingleton<DateFormat>(() => DateFormat('MMM yyyy'));
  getIt.registerSingleton<Logger>(Logger());
  getIt.registerSingleton<Dio>(
      Dio(BaseOptions(followRedirects: false, maxRedirects: 0)));

  // User
  getIt.registerLazySingleton<RemoteUserService>(
    () => RemoteUserService(getIt.get<Dio>(), baseUrl: kBaseUrl),
  );

  getIt.registerLazySingleton<RemoteUserDataSource>(
      () => RemoteUserDataSourceImpl(getIt.get<RemoteUserService>()));

  getIt.registerLazySingleton<LocalUserDataSource>(
      () => LocalUserDataSourceImplement(getIt.get<LocalUserService>()));

  getIt.registerLazySingleton<IUserRepository>(() => UserRepositoryImpl(
      getIt.get<RemoteUserDataSource>(), getIt.get<LocalUserDataSource>()));

  // Task
  getIt.registerLazySingleton<RemoteTaskService>(
      () => RemoteTaskService(getIt.get<Dio>(), baseUrl: kBaseUrl));

  getIt.registerLazySingleton<RemoteTaskDataSource>(
      () => RemoteTaskDataSourceImpl(getIt.get<RemoteTaskService>()));

  getIt.registerLazySingleton<LocalTaskDataSource>(
      () => LocalTaskDataSourceImplement(getIt.get<LocalTaskService>()));

  getIt.registerLazySingleton<LocalTaskMapper>(() => LocalTaskMapper());

  getIt.registerLazySingleton<ITaskRepository>(() => TaskRepositoryImpl(
        getIt.get<RemoteTaskDataSource>(),
        getIt.get<LocalTaskDataSource>(),
        getIt.get<LocalUserDataSource>(),
        getIt.get<RemoteUserDataSource>(),
        getIt.get<LocalTaskMapper>(),
      ));

  // Habit
  getIt.registerLazySingleton<RemoteHabitService>(
      () => RemoteHabitService(getIt.get<Dio>()));

  getIt.registerLazySingleton<RemoteHabitDataSource>(
      () => RemoteHabitDataSourceImpl(getIt.get<RemoteHabitService>()));

  getIt.registerLazySingleton<LocalHabitDataSource>(
      () => LocalHabitDataSourceImplement(getIt.get<LocalHabitService>()));

  getIt.registerLazySingleton<IHabitRepository>(() => HabitRepositoryImpl(
      getIt.get<RemoteHabitDataSource>(), getIt.get<LocalHabitDataSource>()));

  getIt.registerLazySingleton<HomeBloc>(() => HomeBloc(
      taskRepository: getIt.get<ITaskRepository>(),
      userRepository: getIt.get<IUserRepository>()));

  getIt.registerLazySingleton<HabitBloc>(
      () => HabitBloc(habitRepository: getIt.get<IHabitRepository>()));
}
