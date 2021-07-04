import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:totodo/data/repository_interface/i_habit_repository.dart';
import 'package:totodo/data/repository_interface/i_task_repository.dart';
import 'package:totodo/data/repository_interface/i_user_repository.dart';

import 'bloc.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final IUserRepository _userRepository;
  final ITaskRepository _taskRepository;
  final IHabitRepository _habitRepository;

  AuthenticationBloc({
    @required IUserRepository userRepository,
    @required ITaskRepository taskRepository,
    @required IHabitRepository habitRepository,
  })  : assert(userRepository != null),
        _userRepository = userRepository,
        _taskRepository = taskRepository,
        _habitRepository = habitRepository,
        super(null);

  @override
  Stream<AuthenticationState> mapEventToState(
      AuthenticationEvent event) async* {
    if (event is AppStarted) {
      yield* _mapAppStartedToState();
    } else if (event is SignedUp) {
      yield* _mapSignedUpToState();
    } else if (event is LoggedIn) {
      yield* _mapLoggedInToState();
    } else if (event is LoggedOut) {
      yield* _mapLoggedOutToState();
    }
  }

  Stream<AuthenticationState> _mapAppStartedToState() async* {
    try {
      final isSignedIn = await _userRepository.isSignedIn();

      if (isSignedIn) {
        final user = await _userRepository.getUser();
        yield Authenticated(user);
      } else {
        yield Unauthenticated();
      }
    } catch (_) {
      yield Unauthenticated();
    }
  }

  Stream<AuthenticationState> _mapLoggedInToState() async* {
    // try {
    //
    // } catch ()
    yield Loading();
    await _taskRepository.saveDataToLocal();
    await _habitRepository.saveDataOnLocal();

    yield Authenticated(await _userRepository.getUser());
  }

  Stream<AuthenticationState> _mapSignedUpToState() async* {
    yield Unauthenticated();
  }

  Stream<AuthenticationState> _mapLoggedOutToState() async* {
    yield Unauthenticated();
    AwesomeNotifications().cancelAllSchedules();
    _userRepository.signOut();
  }
}
