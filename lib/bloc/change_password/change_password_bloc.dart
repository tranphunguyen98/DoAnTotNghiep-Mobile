import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:totodo/data/repository_interface/i_user_repository.dart';
import 'package:totodo/utils/validators.dart';

import 'bloc.dart';

class ChangePasswordBloc
    extends Bloc<ChangePasswordEvent, ChangePasswordState> {
  final IUserRepository _userRepository;

  ChangePasswordBloc({@required IUserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(ChangePasswordState.empty());

  // @override
  // Stream<Transition<ChangePasswordEvent, ChangePasswordState>> transformEvents(
  //     Stream<ChangePasswordEvent> events, transitionFn) {
  // TODO: implement transformEvents Debouce
  //   return super.transformEvents(events, transitionFn);
  // }

  // @override
  // Stream<ChangePasswordState> transformEvents(
  //     Stream<ChangePasswordEvent> events,
  //     Stream<ChangePasswordState> Function(ChangePasswordEvent) next) {
  //   final nonDebounceStream = events.where((event) {
  //     return (event is! ChangeEmailChanged && event is! ChangePasswordChanged);
  //   });
  //
  //   final debounceStream = events.where((event) {
  //     return (event is ChangeEmailChanged || event is ChangePasswordChanged);
  //   }).debounceTime(Duration(milliseconds: 300));
  //
  //   return super
  //       .transformEvents(nonDebounceStream.mergeWith([debounceStream]), next);
  // }

  @override
  Stream<ChangePasswordState> mapEventToState(
      ChangePasswordEvent event) async* {
    if (event is ChangePasswordSubmitEmailPasswordEvent) {
      yield* _mapChangePasswordSubmitEmailPasswordEventToState(
          event.authorization, event.oldPassword, event.newPassword);
    } else if (event is ChangeOldPassword) {
      yield* _mapChangePasswordEmailChangedToState(event.oldPassword);
    } else if (event is ChangePasswordChanged) {
      yield* _mapChangePasswordPasswordChangedToState(event.password);
    }
  }

  Stream<ChangePasswordState> _mapChangePasswordSubmitEmailPasswordEventToState(
      String authorization, String oldPassword, String newPassword) async* {
    try {
      yield ChangePasswordState.loading();

      final isSuccess = await _userRepository.changePassword(
          authorization, oldPassword, newPassword);

      if (isSuccess) {
        yield ChangePasswordState.success();
      } else {
        yield ChangePasswordState.failure("Error");
      }
    } catch (e) {
      yield ChangePasswordState.failure("Error: $e");
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
