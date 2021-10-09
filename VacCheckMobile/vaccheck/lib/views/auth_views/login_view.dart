import 'dart:async';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/src/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:vaccheck/controller/auth_controller.dart';
import 'package:vaccheck/firebase/auth_service.dart';
import 'package:vaccheck/views/auth_views/signup_view.dart';
import '../qr_view.dart';
import '../../controller/qr_code_controller.dart';

class LoginView extends StatefulWidget {
  const LoginView({keyy}) : super(key: keyy);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final authController = AuthController();
  final qrController = QRCodeController();
  late DateTime currentTime = DateTime.now();
  int number = 0;

  Timer? timer;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(
        const Duration(seconds: 1), (Timer t) => generateNewNowTime(false));
  }

  @override
  void dispose() {
    timer?.cancel();
    authController.emailController.dispose();
    authController.passwordController.dispose();
    super.dispose();
  }

  void generateNewNowTime(bool clickedButton) {
    setState(() {
      if (number == 15 || clickedButton) {
        currentTime = DateTime.now();
        number = 0;
      } else {
        number += 1;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
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
                MaterialPageRoute(builder: (context) => SignUpView()),
              );
            },
            child: const Text("Sign Up"),
          ),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => QRView()),
              );
            },
            child: const Text("Scan Code"),
          ),
          QrImage(
            // This string will be pulled from cache
            // This info, on signup, will be saved in cache so it can be accessed offline... don't know what to do about images tho... still thinking
            data: qrController.encryptString(
                "2&EllisTran+87fsd89790ds78fd90sf7ds89huH%$currentTime"),
            version: QrVersions.auto,
            size: 320,
          ),
          TextButton(
            onPressed: () {
              generateNewNowTime(true);
            },
            child: const Text("Generate New Code"),
          ),
          Text("$number"),
        ],
      ),
    );
  }
}
