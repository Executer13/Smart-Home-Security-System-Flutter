

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:testing/methods.dart';

class Noti extends StatefulWidget {
  @override
  _NotiState createState() => _NotiState();
}

class _NotiState extends State<Noti> {

  String token = '';
  final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

  @override
  void initState() {
    getToken();

   
    // workaround for onLaunch: When the app is completely closed (not in the background) and opened directly from the push notification
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
  RemoteNotification? notification = message.notification;
   print("onMessageData: $message");
  showSimpleBar(context, message.notification.toString());});

FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
  showSimpleBar(context, message.notification.toString());
  print("onMessageOpenedApp: $message");});



    super.initState();
  }
  
  void getToken() async {
    token = (await firebaseMessaging.getToken())!;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("Token : $token")),
      floatingActionButton: FloatingActionButton(onPressed: (){
        print(token);
      },
        child: Icon(Icons.print),
      ),
    );
  }

}