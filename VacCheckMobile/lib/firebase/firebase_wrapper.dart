import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:vaccheck/controller/auth_controller.dart';
import 'package:vaccheck/firebase/auth_service.dart';
import 'package:flutter/material.dart';

// Import the firebase_core and cloud_firestore plugin
import 'package:firebase_core/firebase_core.dart';
import 'package:vaccheck/model/user_models/business_user_model.dart';
import 'package:vaccheck/model/user_models/personal_user_model.dart';

class FirebaseWrapper extends GetxController {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final AuthController _auth = Get.find();

  Future addNewUser(PersonalUserModel newUser, String password, String? uid) async {
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
      'imageUrl': 'https://firebasestorage.googleapis.com/v0/b/vaccheck-6a24b.appspot.com/o/avatar_115.jpg?alt=media&token=75c1e503-8269-4e17-9e5f-4c1ac99e5801',
      'userId': uid
    });
  }

  Future readUser() async {
    var document = _db.collection('users');
    await document.doc(_auth.uid).get().then((data) => {
          if (data['userType']['isPersonalUser'])
            {
              _auth.currentUser = PersonalUserModel.personalUserMap(data),
            }
          else
            { _auth.currentUser = BusinessUserModel.businessMap(data)},
        });
  }

  Future readUserById(String uid) async {
    var document = _db.collection('users');
    var user;
    await document.doc(uid).get().then((data) => {
          user = PersonalUserModel.personalUserMap(data),
        });
    return user;
  }
}
