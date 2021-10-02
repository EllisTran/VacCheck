import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';

class FirebaseWrapper extends GetxController {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
}
