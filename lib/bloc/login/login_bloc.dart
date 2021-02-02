import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:totodo/bloc/repository_interface/i_user_repository.dart';
import 'package:totodo/utils/validators.dart';

import 'bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final IUserRepository _userRepository;

  LoginBloc({@required IUserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository;

  @override
  LoginState get initialState => LoginState.empty();

  @override
  Stream<LoginState> transformEvents(
      Stream<LoginEvent> events, Stream<LoginState> Function(LoginEvent) next) {
    final nonDebounceStream = events.where((event) {
      return (event is! LoginEmailChanged && event is! LoginPasswordChanged);
    });

    final debounceStream = events.where((event) {
      return (event is LoginEmailChanged || event is LoginPasswordChanged);
    }).debounceTime(Duration(milliseconds: 300));

    return super
        .transformEvents(nonDebounceStream.mergeWith([debounceStream]), next);
  }

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginSubmitEmailPasswordEvent) {
      yield* _mapLoginSubmitEmailPasswordEventToState(
          event.email, event.password);
    } else if (event is LoginEmailChanged) {
      yield* _mapLoginEmailChangedToState(event.email);
    } else if (event is LoginPasswordChanged) {
      yield* _mapLoginPasswordChangedToState(event.password);
    }
  }

  Stream<LoginState> _mapLoginSubmitEmailPasswordEventToState(
      String email, String password) async* {
    try {
      yield LoginState.loading();

      final user = await _userRepository.signIn(email, password);
      await _userRepository.saveUser(user);
      final bool isSignedIn = await _userRepository.isSignedIn();

      if (isSignedIn) {
        yield LoginState.success();
      } else {
        yield LoginState.failure("Error");
      }
    } catch (e) {
      yield LoginState.failure("Error: ${e}");
    }
  }

  Stream<LoginState> _mapLoginEmailChangedToState(String email) async* {
    yield state.update(isEmailValid: Validators.isValidEmail(email));
  }

  Stream<LoginState> _mapLoginPasswordChangedToState(String password) async* {
    yield state.update(isPasswordValid: Validators.isValidPassword(password));
  }
}
