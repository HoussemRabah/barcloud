import 'package:barcloud/modules/class.dart';
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
    db.authStateChanges().listen((User? user) {
      if (user == null) {
        this.user = null;
        signedOut();
      } else {
        this.user = TheUser(
            id: user.uid,
            nom: "rabah",
            prenom: "houssem",
            sub: "a kach 3afsa",
            role: Role.agent,
            user: user);
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
      }
  }
}
