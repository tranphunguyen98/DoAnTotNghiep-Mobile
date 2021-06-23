import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:totodo/data/model/user.dart';
import 'package:totodo/presentation/screen/profile/data_ui/item_data_static_day.dart';
import 'package:totodo/presentation/screen/profile/data_ui/item_data_statistic_project.dart';

@immutable
class ProfileState extends Equatable {
  final User user;
  final List<ItemDataStatisticProject> listDataStaticProject;
  final ItemDataStatisticDay dataStatisticToday;
  final ItemDataStatisticDay dataStatisticYesterday;
  final List<ItemDataStatisticDay> listDataStatisticThisWeek;
  final List<ItemDataStatisticDay> listDataStatisticPreviousWeek;
  final List<ItemDataStatisticDay> listDataStatisticThisMonth;
  final List<ItemDataStatisticDay> listDataStatisticPreviousMonth;
  final CompletionRateData completionRateToday;
  final CompletionRateData completionRateWeek;
  final CompletionRateData completionRateMonth;
  final bool loading;

  const ProfileState({
    this.user,
    this.loading,
    this.listDataStaticProject,
    this.dataStatisticToday,
    this.dataStatisticYesterday,
    this.listDataStatisticThisWeek,
    this.listDataStatisticPreviousWeek,
    this.listDataStatisticThisMonth,
    this.listDataStatisticPreviousMonth,
    this.completionRateToday,
    this.completionRateWeek,
    this.completionRateMonth,
  });

  factory ProfileState.loading() => const ProfileState(loading: true);

  int get completedTaskInWeek {
    int completedTaskInWeek = 0;
    for (final data in listDataStatisticThisWeek) {
      completedTaskInWeek += data.completedTask;
    }
    return completedTaskInWeek;
  }

  int get allTaskInWeek {
    int allTaskInWeek = 0;
    for (final data in listDataStatisticThisWeek) {
      allTaskInWeek += data.allTask;
    }
    return allTaskInWeek;
  }

  @override
  List<Object> get props => [
        user,
        loading,
        listDataStaticProject,
        dataStatisticToday,
        listDataStatisticThisWeek
      ];

  ProfileState copyWith({
    User user,
    List<ItemDataStatisticProject> listDataStaticProject,
    ItemDataStatisticDay dataStatisticToday,
    ItemDataStatisticDay dataStatisticYesterday,
    List<ItemDataStatisticDay> listDataStatisticThisWeek,
    List<ItemDataStatisticDay> listDataStatisticPreviousWeek,
    List<ItemDataStatisticDay> listDataStatisticThisMonth,
    List<ItemDataStatisticDay> listDataStatisticPreviousMonth,
    CompletionRateData completionRateToday,
    CompletionRateData completionRateWeek,
    CompletionRateData completionRateMonth,
    bool loading,
  }) {
    if ((user == null || identical(user, this.user)) &&
        (listDataStaticProject == null ||
            identical(listDataStaticProject, this.listDataStaticProject)) &&
        (dataStatisticToday == null ||
            identical(dataStatisticToday, this.dataStatisticToday)) &&
        (dataStatisticYesterday == null ||
            identical(dataStatisticYesterday, this.dataStatisticYesterday)) &&
        (listDataStatisticThisWeek == null ||
            identical(
                listDataStatisticThisWeek, this.listDataStatisticThisWeek)) &&
        (listDataStatisticPreviousWeek == null ||
            identical(listDataStatisticPreviousWeek,
                this.listDataStatisticPreviousWeek)) &&
        (listDataStatisticThisMonth == null ||
            identical(
                listDataStatisticThisMonth, this.listDataStatisticThisMonth)) &&
        (listDataStatisticPreviousMonth == null ||
            identical(listDataStatisticPreviousMonth,
                this.listDataStatisticPreviousMonth)) &&
        (completionRateToday == null ||
            identical(completionRateToday, this.completionRateToday)) &&
        (completionRateWeek == null ||
            identical(completionRateWeek, this.completionRateWeek)) &&
        (completionRateMonth == null ||
            identical(completionRateMonth, this.completionRateMonth)) &&
        (loading == null || identical(loading, this.loading))) {
      return this;
    }

    return new ProfileState(
      user: user ?? this.user,
      listDataStaticProject:
          listDataStaticProject ?? this.listDataStaticProject,
      dataStatisticToday: dataStatisticToday ?? this.dataStatisticToday,
      dataStatisticYesterday:
          dataStatisticYesterday ?? this.dataStatisticYesterday,
      listDataStatisticThisWeek:
          listDataStatisticThisWeek ?? this.listDataStatisticThisWeek,
      listDataStatisticPreviousWeek:
          listDataStatisticPreviousWeek ?? this.listDataStatisticPreviousWeek,
      listDataStatisticThisMonth:
          listDataStatisticThisMonth ?? this.listDataStatisticThisMonth,
      listDataStatisticPreviousMonth:
          listDataStatisticPreviousMonth ?? this.listDataStatisticPreviousMonth,
      completionRateToday: completionRateToday ?? this.completionRateToday,
      completionRateWeek: completionRateWeek ?? this.completionRateWeek,
      completionRateMonth: completionRateMonth ?? this.completionRateMonth,
      loading: loading ?? this.loading,
    );
  }

  @override
  String toString() {
    return 'ProfileState{user: $user, listDataStaticProject: $listDataStaticProject, dataStatisticToday: $dataStatisticToday, listDataStatisticLast7Days: $listDataStatisticThisWeek, loading: $loading}';
  }
}

class CompletionRateData {
  final int overdue;
  final int onTime;
  final int undated;
  final int uncompleted;

  int get allTask {
    return overdue + onTime + undated + uncompleted;
  }

  double get completedPercent {
    if (allTask == 0) {
      return 0.0;
    }
    return 100 - (uncompleted / allTask) * 100;
  }

  double getPercent(int value) {
    if (allTask == 0) {
      return 0.0;
    }
    return value / allTask * 100;
  }

  CompletionRateData operator +(CompletionRateData completionRateData) {
    return copyWith(
      onTime: onTime + completionRateData.onTime,
      overdue: overdue + completionRateData.overdue,
      undated: undated + completionRateData.undated,
      uncompleted: uncompleted + completionRateData.uncompleted,
    );
  }

  CompletionRateData copyWith({
    int overdue,
    int onTime,
    int undated,
    int uncompleted,
  }) {
    if ((overdue == null || identical(overdue, this.overdue)) &&
        (onTime == null || identical(onTime, this.onTime)) &&
        (undated == null || identical(undated, this.undated)) &&
        (uncompleted == null || identical(uncompleted, this.uncompleted))) {
      return this;
    }

    return CompletionRateData(
      overdue: overdue ?? this.overdue,
      onTime: onTime ?? this.onTime,
      undated: undated ?? this.undated,
      uncompleted: uncompleted ?? this.uncompleted,
    );
  }

  const CompletionRateData({
    @required this.overdue,
    @required this.onTime,
    @required this.undated,
    @required this.uncompleted,
  });
}
