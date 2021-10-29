import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:vaccheck/controller/qr_code_controller.dart';
import 'package:vaccheck/firebase/firebase_wrapper.dart';
import 'package:vaccheck/model/user_model.dart';
import 'package:vaccheck/views/business_views/scanned_user.dart';

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
  String decryptedMessage = "";

  late String name;
  late String dateTime;
  late String numVac;
  late String userId;
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
    return Column(
      children: <Widget>[
        Expanded(
          flex: 1,
          child: Container(),
        ), // I think there is a better way to do this? I am not sure.. remove this and change flex on the the next expanded and youll know what i mean
        Expanded(
          flex: 5,
          child: SizedBox(
            width: MediaQuery.of(context).size.width * .90,
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
              overlay: QrScannerOverlayShape(),
            ),
          ),
        ),
        Expanded(flex: 1, child: Container()),
        Expanded(
          flex: 3,
          child: (result != null)
              ? Container(
                  color: Colors.white,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: [
                      Text('Name: $name'),
                      Text('Date of Birth: $dateTime'),
                      Text('Number of times Vaccinated: $numVac'),
                      ScannedUser(user: readScannedUser(userId)) // Gets image... maybe i need to move this im not sure yet
              
                    ],
                  ))
              : const Text('Scan a code'),
        ),
      ],
      // ),
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
          print(decryptedMessage);
          _parseMessage(decryptedMessage);
          readScannedUser(userId);
        }
      });
    });
  }

  void _parseMessage(String message) {
    String parsedMessage = "";

    for (var char in message.runes) {
      var character = String.fromCharCode(char);
      if (character == '&') {
        numVac = parsedMessage;
        parsedMessage = "";
      } else if (character == '+') {
        name = parsedMessage;
        parsedMessage = "";
      } else if (character == '%') {
        userId = parsedMessage;
        parsedMessage = "";
      } else if (character == '*') {
        dateTime = parsedMessage;
        parsedMessage = "";
      } else {
        parsedMessage = parsedMessage + character;
      }
      // print(parsedMessage);
    }
    print(name);
    print(numVac);
    print(userId);
    print(dateTime);
    // USE USERID TO query for specific document in database and then use that to display image.
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
