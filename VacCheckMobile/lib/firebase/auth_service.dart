import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:vaccheck/controller/auth_controller.dart';
import 'package:vaccheck/firebase/firebase_wrapper.dart';
import 'package:vaccheck/model/user_models/personal_user_model.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth;
  final FirebaseWrapper _firebaseWrapper = FirebaseWrapper();
  final AuthController _authController = Get.find();
  AuthService(this._firebaseAuth);
  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  Future signIn({required String email, required String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      _authController.uid = _firebaseAuth.currentUser!.uid;
      await _firebaseWrapper.readUser();
      return "Signed in";
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future signUp(
      {required PersonalUserModel newUser, required String password}) async {
    try {
      String? email = "";
      if (newUser != null) {
        email = newUser.email;
      }
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      String? uid = _firebaseAuth.currentUser?.uid;
      _firebaseWrapper.addNewUser(newUser, password, uid);
      return true;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }
}
