import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class DisplayNameChanged extends RegisterEvent {
  final String displayName;

  const DisplayNameChanged({@required this.displayName});

  @override
  List<Object> get props => [displayName];

  @override
  String toString() {
    return 'DisplayNameChanged{displayName: $displayName}';
  }
}

class EmailChanged extends RegisterEvent {
  final String email;

  const EmailChanged({@required this.email});

  @override
  List<Object> get props => [email];

  @override
  String toString() {
    return 'EmailChanged{email: $email}';
  }
}

class PasswordChanged extends RegisterEvent {
  final String password;
  final String confirmPassword;

  const PasswordChanged({@required this.password, @required this.confirmPassword});

  @override
  List<Object> get props => [];

  @override
  String toString() {
    return 'PasswordChanged{password: $password, confirmPassword: $confirmPassword}';
  }
}

class ConfirmPasswordChanged extends RegisterEvent {
  final String password;
  final String confirmPassword;

  const ConfirmPasswordChanged(
      {@required this.password, @required this.confirmPassword});

  @override
  List<Object> get props => [];

  @override
  String toString() {
    return 'ConfirmPasswordChanged{password: $password, confirmPassword: $confirmPassword}';
  }
}

class Submitted extends RegisterEvent {
  final String displayName;
  final String email;
  final String password;
  final String confirmPassword;

  const Submitted({
    @required this.displayName,
    @required this.email,
    @required this.password,
    @required this.confirmPassword,
  });

  @override
  List<Object> get props => [displayName, email, password, confirmPassword];

  @override
  String toString() {
    return 'Submitted{displayName: $displayName, email: $email, password: $password, confirmPassword: $confirmPassword}';
  }
}
