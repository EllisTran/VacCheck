import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:vaccheck/model/user_model.dart';

class FirebaseWrapper extends GetxController {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  Future test() async {
    var documentRef = await _db.collection('users').add({'name': 'test'});
    var createdId = documentRef.id;
    _db.collection('users').doc(createdId).update(
      {'user_id': createdId},
    );
  }

  Future addNewUser(UserModel newUser, String password) async {
    var documentRef = await _db.collection('users').add({
      'name': newUser.name,
      'email': newUser.email,
      'ssn': newUser.ssn,
      'dateOfBirth': newUser.dateOfBirth,
      'address': newUser.address
    });
    var createdId = documentRef.id;
    _db.collection('users').doc(createdId).update({
      'user_id': createdId,
    });
  }
}
