import 'dart:async';

import 'package:barcloud/modules/class.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../UI/screens/pages/login.dart';

part 'zone_event.dart';
part 'zone_state.dart';

class ZoneBloc extends Bloc<ZoneEvent, ZoneState> {
  List<Zone>? zones = [];
  ZoneBloc() : super(ZoneInitial()) {
    on<ZoneEvent>((event, emit) async {
      if (event is ZoneEventFetch) {
        emit(ZoneStateLoading());
        zones =
            await databaseRepository.getZones(authBloc.authRepository.user!.id);

        if (zones == null)
          emit(ZoneStateError());
        else
          emit(ZoneStateLoaded());
      }
    });
  }
}
