import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/src/provider.dart';
import 'package:vaccheck/controller/auth_controller.dart';
import 'package:vaccheck/firebase/firebase_wrapper.dart';
import 'package:vaccheck/views/auth_views/login_view.dart';

import '../decider_view.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final AuthController _auth = Get.find();
  Timer? timer;
  FirebaseWrapper fb = FirebaseWrapper();
  bool ready = false;
  
  Future getUser() async {
    await fb.readUser();
    return _auth.currentUser;
  }

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(
        const Duration(seconds: 5),
        (Timer t) => {
              setState(() {
                ready = true;
              })
            });
  }

  @override
  Widget build(BuildContext context) {
    final fbUser = context.watch<User?>();
    if (ready && fbUser != null) {
      _auth.uid = fbUser.uid;
      return DeciderView(user: getUser());
    } else if (ready && fbUser == null) {
      return const LoginView();
    } else {
      return Container(
        color: Colors.blue,
        child: Column(
          children: [
            const Spacer(),
            const Text(
              "VacCheck",
              style: TextStyle(color: Colors.white),
            ), // i honestly have no idea why there are lines here im so confused lol
            const Spacer(),
            Image.asset('lib/assets/card.png'),
            const Spacer(),
            const CircularProgressIndicator(
              color: Colors.white,
            )
          ],
        ),
      );
    }
  }
}
