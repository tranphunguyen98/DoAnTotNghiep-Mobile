// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../data/local/source/habit/local_diary_service.dart' as _i3;
import '../data/local/source/habit/local_habit_service.dart' as _i4;
import '../data/local/source/task/local_task_service.dart' as _i5;
import '../data/local/source/user/local_user_service.dart'
    as _i6; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String environment, _i2.EnvironmentFilter environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  gh.factory<_i3.LocalDiaryService>(() => _i3.LocalDiaryService());
  gh.factory<_i4.LocalHabitService>(() => _i4.LocalHabitService());
  gh.factory<_i5.LocalTaskService>(() => _i5.LocalTaskService());
  gh.factory<_i6.LocalUserService>(() => _i6.LocalUserService());
  return get;
}
