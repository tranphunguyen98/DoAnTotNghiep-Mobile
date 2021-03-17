import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../../utils/validators.dart';
import '../repository_interface/i_user_repository.dart';
import 'bloc.dart';

class ForgotPasswordBloc
    extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  final IUserRepository _userRepository;

  ForgotPasswordBloc({@required IUserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(ForgotPasswordState.empty());

  // @override
  // Stream<ForgotPasswordState> transformEvents(
  //     Stream<ForgotPasswordEvent> events,
  //     Stream<ForgotPasswordState> Function(ForgotPasswordEvent) next) {
  //   final nonDebounceStream = events.where((event) {
  //     return (event is! ForgotEmailChanged && event is! ForgotPasswordChanged);
  //   });
  //
  //   final debounceStream = events.where((event) {
  //     return (event is ForgotEmailChanged || event is ForgotPasswordChanged);
  //   }).debounceTime(Duration(milliseconds: 300));
  //
  //   return super
  //       .transformEvents(nonDebounceStream.mergeWith([debounceStream]), next);
  // }

  @override
  Stream<ForgotPasswordState> mapEventToState(
      ForgotPasswordEvent event) async* {
    if (event is ForgotPasswordSubmitEmailPasswordEvent) {
      yield* _mapForgotPasswordSubmitEmailPasswordEventToState(
          event.email, event.otpCode, event.password);
    } else if (event is ForgotEmailChanged) {
      yield* _mapForgotPasswordEmailChangedToState(event.email);
    } else if (event is ForgotPasswordChanged) {
      yield* _mapForgotPasswordPasswordChangedToState(event.password);
    } else if (event is ForgotOTPCodeChanged) {
      yield* _mapForgotOTPCodeChangedToState(event.otpCode);
    } else if (event is SendOTPSubmitEvent) {
      yield* _mapSendOTPSubmitEventToState(event.email);
    }
  }

  Stream<ForgotPasswordState> _mapSendOTPSubmitEventToState(
      String email) async* {
    try {
      yield ForgotPasswordState.loading();

      final isSuccess = await _userRepository.sendOTPResetPassword(email);

      if (isSuccess) {
        yield ForgotPasswordState.sendOTPSuccess();
      } else {
        yield state.copyWith(error: "Error");
      }
    } catch (e) {
      yield state.copyWith(error: "Error: $e");
    }
  }

  Stream<ForgotPasswordState> _mapForgotPasswordSubmitEmailPasswordEventToState(
      String email, String otpCode, String password) async* {
    try {
      yield ForgotPasswordState.loading();

      final isSuccess =
          await _userRepository.resetPassword(email, otpCode, password);

      if (isSuccess) {
        yield state.copyWith(isResetPasswordSuccess: true);
      } else {
        yield state.copyWith(error: "Error");
      }
    } catch (e) {
      yield state.copyWith(error: "Error: $e");
    }
  }

  Stream<ForgotPasswordState> _mapForgotPasswordEmailChangedToState(
      String email) async* {
    yield state.copyWith(isEmailValid: Validators.isValidEmail(email));
  }

  Stream<ForgotPasswordState> _mapForgotPasswordPasswordChangedToState(
      String password) async* {
    yield state.copyWith(isPasswordValid: Validators.isValidPassword(password));
  }

  Stream<ForgotPasswordState> _mapForgotOTPCodeChangedToState(
      String otpCode) async* {
    yield state.copyWith(isOTPValid: Validators.isValidOTPCode(otpCode));
  }
}
