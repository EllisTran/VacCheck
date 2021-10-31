import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:vaccheck/firebase/auth_service.dart';
import 'package:vaccheck/firebase/firebase_wrapper.dart';
import 'package:vaccheck/model/user_models/personal_user_model.dart';
import '../../controller/qr_code_controller.dart';
import 'dart:math';

class PersonalUserView extends StatefulWidget {
  final PersonalUserModel user;
  const PersonalUserView({Key? key, required this.user}) : super(key: key);

  @override
  State<PersonalUserView> createState() => _PersonalUserViewState();
}

class _PersonalUserViewState extends State<PersonalUserView> {
  final qrController = QRCodeController();
  FirebaseWrapper fb = FirebaseWrapper();
  late DateTime currentTime = DateTime.now();
  int number = 0;
  String generatedString = "";
  String generatedCode = "";
  Timer? timer;
  int prevRandNum = -1;
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
          const Text(
              'Insert Image here or somewhere around here'), // Do this*****
          QrImage(
            // This string will be pulled from cache
            // This info, on signup, will be saved in cache so it can be accessed offline... don't know what to do about images tho... still thinking
            data: generatedString,
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

  String generateCode() {
    PersonalUserModel currentUser = widget.user;
    int MIN = 0;
    int MAX = 5;

    Random rand = Random();
    int randomNumber = (rand.nextInt(MAX) + MIN);
    if (randomNumber == prevRandNum) {
      randomNumber = (rand.nextInt(MAX) + MIN);
    }
    prevRandNum = randomNumber;
    if (randomNumber == 0) {
      generatedCode =
          "${currentUser.numVac}&${currentUser.name}+${currentUser.userId}%$currentTime^${currentUser.dateOfBirth}*";
    } else if (randomNumber == 1) {
      generatedCode =
          "${currentUser.name}+${currentUser.userId}%$currentTime^${currentUser.dateOfBirth}*${currentUser.numVac}&";
    } else if (randomNumber == 2) {
      generatedCode =
          "${currentUser.userId}%$currentTime^${currentUser.dateOfBirth}*${currentUser.numVac}&${currentUser.name}+";
    } else if (randomNumber == 3) {
      generatedCode =
          "$currentTime^${currentUser.dateOfBirth}*${currentUser.numVac}&${currentUser.name}+${currentUser.userId}%";
    } else if (randomNumber == 4) {
      generatedCode =
          "${currentUser.dateOfBirth}${currentUser.numVac}&${currentUser.name}+${currentUser.userId}%*$currentTime^";

    }
    return generatedCode;
  }
}
