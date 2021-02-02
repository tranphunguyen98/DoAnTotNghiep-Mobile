import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:totodo/bloc/repository_interface/i_user_repository.dart';
import 'package:totodo/utils/validators.dart';

import 'bloc.dart';

class ChangePasswordBloc
    extends Bloc<ChangePasswordEvent, ChangePasswordState> {
  final IUserRepository _userRepository;

  ChangePasswordBloc({@required IUserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository;

  @override
  ChangePasswordState get initialState => ChangePasswordState.empty();

  @override
  Stream<ChangePasswordState> transformEvents(
      Stream<ChangePasswordEvent> events,
      Stream<ChangePasswordState> Function(ChangePasswordEvent) next) {
    final nonDebounceStream = events.where((event) {
      return (event is! ChangeEmailChanged && event is! ChangePasswordChanged);
    });

    final debounceStream = events.where((event) {
      return (event is ChangeEmailChanged || event is ChangePasswordChanged);
    }).debounceTime(Duration(milliseconds: 300));

    return super
        .transformEvents(nonDebounceStream.mergeWith([debounceStream]), next);
  }

  @override
  Stream<ChangePasswordState> mapEventToState(
      ChangePasswordEvent event) async* {
    if (event is ChangePasswordSubmitEmailPasswordEvent) {
      yield* _mapChangePasswordSubmitEmailPasswordEventToState(
          event.email, event.password);
    } else if (event is ChangeEmailChanged) {
      yield* _mapChangePasswordEmailChangedToState(event.email);
    } else if (event is ChangePasswordChanged) {
      yield* _mapChangePasswordPasswordChangedToState(event.password);
    }
  }

  Stream<ChangePasswordState> _mapChangePasswordSubmitEmailPasswordEventToState(
      String oldPassword, String newPassword) async* {
    try {
      yield ChangePasswordState.loading();

      final isSuccess =
          await _userRepository.changePassword(oldPassword, newPassword);

      if (isSuccess) {
        yield ChangePasswordState.success();
      } else {
        yield ChangePasswordState.failure("Error");
      }
    } catch (e) {
      yield ChangePasswordState.failure("Error: ${e}");
    }
  }

  Stream<ChangePasswordState> _mapChangePasswordEmailChangedToState(
      String email) async* {
    yield state.update(isEmailValid: Validators.isValidPassword(email));
  }

  Stream<ChangePasswordState> _mapChangePasswordPasswordChangedToState(
      String password) async* {
    yield state.update(isPasswordValid: Validators.isValidPassword(password));
  }
}
