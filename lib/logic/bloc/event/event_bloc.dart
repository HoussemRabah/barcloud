import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../../../UI/screens/pages/login.dart';
import '../../../modules/class.dart';

part 'event_event.dart';
part 'event_state.dart';

class EventBloc extends Bloc<EventEvent, EventState> {
  List<Event>? events = [];
  EventBloc() : super(EventInitial()) {
    on<EventEvent>((event, emit) async {
      if (event is EventEventRefresh) {
        emit(EventStateLoading());

        emit(EventStateLoaded());
      }
      if (event is EventEventFetch) {
        emit(EventStateLoading());
        events = await databaseRepository.getEvents();

        if (events != null) {
          emit(EventStateLoaded());
        } else if (events == [])
          emit(EventStateEmpty());
        else
          emit(EventStateError());
      }
    });
  }
}
