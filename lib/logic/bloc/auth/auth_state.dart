part of 'auth_bloc.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthStateLoading extends AuthState {}

class AuthStateError extends AuthState {
  final String errorMessage;
  AuthStateError({required this.errorMessage}) : super();
}

class AuthStateDone extends AuthState {}
