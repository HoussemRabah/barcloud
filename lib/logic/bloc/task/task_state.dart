part of 'task_bloc.dart';

@immutable
abstract class TaskState {}

class TaskInitial extends TaskState {}

class TaskStateLoading extends TaskState {}

class TaskStateLoaded extends TaskState {}

class TaskStateEmpty extends TaskState {}

class TaskStateError extends TaskState {}
