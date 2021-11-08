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
       
            Expanded(
              flex: 5,
              child: SizedBox(
                width: MediaQuery.of(context).size.width * .90,
                child: QRView(
                  key: qrKey,
                  onQRViewCreated: _onQRViewCreated,
                  overlay: QrScannerOverlayShape(borderColor: kWhiteColor),
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
                      child: (isValidCode == "true")
                          ? Column(
                              children: [
                                Text('Name: $name'),
                                Text('Date of Birth: $dateOfBirth'),
                                Text('Number of times Vaccinated: $numVac'),
                                ScannedUser(
                                user: readScannedUser(
                                    userId!)) // Gets image
                              ],
                            )
                          : const Center(child: Text("Invalid Code!")))
                  : Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      Text("Searching...",style: 
                            TextStyle(
                              color: kWhiteColor,
                              fontSize: 18,
                              fontFamily: 'SF',
                              fontWeight: FontWeight.w700
                            ),
                      ),
                      SizedBox(height: 5),
                      Padding(
                        padding: EdgeInsets.only(right: 3),
                        child: Text("please put QR code under the camera",
                        style: 
                        TextStyle(
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

  void showBottomSheet(context, String name, DateTime dob, String numVac){
  Size size = MediaQuery.of(context).size;
  String formattedDate = DateFormat.yMMMMd('en_US').format(dob);
  showModalBottomSheet(
    shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.vertical(
      top: Radius.circular(20),
    ),
  ),
  isDismissible: true,
  context: context,
  builder: (BuildContext bc) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              const Text(
                "Information",
                style: TextStyle(
                  color: kPrimeColor,
                  fontFamily: 'SF',
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const Spacer(),
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.cancel_outlined,
                  color: kPrimeColor,
                  size: 25,
                ),
              ),
            ],
          ),

          // Container(
          //   width: 100.0,
          //   height: 100.0,
          //   decoration: BoxDecoration(
          //       shape: BoxShape.circle,
          //       image: DecorationImage(
          //           fit: BoxFit.fitWidth,
          //           image: NetworkImage(this.imageUrl!)))
          // ),
          // const SizedBox(
          //   height: 27,
          // ),

          // Padding(
          //   padding: const EdgeInsets.only(right: 13),
          //   child: Container(
          //     height: 10,
          //     width: MediaQuery.of(context).size.width,
          //     color: kBorderColor,
          //   ),
          // ),
          // const SizedBox(
          //   height: 20,
          // ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.only(bottom: 10),
                child: const Text(
                  "Full Name:",
                  style: TextStyle(
                    color: kTextColor,
                    fontFamily: 'SF',
                    fontSize: 14,
                    fontWeight: FontWeight.w200,
                  ),
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.only(bottom: 10, right: 14),
                child: Text(
                  name,
                  style: const TextStyle(
                    color: kTextColor,
                    fontFamily: 'SF',
                    fontSize: 14,
                    fontWeight: FontWeight.w200,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.only(bottom: 10),
                child: const Text(
                  "Date of Birth:",
                  style: TextStyle(
                    color: kTextColor,
                    fontFamily: 'SF',
                    fontSize: 14,
                    fontWeight: FontWeight.w200,
                  ),
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.only(bottom: 10, right: 14),
                child: Text(
                  formattedDate,
                  style: const TextStyle(
                    color: kTextColor,
                    fontFamily: 'SF',
                    fontSize: 14,
                    fontWeight: FontWeight.w200,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.only(bottom: 10),
                child: const Text(
                  "Vaccinated:",
                  style: TextStyle(
                    color: kTextColor,
                    fontFamily: 'SF',
                    fontSize: 14,
                    fontWeight: FontWeight.w200,
                  ),
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.only(bottom: 10, right: 16),
                child: Text(
                  numVac,
                  style: const TextStyle(
                    color: kPrimeColor,
                    fontFamily: 'SF',
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  });
  }
}


