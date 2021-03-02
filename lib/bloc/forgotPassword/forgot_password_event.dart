import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class ForgotPasswordEvent extends Equatable {
  const ForgotPasswordEvent();

  @override
  List<Object> get props => [];
}

class ForgotEmailChanged extends ForgotPasswordEvent {
  final String email;

  const ForgotEmailChanged({@required this.email});

  @override
  List<Object> get props => [email];

  @override
  String toString() {
    return 'EmailChanged{email: $email}';
  }
}

class ForgotOTPCodeChanged extends ForgotPasswordEvent {
  final String otpCode;

  const ForgotOTPCodeChanged({@required this.otpCode});

  @override
  List<Object> get props => [otpCode];

  @override
  String toString() {
    return 'ForgotOTPCodeChanged{email: $otpCode}';
  }
}

class ForgotPasswordChanged extends ForgotPasswordEvent {
  final String password;

  const ForgotPasswordChanged({@required this.password});

  @override
  List<Object> get props => [];

  @override
  String toString() {
    return 'ForgotPasswordChanged{password: $password}';
  }
}

class ForgotPasswordSubmitEmailPasswordEvent extends ForgotPasswordEvent {
  final String email;
  final String otpCode;
  final String password;

  const ForgotPasswordSubmitEmailPasswordEvent({
    @required this.email,
    @required this.otpCode,
    @required this.password,
  });

  @override
  List<Object> get props => [email, otpCode, password];
}

class SendOTPSubmitEvent extends ForgotPasswordEvent {
  final String email;

  const SendOTPSubmitEvent({
    @required this.email,
  });

  @override
  List<Object> get props => [email];
}
