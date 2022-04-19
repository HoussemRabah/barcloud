import 'package:barcloud/repository/auth_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthRepository authRepository = AuthRepository();
  AuthBloc() : super(AuthInitial()) {
    on<AuthEvent>((event, emit) async {
      if (event is AuthEventInit) {
        authRepository.authListen(signedOut: () {
          print("out");
        }, signedIn: () {
          print("in");
          print(authRepository.user.toString());
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
