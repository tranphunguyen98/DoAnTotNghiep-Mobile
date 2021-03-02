import 'package:meta/meta.dart';

@immutable
class ForgotPasswordState {
  final bool isEmailValid;
  final bool isOTPValid;
  final bool isPasswordValid;
  final bool isSubmitting;
  final bool isResetPasswordSuccess;
  final bool isSendOTPSuccess;
  final bool isFailure;
  final String error;

  bool get isFormValid => isEmailValid && isPasswordValid && isOTPValid;

  ForgotPasswordState(
      {@required this.isEmailValid,
      @required this.isPasswordValid,
      @required this.isSubmitting,
      @required this.isResetPasswordSuccess,
      @required this.isFailure,
      @required this.isOTPValid,
      @required this.isSendOTPSuccess,
      this.error = ""});

  factory ForgotPasswordState.empty() {
    return ForgotPasswordState(
      isEmailValid: true,
      isPasswordValid: true,
      isOTPValid: true,
      isSendOTPSuccess: false,
      error: null,
      isSubmitting: false,
      isResetPasswordSuccess: false,
      isFailure: false,
    );
  }

  factory ForgotPasswordState.loading() {
    return ForgotPasswordState(
      isEmailValid: true,
      isPasswordValid: true,
      isOTPValid: true,
      isSendOTPSuccess: false,
      error: null,
      isSubmitting: true,
      isResetPasswordSuccess: false,
      isFailure: false,
    );
  }

  factory ForgotPasswordState.sendOTPSuccess() {
    return ForgotPasswordState(
        isEmailValid: true,
        isPasswordValid: true,
        isSubmitting: false,
        isResetPasswordSuccess: false,
        isFailure: false,
        isSendOTPSuccess: true,
        isOTPValid: true,
        error: null);
  }

  ForgotPasswordState copyWith({
    bool isEmailValid,
    bool isOTPValid,
    bool isPasswordValid,
    bool isSubmitting,
    bool isResetPasswordSuccess,
    bool isSendOTPSuccess,
    bool isFailure,
    String error,
  }) {
    if ((isEmailValid == null || identical(isEmailValid, this.isEmailValid)) &&
        (isOTPValid == null || identical(isOTPValid, this.isOTPValid)) &&
        (isPasswordValid == null ||
            identical(isPasswordValid, this.isPasswordValid)) &&
        (isSubmitting == null || identical(isSubmitting, this.isSubmitting)) &&
        (isResetPasswordSuccess == null ||
            identical(isResetPasswordSuccess, this.isResetPasswordSuccess)) &&
        (isSendOTPSuccess == null ||
            identical(isSendOTPSuccess, this.isSendOTPSuccess)) &&
        (isFailure == null || identical(isFailure, this.isFailure)) &&
        (error == null || identical(error, this.error))) {
      return this;
    }

    return ForgotPasswordState(
      isEmailValid: isEmailValid ?? this.isEmailValid,
      isOTPValid: isOTPValid ?? this.isOTPValid,
      isPasswordValid: isPasswordValid ?? this.isPasswordValid,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isResetPasswordSuccess:
          isResetPasswordSuccess ?? this.isResetPasswordSuccess,
      isSendOTPSuccess: isSendOTPSuccess ?? this.isSendOTPSuccess,
      isFailure: isFailure ?? this.isFailure,
      error: error ?? this.error,
    );
  }

  @override
  String toString() {
    return 'ForgotPasswordState{isEmailValid: $isEmailValid, isOTPValid: $isOTPValid, isPasswordValid: $isPasswordValid, isSubmitting: $isSubmitting, isResetPasswordSuccess: $isResetPasswordSuccess, isSendOTPSuccess: $isSendOTPSuccess, isFailure: $isFailure, error: $error}';
  }
}
