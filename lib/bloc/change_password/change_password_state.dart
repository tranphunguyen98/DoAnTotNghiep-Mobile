import 'package:meta/meta.dart';

@immutable
class ChangePasswordState {
  final bool isOldPasswordValid;
  final bool isNewPasswordValid;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;
  final String error;

  bool get isFormValid => isOldPasswordValid && isNewPasswordValid;

  const ChangePasswordState(
      {@required this.isOldPasswordValid,
      @required this.isNewPasswordValid,
      @required this.isSubmitting,
      @required this.isSuccess,
      @required this.isFailure,
      this.error = ""});

  factory ChangePasswordState.empty() {
    return const ChangePasswordState(
      isOldPasswordValid: true,
      isNewPasswordValid: true,
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
    );
  }

  factory ChangePasswordState.loading() {
    return const ChangePasswordState(
      isOldPasswordValid: true,
      isNewPasswordValid: true,
      isSubmitting: true,
      isSuccess: false,
      isFailure: false,
    );
  }

  factory ChangePasswordState.failure(String error) {
    return ChangePasswordState(
        isOldPasswordValid: true,
        isNewPasswordValid: true,
        isSuccess: false,
        isSubmitting: false,
        isFailure: true,
        error: error);
  }

  factory ChangePasswordState.success() {
    return const ChangePasswordState(
      isOldPasswordValid: true,
      isNewPasswordValid: true,
      isSubmitting: false,
      isSuccess: true,
      isFailure: false,
    );
  }

  ChangePasswordState update(
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

  ChangePasswordState copyWith({
    bool isEmailValid,
    bool isPasswordValid,
    bool isConfirmPasswordValid,
    bool isNameValid,
    bool isSubmitting,
    bool isSuccess,
    bool isFailure,
  }) {
    return ChangePasswordState(
      isOldPasswordValid: isEmailValid ?? isOldPasswordValid,
      isNewPasswordValid: isPasswordValid ?? isNewPasswordValid,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
    );
  }

  @override
  String toString() {
    return 'ChangePasswordState{isOldPasswordValid: $isOldPasswordValid, isNewPasswordValid: $isNewPasswordValid, isSubmitting: $isSubmitting, isSuccess: $isSuccess, isFailure: $isFailure, error: $error}';
  }
}
