part of 'user_bloc.dart';

@immutable
abstract class UserState {}

class UserInitial extends UserState {}

class UserStateLoading extends UserState {}

class UserStateLoaded extends UserState {}

class UserStateEmpty extends UserState {}

class UserStateError extends UserState {}
