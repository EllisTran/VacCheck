import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/src/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:vaccheck/firebase/auth_service.dart';
import 'package:vaccheck/firebase/firebase_wrapper.dart';
import 'package:vaccheck/model/user_models/personal_user_model.dart';
import '../../controller/qr_code_controller.dart';
import 'package:vaccheck/constants.dart';
import 'package:intl/intl.dart';
import 'dart:math';

import '../show_bottom_view.dart';

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
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        foregroundColor: kWhiteColor,
        elevation: 0,
        title: Text(widget.user.name,
        style: const TextStyle(
                color: kWhiteColor,
                fontFamily: 'SF',
                fontSize: 22,
                fontWeight: FontWeight.w200,
              ),),
        actions: [
          IconButton(
            icon: const Icon(Icons.exit_to_app,size: 28,),
        
            onPressed: () {
              context.read<AuthService>().signOut();
            },
          ),
        ],
      ),
      body: Container(
        constraints: const BoxConstraints.expand(),
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/backgroundQR.png"),
                fit: BoxFit.cover)),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Text('Full Name: ${widget.user.name}'),
              // Text('Number of times vaccinated: ${widget.user.numVac}'),
              // Text('Date of Birth: ${widget.user.dateOfBirth}'),
              // const Text(
              //     'Insert Image here or somewhere around here'), // Do this*****

              SizedBox(height: size.height * 0.084),
              Stack(
                
                children: <Widget>[
                  Center(
                    child: SizedBox(
                        width: 300,
                        height: 300,
                        child: SvgPicture.asset(
                          "assets/qrBorder.svg",
                          color: kWhiteColor,
                          ),
                      ),
                  ),
                  Center(
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 6.5),
                      child: QrImage(
                      // This string will be pulled from cache
                      // This info, on signup, will be saved in cache so it can be accessed offline... don't know what to do about images tho... still thinking
                      data: generatedString,
                      version: QrVersions.auto,
                      size: 300 *0.95,
                      foregroundColor: kWhiteColor,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: size.height * 0.007),

              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text("$number",
                  style: const TextStyle(
                        color: kWhiteColor,
                        fontSize: 14,
                        fontFamily: 'SF',
                      ),
                    )
                ],
              ),

              Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(width: size.width * 0.10),

                Column(
                  children: [
                    SizedBox(height: size.height * 0.009),
                    TextButton(
                      onPressed: () {
                        generateNewNowTime(true);
                        },
                      style: ButtonStyle(
                      overlayColor: MaterialStateColor.resolveWith((states) => Colors.transparent),
                      ),
                      child: const Text("Generate QR",
                       style: TextStyle(
                            color: kWhiteColor,
                            fontSize: 14,
                            fontFamily: 'SF',
                            fontWeight: FontWeight.w700
                          ),
                        ),
                      ),
                  ],
                ),
                SizedBox(width: size.width * 0.39),

                ShowBottomSheet(
                  imageUrl: widget.user.imageUrl!,
                  fullName: widget.user.name,
                  dob: widget.user.dateOfBirth,
                  vacNum: widget.user.numVac!,
                 ),
              ]),
            ],
          ),
        ),
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
