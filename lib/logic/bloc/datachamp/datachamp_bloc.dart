import 'package:barcloud/modules/class.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

import '../../../UI/screens/pages/login.dart';
import '../../../UI/screens/views/qrView.dart';
import '../../functions/navigation.dart';

part 'datachamp_event.dart';
part 'datachamp_state.dart';

class DatachampBloc extends Bloc<DatachampEvent, DatachampState> {
  List<DataChamp>? dataChamps = [];
  Map<String, TextEditingController> textcon = {};

  List<String> getDatas() {
    return [
      for (DataChamp d in dataChamps ?? [])
        (textcon[d.id] != null) ? textcon[d.id]!.text : ''
    ];
  }

  List<String> getChamps() {
    return [for (DataChamp d in dataChamps ?? []) d.id];
  }

  DatachampBloc() : super(DatachampInitial()) {
    on<DatachampEvent>((event, emit) async {
      if (event is DatachampEventFetch) {
        emit(DatachampStateLoading());
        dataChamps = await databaseRepository.getDataChamps(event.itemTypeId);

        if (dataChamps != null) {
          textcon.clear();
          for (DataChamp d in dataChamps!) {
            textcon[d.id] = TextEditingController();
          }
          emit(DatachampStateLoaded());
        } else
          emit(DatachampStateError());
      }
      if (event is DatachampEventCreate) {
        emit(DatachampStateLoading());
        String? result = await databaseRepository.addItem(
            event.zoneId,
            event.itemTypeId,
            datachampBloc.getDatas(),
            datachampBloc.getChamps());
        if (result != null) {
          newScreen(event.context, QrView(text: result));
        }

        emit(DatachampStateLoaded());
      }
    });
  }
}
