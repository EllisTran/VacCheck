import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/src/provider.dart';
import 'package:vaccheck/controller/auth_controller.dart';
import 'package:vaccheck/firebase/auth_service.dart';
import 'package:vaccheck/firebase/firebase_wrapper.dart';
import 'package:vaccheck/model/user_model.dart';
import 'package:vaccheck/views/auth_views/login_view.dart';
import 'package:vaccheck/views/user_views/main_user_view.dart';

class MainPageView extends StatelessWidget {
  MainPageView({Key? key}) : super(key: key);
  AuthController _authController = Get.find();

  @override
  Widget build(BuildContext context) {
    print("MAIN PAGE");
    final fbUser = context.watch<User?>();
    if (fbUser != null) {
      _authController.uid = fbUser.uid;
      return const MainUserView();
    }
    return const LoginView();
  }

  // getFbUserInfo(FirebaseWrapper fb, String uid) async {
  //   var userInfo = await fb.getFirestoreUser(uid);
  //   return userInfo;
  // }
}
