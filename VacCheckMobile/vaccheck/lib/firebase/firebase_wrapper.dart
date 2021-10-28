import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:vaccheck/controller/auth_controller.dart';
import 'package:vaccheck/firebase/auth_service.dart';
import 'package:vaccheck/model/user_model.dart';
import 'package:flutter/material.dart';

// Import the firebase_core and cloud_firestore plugin
import 'package:firebase_core/firebase_core.dart';

class FirebaseWrapper extends GetxController {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  AuthController _auth = Get.find();

  Future addNewUser(UserModel newUser, String password, String? uid) async {
    await _db.collection('users').doc(uid).set({
      'name': newUser.name,
      'email': newUser.email,
      'dateOfBirth': newUser.dateOfBirth,
      'numVac': 0,
      'userType': {
        'isBusiness': false,
        'isPersonalUser': true,
        'isHealthProfessional': false
      },
      'userId': uid
    });
  }

  Future readUser() async {
    var document = _db.collection('users');
    await document.doc(_auth.uid).get().then((data) => {
          if (data['userType']['isPersonalUser'])
            {
              _auth.currentUser = UserModel.UserMap(data),
            }
            else {
              _auth.currentUser = UserModel.BusinessMap(data)
            },
        });
  }
}
