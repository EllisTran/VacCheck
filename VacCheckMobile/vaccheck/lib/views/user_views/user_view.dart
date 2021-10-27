import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:vaccheck/firebase/auth_service.dart';
import 'package:vaccheck/firebase/firebase_wrapper.dart';
import 'package:vaccheck/model/user_model.dart';
import '../../controller/qr_code_controller.dart';

class UserView extends StatefulWidget {
  final UserModel user;
  const UserView({Key? key, required this.user}) : super(key: key);

  @override
  State<UserView> createState() => _UserViewState();
}

class _UserViewState extends State<UserView> {
  final qrController = QRCodeController();
  FirebaseWrapper fb = FirebaseWrapper();
  late DateTime currentTime = DateTime.now();
  int number = 0;
  String generatedString = "";
  Timer? timer;

  @override
  void initState() {
    super.initState();
    generatedString = qrController.encryptString(generateCode());
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
        generatedString = qrController.encryptString(generateCode());
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
        title: Text('${widget.user.name}'),
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
          Text('Full Name: ${widget.user.name}'),
          Text('Number of times vaccinated: ${widget.user.numVac}'),
          Text('Date of Birth: ${widget.user.dateOfBirth}'),
          const Text('Insert Image here or somewhere around here'), // Do this*****
          QrImage(
            // This string will be pulled from cache
            // This info, on signup, will be saved in cache so it can be accessed offline... don't know what to do about images tho... still thinking
            data: generatedString,
            version: QrVersions.auto,
            size: 320,
          ),
          // Text(generateCode()),
          // Text(qrController.encryptString(generateCode())),
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
    UserModel currentUser = widget.user;
    String generatedCode =
        "${currentUser.numVac}&${currentUser.name}+${currentUser.userId}%$currentTime";
    print("Generated Code (pre encrypted) $generatedCode");
    return generatedCode;
  }
}
