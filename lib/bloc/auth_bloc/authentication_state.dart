import 'package:equatable/equatable.dart';
import 'package:totodo/data/entity/user.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

class Uninitialized extends AuthenticationState {}

class Authenticated extends AuthenticationState {
  final User user;

  const Authenticated(this.user);

  @override
  List<Object> get props => [];

  @override
  String toString() {
    return 'Authenticated{displayName: ${user.name}';
  }
}

class Unauthenticated extends AuthenticationState {}
