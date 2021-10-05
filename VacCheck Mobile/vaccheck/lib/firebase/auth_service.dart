import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth;

  AuthService(this._firebaseAuth);
  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  Future signIn({String email = '', String password = ''}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: 'test@test.com', password: 'password');
      print("Signed in");
      return "Signed in";
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future signUp({String email = '', String password = ''}) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: 'test2@test.com', password: 'password');
      return "sign up!";
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }
}
