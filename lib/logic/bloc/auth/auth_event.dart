part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

class AuthEventInit extends AuthEvent {}

class AuthEventSignIn extends AuthEvent {
  final String email;
  final String password;
  AuthEventSignIn({required this.email, required this.password}) : super();
}

class AuthEventRePassword extends AuthEvent {}