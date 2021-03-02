import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class ChangePasswordEvent extends Equatable {
  const ChangePasswordEvent();

  @override
  List<Object> get props => [];
}

class ChangeOldPassword extends ChangePasswordEvent {
  final String oldPassword;

  const ChangeOldPassword({@required this.oldPassword});

  @override
  List<Object> get props => [oldPassword];

  @override
  String toString() {
    return 'EmailChanged{email: $oldPassword}';
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
  final String authorization;
  final String oldPassword;
  final String newPassword;

  const ChangePasswordSubmitEmailPasswordEvent(
      {@required this.authorization,
      @required this.oldPassword,
      @required this.newPassword});

  @override
  List<Object> get props => [authorization, oldPassword, newPassword];
}
