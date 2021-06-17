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
  final List<ItemDataStatisticDay> listDataStatisticLast7Days;
  final bool loading;

  const ProfileState(
      {this.user,
      this.loading,
      this.listDataStaticProject,
      this.dataStatisticToday,
      this.listDataStatisticLast7Days});

  factory ProfileState.loading() => const ProfileState(loading: true);

  int get completedTaskInWeek {
    int completedTaskInWeek = 0;
    for (final data in listDataStatisticLast7Days) {
      completedTaskInWeek += data.completedTask;
    }
    return completedTaskInWeek;
  }

  int get allTaskInWeek {
    int allTaskInWeek = 0;
    for (final data in listDataStatisticLast7Days) {
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
        listDataStatisticLast7Days
      ];

  ProfileState copyWith({
    User user,
    List<ItemDataStatisticProject> listDataStaticProject,
    ItemDataStatisticDay dataStatisticToday,
    List<ItemDataStatisticDay> listDataStatisticLast7Days,
    bool loading,
  }) {
    if ((user == null || identical(user, this.user)) &&
        (listDataStaticProject == null ||
            identical(listDataStaticProject, this.listDataStaticProject)) &&
        (dataStatisticToday == null ||
            identical(dataStatisticToday, this.dataStatisticToday)) &&
        (listDataStatisticLast7Days == null ||
            identical(
                listDataStatisticLast7Days, this.listDataStatisticLast7Days)) &&
        (loading == null || identical(loading, this.loading))) {
      return this;
    }

    return ProfileState(
      user: user ?? this.user,
      listDataStaticProject:
          listDataStaticProject ?? this.listDataStaticProject,
      dataStatisticToday: dataStatisticToday ?? this.dataStatisticToday,
      listDataStatisticLast7Days:
          listDataStatisticLast7Days ?? this.listDataStatisticLast7Days,
      loading: loading ?? this.loading,
    );
  }

  @override
  String toString() {
    return 'ProfileState{user: $user, listDataStaticProject: $listDataStaticProject, dataStatisticToday: $dataStatisticToday, listDataStatisticLast7Days: $listDataStatisticLast7Days, loading: $loading}';
  }
}
