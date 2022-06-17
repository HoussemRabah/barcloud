part of 'datachamp_bloc.dart';

@immutable
abstract class DatachampState {}

class DatachampInitial extends DatachampState {}

class DatachampStateLoaded extends DatachampState {}

class DatachampStateLoading extends DatachampState {}

class DatachampStateError extends DatachampState {}
