import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:testing/colors.dart';
import 'package:testing/home.dart';
import 'package:testing/notifications.dart';
import 'package:testing/schedules.dart';
import 'package:testing/settings.dart' as dtt;
import 'package:testing/upload.dart';

import 'methods.dart';

String s='';
  String token = '';
  final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
    final FirebaseAuth _auth = FirebaseAuth.instance;

 Future getToken() async {
    
    token = (await firebaseMessaging.getToken())!;
     FirebaseFirestore.instance.collection('DB').doc(_auth.currentUser!.uid).update({
          'deviceToken': token
        });


    
  }



class BottomNavBarV2 extends StatefulWidget {
  @override
  _BottomNavBarV2State createState() => _BottomNavBarV2State();
}

class _BottomNavBarV2State extends State<BottomNavBarV2> {
    var currentIndex = 0;
@override
  void initState() {
    // TODO: implement initState
    
    super.initState();
    getToken();




  
  
  




    // workaround for onLaunch: When the app is completely closed (not in the background) and opened directly from the push notification
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
  RemoteNotification? notification = message.notification;
   print("onMessageData: $message");
   FlutterRingtonePlayer.playNotification();
  alertbox(context, message.notification!.body,message.notification!.title,'images/alerts.gif');;});
//notifications for opened app
FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
  RemoteNotification? notification = message.notification;
  FlutterRingtonePlayer.playNotification();
  alertbox(context, message.notification!.body,message.notification!.title,'images/alerts.gif');
  print("onMessageOpenedApp: $message");});

FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message) {
      if (message != null) {
        FlutterRingtonePlayer.playNotification();
        alertbox(context, message.notification!.body,message.notification!.title,'images/alerts.gif');      }
    });







  }
 //navbar animation
 //big whit circle
  @override
  Widget build(BuildContext context) {
    double displayWidth = MediaQuery.of(context).size.width;
    return WillPopScope(onWillPop:  () => Future.value(false),
      child: Scaffold(
        body: _pages[currentIndex],
        bottomNavigationBar: Container(
          margin: EdgeInsets.all(displayWidth * .05),
          height: displayWidth * .155,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(.1),
                blurRadius: 30,
                offset: Offset(0, 10),
              ),
            ],
            borderRadius: BorderRadius.circular(50),
          ),
          child: ListView.builder(
            itemCount: 5,
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: displayWidth * .02),
            itemBuilder: (context, index) => InkWell(
              onTap: () {
                setState(() {
                  currentIndex = index;
                  HapticFeedback.lightImpact();
                });
              },
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              child: Stack(
                children: [
                  AnimatedContainer(
                    duration: Duration(seconds: 1),
                    curve: Curves.fastLinearToSlowEaseIn,
                    width: index == currentIndex
                        ? displayWidth * .32
                        : displayWidth * .18,
                    alignment: Alignment.center,
                    child: AnimatedContainer(
                      duration: Duration(seconds: 1),
                      curve: Curves.fastLinearToSlowEaseIn,
                      height: index == currentIndex ? displayWidth * .12 : 0,
                      width: index == currentIndex ? displayWidth * .32 : 0,
                      decoration: BoxDecoration(
                        color: index == currentIndex
                            ? tone .withOpacity(.2)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                  ),
                  
    
    
                  AnimatedContainer(
                    duration: Duration(seconds: 1),
                    curve: Curves.fastLinearToSlowEaseIn,
                    width: index == currentIndex
                        ? displayWidth * .31
                        : displayWidth * .18,
                    alignment: Alignment.center,
                    child: Stack(
                      children: [
                        Row(
                          children: [
                            AnimatedContainer(
                              duration: Duration(seconds: 1),
                              curve: Curves.fastLinearToSlowEaseIn,
                              width:
                                  index == currentIndex ? displayWidth * .13 : 0,
                            ),
                            AnimatedOpacity(
                              opacity: index == currentIndex ? 1 : 0,
                              duration: Duration(seconds: 1),
                              curve: Curves.fastLinearToSlowEaseIn,
                              child: Text(
                                index == currentIndex
                                    ? '${listOfStrings[index]}'
                                    : '',
                                style: TextStyle(
                                  color: tone ,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            AnimatedContainer(
                              duration: Duration(seconds: 1),
                              curve: Curves.fastLinearToSlowEaseIn,
                              width:
                                  index == currentIndex ? displayWidth * .03 : 20,
                            ),
                            Icon(
                              listOfIcons[index],
                              size: displayWidth * .076,
                              color: index == currentIndex
                                  ? tone 
                                  : Colors.black26,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<IconData> listOfIcons = [
    Icons.home_rounded,
    
    Icons.settings_rounded,
    Icons.face_rounded,
    Icons.notifications_none_rounded,
    Icons.trending_up_rounded
  ];

  List<String> listOfStrings = [
    'Home',
    'Settings',
    'Face',
    'Notifs',
    'Intrusion'
  ];


  final List<Widget> _pages = [
    Home(),
    dtt.Settings() ,
    ImageUploads(),
    Notifications(),
    Drawers()
  ];
}