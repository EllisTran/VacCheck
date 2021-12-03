import 'dart:async';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/src/provider.dart';
import 'package:vaccheck/controller/auth_controller.dart';
import 'package:vaccheck/firebase/firebase_wrapper.dart';
import 'package:vaccheck/views/auth_views/login_view.dart';
import 'package:vaccheck/constants.dart';
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
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final fbUser = context.watch<User?>();
    if (ready && fbUser != null) {
      _auth.uid = fbUser.uid;
      return DeciderView(user: getUser());
    } else if (ready && fbUser == null) {
      return const LoginView();
    } else {
      return Scaffold(
        body: Container(
          constraints: const BoxConstraints.expand(),
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/splashScreen.jpg"),
                  fit: BoxFit.cover)),
          child: SafeArea(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                SizedBox(height: size.height * 0.15),
                SizedBox(
                  width: 250,
                  height: 250,
                  child: SvgPicture.asset(
                    "assets/logoVac.svg",
                    color: kWhiteColor,
                  ),
                ),
                SizedBox(height: size.height * 0.05),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const <Widget>[
                    Text("Vac",
                        style: TextStyle(
                            color: kWhiteColor,
                            fontFamily: 'Roboto-Bold',
                            fontSize: 36)),
                    Text("Check",
                        style: TextStyle(
                            color: kWhiteColor,
                            fontFamily: 'Roboto-Thin',
                            fontSize: 36)),
                  ],
                ),
                SizedBox(height: size.height * 0.15),
                const CircularProgressIndicator(
                  color: Colors.white,
                )
              ])),
        ),
      );
    }
  }
}
