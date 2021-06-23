import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:totodo/data/model/task.dart';
import 'package:totodo/data/repository_interface/i_task_repository.dart';
import 'package:totodo/data/repository_interface/i_user_repository.dart';
import 'package:totodo/presentation/screen/profile/data_ui/item_data_static_day.dart';
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
      DateTime today = DateTime.now();
      DateTime yesterday = DateTime.now().subtract(Duration(days: 1));

      if (isSignedIn) {
        final user = await _userRepository.getUser();
        yield state.copyWith(
          loading: false,
          user: user,
          dataStatisticToday:
              await _getStatisticDayOfWeek(today.toIso8601String()),
          dataStatisticYesterday:
              await _getStatisticDayOfWeek(yesterday.toIso8601String()),
          listDataStatisticThisWeek: await _getStatisticWeek(0),
          listDataStatisticPreviousWeek: await _getStatisticWeek(1),
          completionRateToday: await _getTodayCompletionRate(),
          completionRateWeek: await _getWeekCompletionRate(),
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
        ((task.dueDate?.isEmpty ?? true) &&
            (!(task.completedDate?.isEmpty ?? true)) &&
            DateHelper.isSameDayString(task.completedDate, dateTimeStr)) ||
        (!(task.dueDate?.isEmpty ?? true) &&
            DateHelper.isSameDayString(task.dueDate, dateTimeStr)));

    final int completedTask =
        listTaskToday.where((element) => element.isCompleted).length;

    return ItemDataStatisticDay(
        completedTask: completedTask,
        allTask: listTaskToday.length,
        title: DateFormat('EEE').format(DateTime.parse(dateTimeStr)));
  }

  Future<List<ItemDataStatisticDay>> _getStatisticWeek(int subtractWeek) async {
    final allTask = await _taskRepository.getAllTask();

    final listDataStatisticWeek = await Stream.fromIterable(
            DateHelper.getListDayOfWeek(subtractWeek))
        .asyncMap((event) => _getStatisticDayOfWeek(event, allTask: allTask))
        .toList();

    return listDataStatisticWeek;
  }

  Future<List<ItemDataStatisticDay>> _getStatisticMonth(
      int subtractMonth) async {
    final allTask = await _taskRepository.getAllTask();

    final listDataStatisticWeek = await Stream.fromIterable(
            DateHelper.getListDayOfMonth(subtractMonth))
        .asyncMap((event) => _getStatisticDayOfWeek(event, allTask: allTask))
        .toList();

    return listDataStatisticWeek;
  }

  //
  // final List<ItemDataStatisticProject> _listDataStatisticProjectMockUp = const [
  //   ItemDataStatisticProject(
  //       nameProject: 'Website Marketing',
  //       totalTask: 10,
  //       completedTask: 9,
  //       projectColor: Colors.purpleAccent),
  //   ItemDataStatisticProject(
  //       nameProject: 'Mobile',
  //       totalTask: 10,
  //       completedTask: 5,
  //       projectColor: Colors.redAccent),
  //   ItemDataStatisticProject(
  //       nameProject: 'Personal Marketing',
  //       totalTask: 10,
  //       completedTask: 5,
  //       projectColor: Colors.green),
  //   ItemDataStatisticProject(
  //       nameProject: 'Learn English',
  //       totalTask: 10,
  //       completedTask: 7,
  //       projectColor: Colors.orange),
  // ];

  Future<CompletionRateData> _getTodayCompletionRate() async {
    return _getCompletionRateStatisticDayOfWeek(
        DateTime.now().toIso8601String());
  }

  Future<CompletionRateData> _getCompletionRateStatisticDayOfWeek(
      String dateTimeStr,
      {List<Task> allTask}) async {
    //TODO handle NoDate
    List<Task> _listAllTask = [];
    if (allTask == null) {
      _listAllTask = await _taskRepository.getAllTask();
    } else {
      _listAllTask.addAll(allTask);
    }

    final listTaskToday = _listAllTask.where((task) =>
        !(task.dueDate?.isEmpty ?? true) &&
        DateHelper.isSameDayString(task.dueDate, dateTimeStr));

    final int onTime = listTaskToday.where((element) {
      if (element.isCompleted && (element.completedDate?.isEmpty ?? true)) {
        log('testStatistic Data $element not correct!');
        // throw Exception('testStatistic Data $element not correct!');
      }
      return element.isCompleted &&
          !(element.completedDate?.isEmpty ?? true) &&
          (DateHelper.isSameDayString(element.dueDate, element.completedDate));
    }).length;

    final int overdue = listTaskToday.where((element) {
      if (element.isCompleted && (element.completedDate?.isEmpty ?? true)) {
        log('testStatistic Data $element not correct!');
        // throw Exception('testStatistic Data $element not correct!');
      }
      return element.isCompleted &&
          !(element.dueDate?.isEmpty ?? true) &&
          !(element.completedDate?.isEmpty ?? true) &&
          !DateHelper.isSameDayString(element.dueDate, element.completedDate);
    }).length;

    final int undated = _listAllTask
        .where((element) =>
            (element.dueDate?.isEmpty ?? true) &&
            !(element?.completedDate?.isEmpty ?? true) &&
            DateHelper.isSameDayString(dateTimeStr, element.completedDate))
        .length;

    final int uncompleted =
        listTaskToday.where((element) => !element.isCompleted).length;
    return CompletionRateData(
        overdue: overdue,
        onTime: onTime,
        undated: undated,
        uncompleted: uncompleted);
  }

  Future<CompletionRateData> _getWeekCompletionRate() async {
    final completionRateDateList =
        await Stream.fromIterable(DateHelper.getListDayOfWeek(0))
            .asyncMap((event) => _getCompletionRateStatisticDayOfWeek(event))
            .toList();

    return completionRateDateList.reduce((value, element) => value + element);
  }
}
