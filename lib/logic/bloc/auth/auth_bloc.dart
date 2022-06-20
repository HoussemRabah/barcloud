import 'package:barcloud/UI/screens/pages/home.dart';
import 'package:barcloud/UI/screens/pages/homeChef.dart';
import 'package:barcloud/logic/functions/navigation.dart';
import 'package:barcloud/repository/auth_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

import '../../../UI/screens/pages/homeAdmin.dart';
import '../../../UI/screens/pages/homeAgent.dart';
import '../../../UI/screens/pages/homeIng.dart';
import '../../../UI/screens/pages/login.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  BuildContext? context;
  AuthRepository authRepository = AuthRepository();
  AuthBloc({required this.context}) : super(AuthInitial()) {
    on<AuthEvent>((event, emit) async {
      if (event is AuthEventInit) {
        context = event.context;
      }
      if (event is AuthEventRefresh) {
        emit(AuthStateLoading());
        if (authRepository.user != null) emit(AuthStateDone());
      }

      if (event is AuthEventSignIn) {
        emit(AuthStateLoading());
        print(event.email);
        print(event.password);
        bool result = await authRepository.signIn(
            email: event.email, password: event.password);
        if (!result) {
          emit(AuthStateError(
              errorMessage: authRepository.errorMessage ?? "error 0"));
        } else {
          print(authRepository.user!.role.name);
          switch (authRepository.user!.role.name) {
            case "agent":
              newScreen(context!, HomeAgent());
              break;

            case "ing":
              newScreen(context!, HomeIng());
              break;

            case "chef":
              newScreen(context!, HomeChef());
              break;

            case "admin":
              newScreen(context!, HomeAdmin());
              break;
          }
        }
      }
    });
  }
}
