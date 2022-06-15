part of 'zone_bloc.dart';

@immutable
abstract class ZoneState {}

class ZoneInitial extends ZoneState {}

class ZoneStateLoading extends ZoneState {}

class ZoneStateLoaded extends ZoneState {}

class ZoneStateEmpty extends ZoneState {}

class ZoneStateError extends ZoneState {}
