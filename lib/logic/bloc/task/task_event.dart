part of 'task_bloc.dart';

@immutable
abstract class TaskEvent {}

class TaskEventInit extends TaskEvent {}

class TaskEventFetch extends TaskEvent {}

class TaskEventRefresh extends TaskEvent {}

class TaskEventCreate extends TaskEvent {
  BuildContext context;
  String title;
  String disc;
  String agentId;
  String adminId;
  String deadline;
  String type;
  String zoneId;
  TaskEventCreate(
      {required this.title,
      required this.context,
      required this.disc,
      required this.agentId,
      required this.adminId,
      required this.deadline,
      required this.type,
      required this.zoneId})
      : super();
}
