import 'package:meta/meta.dart';

@immutable
class RegisterState {
  final bool isEmailValid;
  final bool isDisplayNameValid;
  final bool isPasswordValid;
  final bool isConfirmPasswordValid;
  final bool isNameValid;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;
  final String error;

  bool get isFormValid =>
      isDisplayNameValid &&
      isEmailValid &&
      isPasswordValid &&
      isConfirmPasswordValid &&
      isNameValid;

  const RegisterState(
      {@required this.isDisplayNameValid,
      @required this.isEmailValid,
      @required this.isPasswordValid,
      @required this.isConfirmPasswordValid,
      @required this.isNameValid,
      @required this.isSubmitting,
      @required this.isSuccess,
      @required this.isFailure,
      this.error = ""});

  factory RegisterState.empty() {
    return const RegisterState(
      isDisplayNameValid: true,
      isEmailValid: true,
      isPasswordValid: true,
      isConfirmPasswordValid: true,
      isNameValid: true,
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
    );
  }

  factory RegisterState.loading() {
    return const RegisterState(
      isDisplayNameValid: true,
      isEmailValid: true,
      isPasswordValid: true,
      isConfirmPasswordValid: true,
      isNameValid: true,
      isSubmitting: true,
      isSuccess: false,
      isFailure: false,
    );
  }

  factory RegisterState.failure(String error) {
    return RegisterState(
        isDisplayNameValid: true,
        isEmailValid: true,
        isPasswordValid: true,
        isConfirmPasswordValid: true,
        isNameValid: true,
        isSuccess: false,
        isSubmitting: false,
        isFailure: true,
        error: error);
  }

  factory RegisterState.success() {
    return const RegisterState(
      isDisplayNameValid: true,
      isEmailValid: true,
      isPasswordValid: true,
      isConfirmPasswordValid: true,
      isNameValid: true,
      isSubmitting: false,
      isSuccess: true,
      isFailure: false,
    );
  }

  RegisterState update(
      {bool isDisplayNameValid,
      bool isEmailValid,
      bool isPasswordValid,
      bool isNameValid,
      bool isConfirmPasswordValid}) {
    return copyWith(
      isDisplayNameValid: isDisplayNameValid,
      isEmailValid: isEmailValid,
      isPasswordValid: isPasswordValid,
      isConfirmPasswordValid: isConfirmPasswordValid,
      isNameValid: isNameValid,
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
    );
  }

  RegisterState copyWith({
    bool isDisplayNameValid,
    bool isEmailValid,
    bool isPasswordValid,
    bool isConfirmPasswordValid,
    bool isNameValid,
    bool isSubmitting,
    bool isSuccess,
    bool isFailure,
  }) {
    return RegisterState(
      isDisplayNameValid: isDisplayNameValid ?? this.isDisplayNameValid,
      isEmailValid: isEmailValid ?? this.isEmailValid,
      isPasswordValid: isPasswordValid ?? this.isPasswordValid,
      isConfirmPasswordValid:
          isConfirmPasswordValid ?? this.isConfirmPasswordValid,
      isNameValid: isNameValid ?? this.isNameValid,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
    );
  }

  @override
  String toString() {
    return 'RegisterState{isEmailValid: $isEmailValid, isDisplayNameValid: $isDisplayNameValid, isPasswordValid: $isPasswordValid, isConfirmPasswordValid: $isConfirmPasswordValid, isNameValid: $isNameValid, isSubmitting: $isSubmitting, isSuccess: $isSuccess, isFailure: $isFailure, error: $error}';
  }
}
