part of 'task_bloc.dart';

@immutable
abstract class TaskEvent {}

class TaskEventInit extends TaskEvent {}

class TaskEventFetch extends TaskEvent {}
