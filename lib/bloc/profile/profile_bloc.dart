import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:totodo/bloc/repository_interface/i_task_repository.dart';
import 'package:totodo/bloc/repository_interface/i_user_repository.dart';
import 'package:totodo/presentation/screen/profile/item_data_statistic_project.dart';
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
    if (event is OpenProfileScreen) {
      yield* _mapOpenProfileScreenToState();
    }
  }

  Stream<ProfileState> _mapOpenProfileScreenToState() async* {
    try {
      final isSignedIn = await _userRepository.isSignedIn();

      if (isSignedIn) {
        final user = await _userRepository.getUser();
        yield state.copyWith(
            user: user, listDataStaticProject: _listDataStatisticProjectMockUp);
      }
    } catch (error, stackTrace) {
      log('Profile Error', stackTrace);
    }
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
