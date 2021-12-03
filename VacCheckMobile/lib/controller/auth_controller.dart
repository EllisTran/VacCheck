import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vaccheck/model/user_models/user_model.dart';

class AuthController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TapGestureRecognizer tapGestureSignUpRecognizer = TapGestureRecognizer();
  TapGestureRecognizer tapGestureBusinessRecognizer = TapGestureRecognizer();
  static AuthController to = Get.find();
  late String uid;
  late UserModel currentUser;
}
