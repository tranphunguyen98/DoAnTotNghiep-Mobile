import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';
import 'package:totodo/bloc/repository_interface/i_user_repository.dart';
import 'package:totodo/data/local/cache_user_data_source_impl.dart';
import 'package:totodo/data/local/local_user_service.dart';
import 'package:totodo/data/remote/remote_user_data_source_impl.dart';
import 'package:totodo/data/remote/remote_user_service.dart';
import 'package:totodo/data/repositories/local_user_data_source.dart';
import 'package:totodo/data/repositories/remote_user_data_source.dart';
import 'package:totodo/data/repositories/user_repository_impl.dart';

import 'injection.config.dart';

final getIt = GetIt.instance;

@InjectableInit()
Future<void> configureDependencies() async {
  $initGetIt(getIt);
  getIt.registerLazySingleton<DateFormat>(() => DateFormat('MMM yyyy'));
  getIt.registerSingleton<Dio>(Dio());

  getIt.registerLazySingleton<RemoteUserService>(
      () => RemoteUserService(getIt.get<Dio>()));

  getIt.registerLazySingleton<RemoteUserDataSource>(
      () => RemoteUserDataSourceImpl(getIt.get<RemoteUserService>()));

  getIt.registerLazySingleton<LocalUserDataSource>(
      () => LocalUserDataSourceImplement(getIt.get<LocalUserService>()));

  getIt.registerLazySingleton<IUserRepository>(() => UserRepositoryImpl(
      getIt.get<RemoteUserDataSource>(), getIt.get<LocalUserDataSource>()));
}
