import 'package:barcloud/modules/class.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

import '../../../UI/screens/pages/login.dart';

part 'datachamp_event.dart';
part 'datachamp_state.dart';

class DatachampBloc extends Bloc<DatachampEvent, DatachampState> {
  List<DataChamp>? dataChamps = [];
  Map<String, TextEditingController> textcon = {};

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
    });
  }
}
