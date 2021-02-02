import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class ChangePasswordEvent extends Equatable {
  const ChangePasswordEvent();

  @override
  List<Object> get props => [];
}

class ChangeEmailChanged extends ChangePasswordEvent {
  final String email;

  const ChangeEmailChanged({@required this.email});

  @override
  List<Object> get props => [email];

  @override
  String toString() {
    return 'EmailChanged{email: $email}';
  }
}

class ChangePasswordChanged extends ChangePasswordEvent {
  final String password;

  const ChangePasswordChanged({@required this.password});

  @override
  List<Object> get props => [];

  @override
  String toString() {
    return 'ChangePasswordChanged{password: $password}';
  }
}

class ChangePasswordSubmitEmailPasswordEvent extends ChangePasswordEvent {
  final String email;
  final String password;

  ChangePasswordSubmitEmailPasswordEvent(
      {@required this.email, @required this.password});

  @override
  List<Object> get props => [email, password];
}
