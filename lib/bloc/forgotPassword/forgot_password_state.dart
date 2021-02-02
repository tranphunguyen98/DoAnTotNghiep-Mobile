import 'package:meta/meta.dart';

@immutable
class ForgotPasswordState {
  final bool isEmailValid;
  final bool isPasswordValid;
  final bool isConfirmPasswordValid;
  final bool isNameValid;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;
  final String error;

  bool get isFormValid =>
      isEmailValid && isPasswordValid && isConfirmPasswordValid && isNameValid;

  ForgotPasswordState(
      {@required this.isEmailValid,
      @required this.isPasswordValid,
      @required this.isConfirmPasswordValid,
      @required this.isNameValid,
      @required this.isSubmitting,
      @required this.isSuccess,
      @required this.isFailure,
      this.error = ""});

  factory ForgotPasswordState.empty() {
    return ForgotPasswordState(
      isEmailValid: true,
      isPasswordValid: true,
      isConfirmPasswordValid: true,
      isNameValid: true,
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
    );
  }

  factory ForgotPasswordState.loading() {
    return ForgotPasswordState(
      isEmailValid: true,
      isPasswordValid: true,
      isConfirmPasswordValid: true,
      isNameValid: true,
      isSubmitting: true,
      isSuccess: false,
      isFailure: false,
    );
  }

  factory ForgotPasswordState.failure(String error) {
    return ForgotPasswordState(
        isEmailValid: true,
        isPasswordValid: true,
        isConfirmPasswordValid: true,
        isNameValid: true,
        isSuccess: false,
        isSubmitting: false,
        isFailure: true,
        error: error);
  }

  factory ForgotPasswordState.success() {
    return ForgotPasswordState(
      isEmailValid: true,
      isPasswordValid: true,
      isConfirmPasswordValid: true,
      isNameValid: true,
      isSubmitting: false,
      isSuccess: true,
      isFailure: false,
    );
  }

  ForgotPasswordState update(
      {bool isEmailValid,
      bool isPasswordValid,
      bool isNameValid,
      bool isConfirmPasswordValid}) {
    return copyWith(
      isEmailValid: isEmailValid,
      isPasswordValid: isPasswordValid,
      isConfirmPasswordValid: isConfirmPasswordValid,
      isNameValid: isNameValid,
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
    );
  }

  ForgotPasswordState copyWith({
    bool isEmailValid,
    bool isPasswordValid,
    bool isConfirmPasswordValid,
    bool isNameValid,
    bool isSubmitting,
    bool isSuccess,
    bool isFailure,
  }) {
    return ForgotPasswordState(
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
    return 'ForgotPasswordState{isEmailValid: $isEmailValid, isPasswordValid: $isPasswordValid, isConfirmPasswordValid: $isConfirmPasswordValid, isNameValid: $isNameValid, isSubmitting: $isSubmitting, isSuccess: $isSuccess, isFailure: $isFailure}';
  }
}
