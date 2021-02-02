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
  final String password;

  ForgotPasswordSubmitEmailPasswordEvent(
      {@required this.email, @required this.password});

  @override
  List<Object> get props => [email, password];
}
