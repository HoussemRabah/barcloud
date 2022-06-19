part of 'datachamp_bloc.dart';

@immutable
abstract class DatachampEvent {}

class DatachampEventFetch extends DatachampEvent {
  String itemTypeId;
  DatachampEventFetch({required this.itemTypeId}) : super();
}

class DatachampEventCreate extends DatachampEvent {
  String itemTypeId;
  String zoneId;
  BuildContext context;
  DatachampEventCreate(
      {required this.itemTypeId, required this.zoneId, required this.context})
      : super();
}
