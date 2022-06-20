part of 'event_bloc.dart';

@immutable
abstract class EventEvent {}

class EventEventFetch extends EventEvent {}

class EventEventRefresh extends EventEvent {}

class EventEventCreate extends EventEvent {
  BuildContext context;
  String title;
  String disc;
  String agentId;
  String adminId;
  String deadline;
  String type;
  String zoneId;
  EventEventCreate(
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
