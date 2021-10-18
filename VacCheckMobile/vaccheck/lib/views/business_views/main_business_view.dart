import 'package:flutter/material.dart';
import '../business_views/qr_scan_view.dart';
import '../../controller/qr_code_controller.dart';

class MainBusinessView extends StatefulWidget {
  const MainBusinessView({keyy}) : super(key: keyy);

  @override
  State<MainBusinessView> createState() => _MainBusinessViewState();
}

class _MainBusinessViewState extends State<MainBusinessView> {
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
      ),
      body: Column(
        children: [
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const QRScanView()),
              );
            },
            child: const Text("Go to QR Scan"),
          ),
        ],
      ),
    );
  }
}
