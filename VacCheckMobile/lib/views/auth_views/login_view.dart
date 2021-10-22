import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/src/provider.dart'; // Don't remove this one
import 'package:vaccheck/constants.dart';
import 'package:vaccheck/controller/auth_controller.dart';
import 'package:vaccheck/firebase/auth_service.dart';
import 'package:vaccheck/firebase/firebase_wrapper.dart';
import 'package:vaccheck/views/auth_views/signup_view.dart';
import 'package:vaccheck/views/business_user_views/business_user_view.dart';
import 'package:vaccheck/views/personal_user_views/personal_user_view.dart';
import 'package:vaccheck/views/decider_view.dart';
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
  FirebaseWrapper fb = FirebaseWrapper();
  bool secureText = true;

  @override
  void dispose() {
    authController.emailController.dispose();
    authController.passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false, //make background image not moving
      // appBar: AppBar(
      //   title: const Text('Firebase Authentication'),
      // ),
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/splashScreen.jpg"),
                fit: BoxFit.cover)),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: size.height * 0.10),
                SizedBox(
                  width: 190,
                  height: 190,
                  child: SvgPicture.asset(
                    "assets/logoVac.svg",
                    color: kWhiteColor,
                  ),
                ),

                SizedBox(height: size.height * 0.08),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 7),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
                    decoration: BoxDecoration(
                      color: kWhiteColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextField(
                      style:
                          const TextStyle(color: kTextColor, fontFamily: "SF"),
                      controller: authController.emailController,
                      decoration: const InputDecoration(
                        hintText: "Email",
                        icon: Icon(
                          Icons.person,
                          color: kPrimaryColor,
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: size.height * 0.01),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 7),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
                    decoration: BoxDecoration(
                      color: kWhiteColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextField(
                      style:
                          const TextStyle(color: kTextColor, fontFamily: "SF"),
                      obscureText: secureText,
                      controller: authController.passwordController,
                      decoration: InputDecoration(
                        hintText: "Password",
                        icon: const Icon(
                          Icons.lock,
                          color: kPrimaryColor,
                        ),
                        suffixIcon: IconButton(
                          icon: secureText != true
                              ? Icon(Icons.visibility)
                              : Icon(Icons.visibility_off),
                          onPressed: () {
                            setState(() {
                              secureText = !secureText;
                            });
                          },
                          color: kPrimaryColor,
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: size.height * 0.04),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 134, vertical: 3),
                  decoration: BoxDecoration(
                    color: kWhiteColor,
                    borderRadius: BorderRadius.circular(29),
                  ),
                  child: TextButton(
                    onPressed: () {
                      context.read<AuthService>().signIn(
                          email: authController.emailController.text,
                          password: authController.passwordController.text);
                    },
                    child: const Text(
                      "Sign In",
                      style: TextStyle(
                        color: kPrimaryLightColor,
                        fontFamily: "SF",
                        fontSize: 17,
                        // fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SignUpView()),
                    );
                  },
                  child: const Text("Sign Up"),
                ),
                // TextButton(
                //   onPressed: () {
                //     Navigator.push(
                //       context,
                //       MaterialPageRoute(builder: (context) => MainUserView()),
                //     );
                //   },
                //   child: const Text("Go to QR Gen Page"),
                // ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MainBusinessView()),
                    );
                  },
                  child: const Text("Go to Business View"),
                ),
              ],
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
