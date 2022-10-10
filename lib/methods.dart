import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:giffy_dialog/giffy_dialog.dart';
import 'package:testing/colors.dart';
import 'package:testing/constants.dart';
import 'package:testing/home.dart';
import 'package:testing/skelton.dart';
import 'package:testing/smart/login_page.dart';

import 'package:testing/userCheck.dart';


FirebaseAuth _auth = FirebaseAuth.instance;
void showSnackBar(BuildContext context, String str) {
  final Scaffold = ScaffoldMessenger.of(context);
  Scaffold.showSnackBar(SnackBar(
    content: Text(str),
    action: SnackBarAction(
      label: "LOGIN",
      onPressed: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (_) => LoginPage()));
      },
    ),
  ));
}


void showSimpleBar(BuildContext context, String str) {
  final Scaffold = ScaffoldMessenger.of(context);
  Scaffold.showSnackBar(SnackBar(
    content: Text(str),
    ));
}




Future<UserCredential?> createAccount(BuildContext context,String email, String password,String RSTP,String name) async {

sucess() async {


      Navigator.of(context).pop();
     alertbox(context,'Verification Email Sent',
                    "Email Verification Sent, Please verify the Email First",'images/mail-verification.gif');

}

failure(String e){


   Navigator.of(context).pop();
     alertbox(context, 'Signup Failed', e, 'images/alerts.gif');
     return null;
}





  try {
    
    UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);

    userCredential.user?.sendEmailVerification();

    final CollectionReference users =
      FirebaseFirestore.instance.collection('DB');
  
    Map<String, dynamic> g = {
      "email": email,
      "Pass": password,
      "RTSP":RSTP,
      "Name":name,
      "Mode":1,
      "Intrusion Points":"{69.33333333333333: 425.0, 286.6666666666667: 188.0, 295.3333333333333: 528.6666666666666, 77.33333333333333: 419.0}",
      
      };
    users.doc(_auth.currentUser!.uid).set(g);
  
    sucess();


  } on FirebaseAuthException catch (e) {
    print('aag'+e.toString());
    
    failure(e.toString());
    return null;
  }
}

Future<UserCredential?> signin(String email, String password) async {
  try {

    print(email+'  '+password);
    UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email, password: password);

    return userCredential;
  } catch (e) {
    print(e);
    return null;
  }
}

reset(String email) async {
  FirebaseAuth _auth = FirebaseAuth.instance;
  await _auth.sendPasswordResetEmail(email: email);
}

logout(BuildContext context) async {






sucess() async {


      
    
   Navigator.pop(context,true);
  await _auth.signOut();
  Navigator.of(context)
      .push(MaterialPageRoute(builder: (context) => VerifyCheck()));

}

failure(){


   Navigator.of(context).pop();
     alertbox(context, 'Connection Failed', 'Please Check your Internet Connection', 'images/alerts.gif');
     return null;
}






   await FirebaseFirestore.instance.collection('DB').doc(_auth.currentUser!.uid).update({
          'deviceToken': ''
        }).then((value) => sucess()).timeout(const Duration(seconds: 10)).catchError((error, stackTrace) => failure());;

}

class EnterData {
  final String drinkName;
  final String drinkDesc;
  EnterData(this.drinkName, this.drinkDesc);

  final CollectionReference cartCollection =
      FirebaseFirestore.instance.collection(_auth.currentUser!.uid);

  addData() {
    Map<String, String> g = {
      "Drink Name": drinkName,
      "Drink Desc": drinkDesc,
    };

    cartCollection.doc().set(g);
  }
}

class GetData {
  final CollectionReference captures =
      FirebaseFirestore.instance.collection('DB').doc(_auth.currentUser!.uid).collection('Captures');


   getData() async {
 List captureList = [];

    // Get docs from collection reference
    QuerySnapshot querySnapshot = await captures.get();

    // Get data from docs and convert map to List
    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
    captureList = allData;

    
    return captureList;


  }





alertbox(){







  
}



}





alertbox(context,text,subtext,path){



  showDialog(
  context: context,builder: (_) => AssetGiffyDialog(
    buttonCancelColor: tone,
    onlyCancelButton: true,
    image: Image(image: AssetImage(path)),
    title: Text(text,
            style: TextStyle(
            fontSize: 22.0, fontWeight: FontWeight.w600),
    ),
    description: Text(subtext,
          textAlign: TextAlign.center,
          style: TextStyle(),
        ),
    entryAnimation: EntryAnimation.BOTTOM,
    buttonCancelText: Text('OK',style: TextStyle(color: Colors.white)),
  ) );
}



shrink(){



  Row(
      children: [
        const Skeleton(height: 120, width: 120),
        const SizedBox(width: defaultPadding),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Skeleton(width: 80),
              const SizedBox(height: defaultPadding / 2),
              const Skeleton(),
              const SizedBox(height: defaultPadding / 2),
              const Skeleton(),
              const SizedBox(height: defaultPadding / 2),
              Row(
                children: const [
                  Expanded(
                    child: Skeleton(),
                  ),
                  SizedBox(width: defaultPadding),
                  Expanded(
                    child: Skeleton(),
                  ),
                ],
              )
            ],
          ),
        )
      ],
    );
}



