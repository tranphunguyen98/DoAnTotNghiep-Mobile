import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:totodo/bloc/repository_interface/i_user_repository.dart';
import 'package:totodo/utils/validators.dart';

import 'bloc.dart';

class ForgotPasswordBloc
    extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  final IUserRepository _userRepository;

  ForgotPasswordBloc({@required IUserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository;

  @override
  ForgotPasswordState get initialState => ForgotPasswordState.empty();

  @override
  Stream<ForgotPasswordState> transformEvents(
      Stream<ForgotPasswordEvent> events,
      Stream<ForgotPasswordState> Function(ForgotPasswordEvent) next) {
    final nonDebounceStream = events.where((event) {
      return (event is! ForgotEmailChanged && event is! ForgotPasswordChanged);
    });

    final debounceStream = events.where((event) {
      return (event is ForgotEmailChanged || event is ForgotPasswordChanged);
    }).debounceTime(Duration(milliseconds: 300));

    return super
        .transformEvents(nonDebounceStream.mergeWith([debounceStream]), next);
  }

  @override
  Stream<ForgotPasswordState> mapEventToState(
      ForgotPasswordEvent event) async* {
    if (event is ForgotPasswordSubmitEmailPasswordEvent) {
      yield* _mapForgotPasswordSubmitEmailPasswordEventToState(
          event.email, event.password);
    } else if (event is ForgotEmailChanged) {
      yield* _mapForgotPasswordEmailChangedToState(event.email);
    } else if (event is ForgotPasswordChanged) {
      yield* _mapForgotPasswordPasswordChangedToState(event.password);
    }
  }

  Stream<ForgotPasswordState> _mapForgotPasswordSubmitEmailPasswordEventToState(
      String email, String password) async* {
    try {
      yield ForgotPasswordState.loading();

      final isSuccess = await _userRepository.resetPassword(email, password);

      if (isSuccess) {
        yield ForgotPasswordState.success();
      } else {
        yield ForgotPasswordState.failure("Error");
      }
    } catch (e) {
      yield ForgotPasswordState.failure("Error: ${e}");
    }
  }

  Stream<ForgotPasswordState> _mapForgotPasswordEmailChangedToState(
      String email) async* {
    yield state.update(isEmailValid: Validators.isValidEmail(email));
  }

  Stream<ForgotPasswordState> _mapForgotPasswordPasswordChangedToState(
      String password) async* {
    yield state.update(isPasswordValid: Validators.isValidPassword(password));
  }
}
