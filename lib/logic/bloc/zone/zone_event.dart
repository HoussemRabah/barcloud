part of 'zone_bloc.dart';

@immutable
abstract class ZoneEvent {}

class ZoneEventInit extends ZoneEvent {}

class ZoneEventFetch extends ZoneEvent {}
