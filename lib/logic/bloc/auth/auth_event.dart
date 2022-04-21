part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

class AuthEventInit extends AuthEvent {
  final BuildContext context;
  AuthEventInit({required this.context}) : super();
}

class AuthEventRefresh extends AuthEvent {
  AuthEventRefresh() : super();
}

class AuthEventSignIn extends AuthEvent {
  final String email;
  final String password;
  AuthEventSignIn({required this.email, required this.password}) : super();
}

class AuthEventRePassword extends AuthEvent {}
