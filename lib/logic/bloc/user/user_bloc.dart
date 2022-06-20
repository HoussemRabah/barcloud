import 'package:barcloud/modules/class.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../UI/screens/pages/login.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  List<TheUser>? users = [];
  UserBloc() : super(UserInitial()) {
    on<UserEvent>((event, emit) async {
      if (event is UserEventFetch) {
        emit(UserStateLoading());
        users = await databaseRepository.getAllUsers();

        if (users != null) {
          emit(UserStateLoaded());
        } else if (users == [])
          emit(UserStateEmpty());
        else
          emit(UserStateError());
      }
    });
  }
}
