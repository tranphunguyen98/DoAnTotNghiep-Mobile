import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:totodo/bloc/repository_interface/i_task_repository.dart';
import 'package:totodo/bloc/repository_interface/i_user_repository.dart';
import 'package:totodo/data/entity/task.dart';
import 'package:totodo/presentation/screen/profile/data_ui/item_data_static_day.dart';
import 'package:totodo/presentation/screen/profile/data_ui/item_data_statistic_project.dart';
import 'package:totodo/utils/date_helper.dart';
import 'package:totodo/utils/util.dart';

import 'bloc.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ITaskRepository _taskRepository;
  final IUserRepository _userRepository;

  ProfileBloc(
      {@required ITaskRepository taskRepository,
      @required IUserRepository userRepository})
      : assert(taskRepository != null && userRepository != null),
        _taskRepository = taskRepository,
        _userRepository = userRepository,
        super(ProfileState.loading());

  @override
  Stream<ProfileState> mapEventToState(ProfileEvent event) async* {
    if (event is InitDataStatistic) {
      yield* _mapOpenProfileScreenToState();
    }
  }

  Stream<ProfileState> _mapOpenProfileScreenToState() async* {
    try {
      final isSignedIn = await _userRepository.isSignedIn();

      if (isSignedIn) {
        final user = await _userRepository.getUser();
        yield state.copyWith(
          loading: false,
          user: user,
          listDataStaticProject: _listDataStatisticProjectMockUp,
          dataStatisticToday:
              await _getStatisticDayOfWeek(DateTime.now().toIso8601String()),
          listDataStatisticLast7Days: await _getStatisticWeek(),
        );
      }
    } catch (error, stackTrace) {
      log('Profile Error', stackTrace);
    }
  }

  Future<ItemDataStatisticDay> _getStatisticDayOfWeek(String dateTimeStr,
      {List<Task> allTask}) async {
    //TODO handle NoDate
    List<Task> _listAllTask = [];
    if (allTask == null) {
      _listAllTask = await _taskRepository.getAllTask();
    } else {
      _listAllTask.addAll(allTask);
    }

    final listTaskToday = _listAllTask.where((task) =>
        !(task.taskDate?.isEmpty ?? true) &&
        DateHelper.isSameDayString(task.taskDate, dateTimeStr));
    final int completedTask =
        listTaskToday.where((element) => element.isCompleted).length;

    return ItemDataStatisticDay(
        completedTask: completedTask,
        allTask: listTaskToday.length,
        title: DateFormat('EEE').format(DateTime.parse(dateTimeStr)));
  }

  Future<List<ItemDataStatisticDay>> _getStatisticWeek() async {
    final listDataStatisticWeek = <ItemDataStatisticDay>[];
    final allTask = await _taskRepository.getAllTask();
    for (final day in [6, 5, 4, 3, 2, 1, 0]) {
      final item = await _getStatisticDayOfWeek(
          DateTime.now().subtract(Duration(days: day)).toIso8601String(),
          allTask: allTask);
      listDataStatisticWeek.add(item);
    }

    return listDataStatisticWeek;
  }

  final List<ItemDataStatisticProject> _listDataStatisticProjectMockUp = const [
    ItemDataStatisticProject(
        nameProject: 'Website Marketing',
        totalTask: 10,
        completedTask: 9,
        projectColor: Colors.purpleAccent),
    ItemDataStatisticProject(
        nameProject: 'Mobile',
        totalTask: 10,
        completedTask: 5,
        projectColor: Colors.redAccent),
    ItemDataStatisticProject(
        nameProject: 'Personal Marketing',
        totalTask: 10,
        completedTask: 5,
        projectColor: Colors.green),
    ItemDataStatisticProject(
        nameProject: 'Learn English',
        totalTask: 10,
        completedTask: 7,
        projectColor: Colors.orange),
  ];
}
