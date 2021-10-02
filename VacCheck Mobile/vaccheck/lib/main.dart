import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import './firebase/firebase_wrapper.dart';

void main() async {
  await Firebase.initializeApp();

  // For local storage
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    return Container();
  }
}
