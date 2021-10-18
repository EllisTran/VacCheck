import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:provider/src/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:vaccheck/controller/auth_controller.dart';
import 'package:vaccheck/firebase/auth_service.dart';
import 'package:vaccheck/firebase/firebase_wrapper.dart';
import 'package:vaccheck/model/user_model.dart';
import 'package:vaccheck/views/auth_views/signup_view.dart';
import '../business_views/qr_scan_view.dart';
import '../../controller/qr_code_controller.dart';

class MainUserView extends StatefulWidget {
  const MainUserView({Key? key}) : super(key: key);

  @override
  State<MainUserView> createState() => _MainUserViewState();
}

class _MainUserViewState extends State<MainUserView> {
  final qrController = QRCodeController();
  FirebaseWrapper fb = FirebaseWrapper();
  AuthController _auth = Get.find();
  late DateTime currentTime = DateTime.now();
  int number = 0;

  Timer? timer;

  @override
  void initState() {
    super.initState();
    fb.readUser();
    timer = Timer.periodic(
        const Duration(seconds: 1), (Timer t) => generateNewNowTime(false));
  }

  @override
  void dispose() {
    timer?.cancel();
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
        title: const Text('Main User View'),
        actions: [
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: () {
              context.read<AuthService>().signOut();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          QrImage(
            // This string will be pulled from cache
            // This info, on signup, will be saved in cache so it can be accessed offline... don't know what to do about images tho... still thinking
            data: qrController.encryptString(generateCode()),
            version: QrVersions.auto,
            size: 320,
          ),
          Text(generateCode()),
          Text(qrController.encryptString(generateCode())),
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

  String generateCode() {
    UserModel currentUser = _auth.currentUser;
    String generatedCode =
        "${currentUser.numVac}&${currentUser.name}+${currentUser.userId}%$currentTime";
    return generatedCode;
  }
}
