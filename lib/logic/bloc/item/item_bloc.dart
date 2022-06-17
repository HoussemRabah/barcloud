import 'package:barcloud/modules/class.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../UI/screens/pages/login.dart';

part 'item_event.dart';
part 'item_state.dart';

class ItemBloc extends Bloc<ItemEvent, ItemState> {
  List<ItemData>? data = [];

  ItemBloc() : super(ItemInitial()) {
    on<ItemEvent>((event, emit) async {
      if (event is ItemEventFetch) {
        emit(ItemStateLoading());
        data = await databaseRepository.getItemData(event.itemId);

        if (data != null)
          emit(ItemStateLoaded());
        else
          emit(ItemStateError());
      }
    });
  }
}
