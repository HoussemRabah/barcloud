import 'package:barcloud/UI/screens/pages/home.dart';
import 'package:barcloud/logic/functions/navigation.dart';
import 'package:barcloud/repository/auth_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

import '../../../UI/screens/pages/login.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  BuildContext? context;
  AuthRepository authRepository = AuthRepository();
  AuthBloc({required this.context}) : super(AuthInitial()) {
    on<AuthEvent>((event, emit) async {
      if (event is AuthEventInit) {
        authRepository.authListen(signedOut: () {
          if (context != null) newScreen(context!, LoginScreen());
        }, signedIn: () {
          if (context != null) newScreen(context!, HomeScreen());
        });
      }

      if (event is AuthEventSignIn) {
        emit(AuthStateLoading());
        bool result = await authRepository.signIn(
            email: event.email, password: event.password);
        if (!result) {
          emit(AuthStateError(
              errorMessage: authRepository.errorMessage ?? "error 0"));
        }
      }
    });
  }
}
