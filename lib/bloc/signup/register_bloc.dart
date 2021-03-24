import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:totodo/utils/util.dart';

import '../../utils/validators.dart';
import '../repository_interface/i_user_repository.dart';
import 'bloc.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final IUserRepository _userRepository;

  RegisterBloc({@required IUserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(RegisterState.empty()) {
    log('RegisterState created!!');
  }

  @override
  Future<void> close() {
    log('RegisterState Close!!');
    return super.close();
  }
  // @override
  // Stream<Transition<RegisterEvent, RegisterState>> transformEvents(
  //   Stream<RegisterEvent> events,
  //   Stream<Transition<RegisterEvent, RegisterState>> Function(RegisterEvent)
  //       transitionFn,
  // ) {
  //   final nonDebounceStream = events.where((event) {
  //     return event is! EmailChanged &&
  //         event is! PasswordChanged &&
  //         event is! DisplayNameChanged &&
  //         event is! ConfirmPasswordChanged;
  //   });
  //
  //   final debounceStream = events.where((event) {
  //     return event is EmailChanged ||
  //         event is PasswordChanged ||
  //         event is ConfirmPasswordChanged ||
  //         event is DisplayNameChanged;
  //   }).debounceTime(const Duration(milliseconds: 2000));
  //
  //   return super.transformEvents(
  //     MergeStream([nonDebounceStream, debounceStream]),
  //     transitionFn,
  //   );
  // }

  @override
  Stream<RegisterState> mapEventToState(RegisterEvent event) async* {
    if (event is DisplayNameChanged) {
      yield* _mapDisplayNameChangedToState(event.displayName);
    } else if (event is EmailChanged) {
      yield* _mapEmailChangedToState(event.email);
    } else if (event is PasswordChanged) {
      yield* _mapPasswordChangedToState(event.password, event.confirmPassword);
    } else if (event is ConfirmPasswordChanged) {
      yield* _mapConfirmPasswordChangedToState(
          event.password, event.confirmPassword);
    } else if (event is Submitted) {
      yield* _mapFormSubmittedToState(event.displayName, event.email,
          event.password, event.confirmPassword);
    }
  }

  Stream<RegisterState> _mapDisplayNameChangedToState(String name) async* {
    yield state.update(
      isDisplayNameValid: Validators.isValidName(name),
    );
  }

  Stream<RegisterState> _mapEmailChangedToState(String email) async* {
    yield state.update(
      isEmailValid: Validators.isValidEmail(email),
    );
  }

  Stream<RegisterState> _mapPasswordChangedToState(
      String password, String confirmPassword) async* {
    final isPasswordValid = Validators.isValidPassword(password);
    var isMatched = true;

    if (confirmPassword.isNotEmpty) {
      isMatched = password == confirmPassword;
    }

    yield state.update(
        isPasswordValid: isPasswordValid, isConfirmPasswordValid: isMatched);
  }

  Stream<RegisterState> _mapConfirmPasswordChangedToState(
      String password, String confirmPassword) async* {
    final isConfirmPasswordValid = Validators.isValidPassword(confirmPassword);
    var isMatched = true;

    if (password.isNotEmpty) {
      isMatched = password == confirmPassword;
    }

    yield state.update(
      isConfirmPasswordValid: isConfirmPasswordValid && isMatched,
    );
  }

  Stream<RegisterState> _mapFormSubmittedToState(String displayName,
      String email, String password, String confirmPassword) async* {
    final isValidEmail = Validators.isValidEmail(email);
    final isValidPassword = Validators.isValidPassword(password);
    final isValidConfirmPassword = Validators.isValidPassword(confirmPassword);
    final isValidDisplayName = Validators.isValidName(displayName);

    var isMatched = true;
    if (isValidPassword && isValidConfirmPassword) {
      isMatched = password == confirmPassword;
    }

    final newState = state.update(
        isNameValid: isValidDisplayName,
        isEmailValid: isValidEmail,
        isPasswordValid: isValidPassword,
        isConfirmPasswordValid: isValidConfirmPassword && isMatched);

    yield newState;

    if (newState.isFormValid) {
      yield RegisterState.loading();

      try {
        await _userRepository.signUp(displayName, email, password);
        yield RegisterState.success();
      } catch (e, stackTrace) {
        log(stackTrace.toString());
        yield RegisterState.failure("$e");
      }
    }
  }
}
