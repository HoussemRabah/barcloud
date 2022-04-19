import 'package:barcloud/modules/class.dart';
import 'package:barcloud/repository/database_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  FirebaseAuth db = FirebaseAuth.instance;
  TheUser? user;
  String? errorMessage;

  Future<bool> signIn({required String email, required String password}) async {
    try {
      await db.signInWithEmailAndPassword(email: email, password: password);
      return true;
    } on FirebaseAuthException catch (e) {
      handleError(e.code);
      return false;
    }
  }

  authListen({required Function signedOut, required Function signedIn}) {
    db.authStateChanges().listen((User? user) async {
      if (user == null) {
        this.user = null;
        signedOut();
      } else {
        Map userData = await DatabaseRepository().getMap("/user/${user.uid}/");
        this.user = DatabaseRepository().fromMapTheUser(userData, user);
        signedIn();
      }
    });
  }

  handleError(String? code) {
    if (code == null)
      errorMessage = null;
    else
      switch (code) {
        case 'user-not-found':
          errorMessage = "No user found for that email";
          break;
        default:
          errorMessage = code;
      }
  }
}
