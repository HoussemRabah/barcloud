part of 'event_bloc.dart';

@immutable
abstract class EventState {}

class EventInitial extends EventState {}

class EventStateLoaded extends EventState {}

class EventStateLoading extends EventState {}

class EventStateError extends EventState {}
class EventStateEmpty extends EventState {}
