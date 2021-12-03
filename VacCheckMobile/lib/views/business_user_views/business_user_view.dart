import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:vaccheck/firebase/auth_service.dart';
import 'package:vaccheck/model/user_models/user_model.dart';
import '../business_user_views/qr_scan_view.dart';
import '../../controller/qr_code_controller.dart';
import 'package:vaccheck/constants.dart';

class BusinessUserView extends StatefulWidget {
  final UserModel user;
  const BusinessUserView({keyy, required this.user}) : super(key: keyy);

  @override
  State<BusinessUserView> createState() => _BusinessUserViewState();
}

class _BusinessUserViewState extends State<BusinessUserView> {
  final qrController = QRCodeController();
  @override
  void dispose() {
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
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
      body: const QRScanView()
    );
  }
}
