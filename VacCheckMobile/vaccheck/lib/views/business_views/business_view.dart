import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:vaccheck/firebase/auth_service.dart';
import 'package:vaccheck/model/user_model.dart';
import '../business_views/qr_scan_view.dart';
import '../../controller/qr_code_controller.dart';

class BusinessView extends StatefulWidget {
  final UserModel user;
  const BusinessView({keyy, required this.user}) : super(key: keyy);

  @override
  State<BusinessView> createState() => _BusinessViewState();
}

class _BusinessViewState extends State<BusinessView> {
  final qrController = QRCodeController();
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Main Business View'),
        actions: [
          IconButton(
              onPressed: () {
                context.read<AuthService>().signOut();
              },
              icon: const Icon(Icons.exit_to_app))
        ],
      ),
      body: Column(
        children: [
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const QRScanView()),
              );
            },
            child: const Text("Go to QR Scan"),
          ),
        ],
      ),
    );
  }
}
