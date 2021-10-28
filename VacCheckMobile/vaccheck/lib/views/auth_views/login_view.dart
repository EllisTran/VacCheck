import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/src/provider.dart'; // Don't remove this one
import 'package:vaccheck/controller/auth_controller.dart';
import 'package:vaccheck/firebase/auth_service.dart';
import 'package:vaccheck/firebase/firebase_wrapper.dart';
import 'package:vaccheck/views/auth_views/signup_view.dart';
import 'package:vaccheck/views/business_views/business_view.dart';
import 'package:vaccheck/views/user_views/user_view.dart';
import 'package:vaccheck/views/decider_view.dart';
import '../../controller/qr_code_controller.dart';

class LoginView extends StatefulWidget {
  const LoginView({keyy}) : super(key: keyy);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final authController = AuthController();
  final AuthController _auth = Get.find();
  final qrController = QRCodeController();
  late DateTime currentTime = DateTime.now();
  FirebaseWrapper fb = FirebaseWrapper();

  @override
  void dispose() {
    authController.emailController.dispose();
    authController.passwordController.dispose();
    super.dispose();
  }

  Future getUser() async {
    await fb.readUser();
    return _auth.currentUser;
  }

  @override
  Widget build(BuildContext context) {
    final fbUser = context.watch<User?>();
    if (fbUser != null) {
      _auth.uid = fbUser.uid;
      print(_auth.uid);
      return DeciderView(
        user: getUser(),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Firebase Authentication'),
        ),
        body: Column(
          children: [
            TextField(
              controller: authController.emailController,
              decoration: const InputDecoration(
                labelText: "Email",
              ),
            ),
            TextField(
              obscureText: true,
              controller: authController.passwordController,
              decoration: const InputDecoration(
                labelText: "Password",
              ),
            ),
            TextButton(
              onPressed: () {
                context.read<AuthService>().signIn(
                    email: authController.emailController.text,
                    password: authController.passwordController.text);
              },
              child: const Text("Sign In"),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SignUpView()),
                );
              },
              child: const Text("Sign Up"),
            ),
          ],
        ),
      );
    }
  }
}
