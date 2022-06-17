part of 'datachamp_bloc.dart';

@immutable
abstract class DatachampEvent {}

class DatachampEventFetch extends DatachampEvent {
  String itemTypeId;
  DatachampEventFetch({required this.itemTypeId}) : super();
}
