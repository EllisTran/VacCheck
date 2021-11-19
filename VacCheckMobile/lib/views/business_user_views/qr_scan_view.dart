import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:vaccheck/constants.dart';
import 'package:vaccheck/controller/qr_code_controller.dart';
import 'package:vaccheck/firebase/firebase_wrapper.dart';
import 'package:vaccheck/model/user_models/personal_user_model.dart';
import 'package:vaccheck/model/user_models/user_model.dart';
import 'package:vaccheck/views/business_user_views/scanned_user.dart';
import 'package:intl/intl.dart';

import '../show_bottom_view.dart';

class QRScanView extends StatefulWidget {
  const QRScanView(
      {Key? key, void Function(QRViewController controller)? onQRViewCreated})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _QRScanViewState();
}

class _QRScanViewState extends State<QRScanView> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  late QRViewController controller;
  QRCodeController qrCodeController = QRCodeController();
  Map<String, dynamic> decryptedMessage = {};

  String? name;
  String? dateTime;
  DateTime? dateOfBirth;
  String? numVac;
  String? userId;
  String? isValidCode;
  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller.pauseCamera();
    } else if (Platform.isIOS) {
      controller.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      constraints: const BoxConstraints.expand(),
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/backgroundScreenbuscus.png"),
              fit: BoxFit.cover)),
      child: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(flex: 1, child: Container()),
            // Expanded(flex: 0, child: Container(color: Colors.blue)),

            Expanded(
              flex: 5,
              child: Stack(alignment: Alignment.center, children: [
                //debug
                // Container(
                //     width: MediaQuery.of(context).size.width,
                //     color: Colors.pink),
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
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * .68,
                    height: MediaQuery.of(context).size.height * 0.34,
                    child: QRView(
                      key: qrKey,
                      onQRViewCreated: _onQRViewCreated,
                      // overlay: QrScannerOverlayShape(borderColor: kWhiteColor),
                    ),
                  ),
                ),
              ]),
            ),
            Expanded(flex: 1, child: Container()),
            Expanded(
              flex: 3,
              child: (result != null)
                  ? Container(
                      color: Colors.white,
                      width: MediaQuery.of(context).size.width,
                      child: (isValidCode == "true")
                          ? ShowBottomSheet(
                                  imageUrl: userId!,
                                  fullName: name!,
                                  dob: dateOfBirth!,
                                  vacNum: int.parse(numVac!),
                                )
                            //      Column(
                            //   children: [
                                
                            //     // Text('Name: $name'),
                            //     // Text('Date of Birth: $dateOfBirth'),
                            //     // Text('Number of times Vaccinated: $numVac'),
                            //     // ScannedUser(
                            //     //     user:
                            //     //         readScannedUser(userId!)) // Gets image
                            //   ],
                            // )
                          : const Center(child: Text("Invalid Code!")))
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        Text(
                          "Searching...",
                          style: TextStyle(
                              color: kWhiteColor,
                              fontSize: 18,
                              fontFamily: 'SF',
                              fontWeight: FontWeight.w700),
                        ),
                        SizedBox(height: 5),
                        Padding(
                          padding: EdgeInsets.only(right: 3),
                          child: Text(
                            "please put QR code under the camera",
                            style: TextStyle(
                              color: kWhiteColor,
                              fontSize: 14,
                              fontFamily: 'SF',
                            ),
                          ),
                        ),
                      ],
                    ),
            ),

          ],
          // ),
        ),
      ),
    );
  }

  Future readScannedUser(String uid) async {
    // Make the Future into its own component and then scan
    FirebaseWrapper fb = FirebaseWrapper();
    UserModel scannedUser = await fb.readUserById(uid);
    return scannedUser;
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
        if (result != null) {
          decryptedMessage = qrCodeController.decryptString(result!.code);
          _parseMessage(decryptedMessage);
          if (userId != null) {
            readScannedUser(userId!);
          }
        }
      });
    });
  }

  void _parseMessage(Map<String, dynamic> parsedMessage) {
    name = parsedMessage['name'];
    numVac = parsedMessage['numVac'];
    userId = parsedMessage['UUID'];
    dateTime = parsedMessage['dateTime'];
    dateOfBirth = parsedMessage['dateOfBirth'];
    isValidCode = parsedMessage['isValidCode'];
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
