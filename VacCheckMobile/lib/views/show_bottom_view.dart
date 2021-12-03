import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/src/provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:vaccheck/firebase/auth_service.dart';
import 'package:vaccheck/firebase/firebase_wrapper.dart';
import 'package:vaccheck/model/user_models/personal_user_model.dart';
import '../../controller/qr_code_controller.dart';
import 'package:vaccheck/constants.dart';
import 'package:intl/intl.dart';
import 'dart:math';

class ShowBottomSheet extends StatelessWidget {
  final String imageUrl;
  final String fullName;
  final DateTime dob;
  final int vacNum;

  const ShowBottomSheet(
      {Key? key,
      required this.imageUrl,
      required this.fullName,
      required this.dob,
      required this.vacNum})
      : super(key: key);

  showBottomSheet(context) {
    Size size = MediaQuery.of(context).size;
    // String formattedDate = DateFormat.yMMMMd('en_US').format(this.dob);

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
          
          Container(
              width: 100.0,
              height: 100.0,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      fit: BoxFit.fitWidth,
                      image: NetworkImage(this.imageUrl!)))),
          const SizedBox(
            height: 27,
          ),
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
                  this.fullName,
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
                  this.dob.toString(),
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
                  "${this.vacNum}",
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
  }

  test(BuildContext context) {
    print('in here');
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    String formattedDate = DateFormat.yMMMMd('en_US').format(dob);
    // print('hello world');
    return showBottomSheet(context);
  }
}
