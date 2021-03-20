import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:totodo/data/entity/user.dart';
import 'package:totodo/presentation/screen/profile/item_data_statistic_project.dart';

@immutable
class ProfileState extends Equatable {
  final User user;
  final List<ItemDataStatisticProject> listDataStaticProject;
  final bool loading;

  const ProfileState({this.user, this.loading, this.listDataStaticProject});

  factory ProfileState.loading() => const ProfileState(loading: true);

  @override
  List<Object> get props => [user];

  ProfileState copyWith({
    User user,
    List<ItemDataStatisticProject> listDataStaticProject,
    bool loading,
  }) {
    if ((user == null || identical(user, this.user)) &&
        (listDataStaticProject == null ||
            identical(listDataStaticProject, this.listDataStaticProject)) &&
        (loading == null || identical(loading, this.loading))) {
      return this;
    }

    return ProfileState(
      user: user ?? this.user,
      listDataStaticProject:
          listDataStaticProject ?? this.listDataStaticProject,
      loading: loading ?? this.loading,
    );
  }

  @override
  String toString() {
    return 'ProfileState{user: $user';
  }
}
