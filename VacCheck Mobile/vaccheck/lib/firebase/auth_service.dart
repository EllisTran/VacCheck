import 'package:firebase_auth/firebase_auth.dart';
import 'package:vaccheck/firebase/firebase_wrapper.dart';
import 'package:vaccheck/model/user_model.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth;
  final FirebaseWrapper _firebaseWrapper = FirebaseWrapper();
  AuthService(this._firebaseAuth);
  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  Future signIn({required String email, required String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return "Signed in";
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future signUp({required UserModel newUser, required String password}) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: newUser.email, password: password);
      _firebaseWrapper.addNewUser(newUser, password);
      return true;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }
}
