
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import 'package:testing/colors.dart';

import 'package:testing/userCheck.dart';






 String s='';
  String token = '';
  final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
    final FirebaseAuth _auth = FirebaseAuth.instance;


 








Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  print("it is done");



  
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
    Color _primaryColor = tone;
  Color _accentColor = Colors.blueAccent;
  // This widget is the root of your application.


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: _primaryColor,
        accentColor: _accentColor,
        scaffoldBackgroundColor: Colors.grey.shade100,
        fontFamily: 'Roboto-Regular'
      ),
      debugShowCheckedModeBanner: false,
      home: VerifyCheck(),
    );
  }
}


