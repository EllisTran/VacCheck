import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
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
    authController.tapGestureSignUpRecognizer.dispose();
    authController.tapGestureBusinessRecognizer.dispose();
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
      
        constraints: const BoxConstraints.expand(),
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/backgroundScreen.png"),
                fit: BoxFit.cover)),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: size.height * 0.24),

                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                  SizedBox(width: size.width * 0.07),
                  SizedBox(
                    width: 50,
                    height: 50,
                    child: SvgPicture.asset(
                      "assets/logoVac.svg",
                      color: kPrimeColor,
                      ),
                  ),

                  SizedBox(width: size.width * 0.015),

                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: size.height * 0.016),
                      Row(
                        children: const <Widget>[
                          Text(
                          "Vac",
                          style: TextStyle(
                            color: kPrimeColor,
                            fontFamily: 'Roboto-Bold',
                            fontSize: 36)
                          ),
                          Text(
                          "Check",
                          style: TextStyle(
                            color: kPrimeColor,
                            fontFamily: 'Roboto-Light',
                            fontSize: 36)
                          ),
                          
                        ],
                      ),
                    ]
                  ),
                ],              
                ),
                
                SizedBox(height: size.height * 0.02),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 7),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
                    decoration: BoxDecoration(
                      color: kWhiteColor,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: kPrimeColor,)
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
                        border: InputBorder.none
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
                      border: Border.all(color: kPrimeColor,)
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
                SizedBox(height: size.height * 0.03),
                SizedBox(
                  width: size.width * 0.85,
                  height: size.height * 0.0657,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        elevation: 0,
                        splashFactory: NoSplash.splashFactory,
                        primary: kPrimeColor, // background
                        onPrimary: Colors.white, // foreground
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.all(Radius.circular(29)))),
                    onPressed: () {
                      context.read<AuthService>().signIn(
                        email: authController.emailController.text,
                        password: authController.passwordController.text);
                    },
                    child: const Text(
                        "Sign In",
                        style: TextStyle(
                          color: kWhiteColor,
                          fontFamily: "SF",
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                ),

                SizedBox(height: size.height * 0.015),

                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                      text: "Don't have an account? ",
                      style: const TextStyle(
                        color: kPrimeColor,
                        fontSize: 14,
                        fontFamily: 'SF',
                      ),
                      children: [
                        TextSpan(
                            text: " Sign Up",
                            recognizer: authController.tapGestureSignUpRecognizer
                              ..onTap = () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const SignUpView()),
                                );
                              },
                            style: const TextStyle(
                                color: kPrimeColor,
                                fontWeight: FontWeight.w800,
                                fontFamily: 'SF',
                                fontSize: 16))
                      ]),
                ),

                // TextButton(
                //   onPressed: () {
                //     Navigator.push(
                //       context,
                //       MaterialPageRoute(
                //           builder: (context) => const SignUpView()),
                //     );
                //   },
                //   child: const Text("Sign Up"),
                // ),

                // TextButton(
                //   onPressed: () {
                //     Navigator.push(
                //       context,
                //       MaterialPageRoute(builder: (context) => MainUserView()),
                //     );
                //   },
                //   child: const Text("Go to QR Gen Page"),
                // ),

                SizedBox(height: size.height * 0.04),

                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                      text: "Switch to Business ",
                      style: const TextStyle(
                        color: kWhiteColor,
                        fontSize: 16,
                        fontFamily: 'SF',
                        fontWeight: FontWeight.w800,
                      ),
                      recognizer: authController.tapGestureBusinessRecognizer
                        ..onTap = () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const MainBusinessView()),
                          );
                        },),
                ),

                // TextButton(
                //   onPressed: () {
                //     Navigator.push(
                //       context,
                //       MaterialPageRoute(
                //           builder: (context) => const MainBusinessView()),
                //     );
                //   },
                //   child: const Text("Go to Business View"),
                // ),
              ],
            ),
          ),
        
        ),
      ),
    );
  }
}
