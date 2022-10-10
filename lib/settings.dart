

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:giffy_dialog/giffy_dialog.dart';
import 'package:kf_drawer/kf_drawer.dart';
import 'package:testing/colors.dart';
import 'package:testing/common/theme_helper.dart';
import 'package:testing/dragger.dart';
import 'package:testing/main.dart';
import 'package:testing/methods.dart';
import 'package:testing/smart/widgets/header_widget.dart';


import 'components/rounded_btn/rounded_btn.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
var chrtsp= TextEditingController();
class Settings extends KFDrawerContent {
  Settings({
     Key? key,
  });

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {



sucess(){


      
    
 Navigator.of(context).pop();
                         
 
                          
  alertbox(context,'RTSP CONFIRMATION','RSTP Link of the video Footage has been changed.','images/sucess.gif');
   


}

failure(){


   Navigator.of(context).pop();
     alertbox(context, 'Connection Failed', 'Please Check your Internet Connection', 'images/alerts.gif');
     return null;
}





  @override
  Widget build(BuildContext context) {
     Color c1 = Theme.of(context).primaryColor;
    Color c2 = Theme.of(context).accentColor;
    return SafeArea(
      child: Stack(
        children: [
          Column(
            children: [
              Container(
              height: 150,
              child: HeaderWidget(150, true, Icon(Icons.login_rounded), false,fun: (){}, notiText: 'SETTINGS',), //let's create a common header widget
            ),
                SizedBox(height: 10,),
          Row(
            children: [
              Container(width:250 ,padding: EdgeInsets.only(left: 10),
                child: Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: Container(
                          margin: EdgeInsets.symmetric(vertical: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                              child: TextFormField(
                                 controller: chrtsp,
                                decoration: ThemeHelper().textInputDecoration("Change Facial Recognition RTSP", "Enter your camera  RTSP Link "),
                                
                              ),
                              decoration: ThemeHelper().inputBoxDecorationShaddow(),
                            ),
                            ],
                          ),
                        ),
                      ),
              ),




Container(width: 100,padding: EdgeInsets.only(top: 20),
  child:   Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: 
                      
                      
                      
                      
                      
                      
                      RaisedGradientButton(
                        child: Text(
    'Change',
    style: TextStyle(color: Colors.white),
  ),
  gradient:  LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        stops: [0.0, 1.0],
        colors: [
          c1,
          c2,
        ],
      ),
  onPressed:  (){

  

  showDialog(context: context, builder: (context){

                                        return Center(child: CircularProgressIndicator());

                                     });

  
  
                     FirebaseFirestore.instance.collection('DB').doc(_auth.currentUser!.uid).update({
                        'RTSP': chrtsp.text
                      }).then((value) => sucess()).timeout(const Duration(seconds: 10)).catchError((error, stackTrace) => failure());;   
 
                          
 
                        
                        
                        }, circular: 20, ))),
)









            ],
          ),



              SizedBox(height: 10,),
          Row(
            children: [
              Container(width:250 ,padding: EdgeInsets.only(left: 10),
                child: Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: Container(
                          margin: EdgeInsets.symmetric(vertical: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                              child: TextFormField(
                                 controller: chrtsp,
                                decoration: ThemeHelper().textInputDecoration("Change RTSP", "Enter your camera  RTSP Link "),
                               
                              ),
                              decoration: ThemeHelper().inputBoxDecorationShaddow(),
                            ),
                            ],
                          ),
                        ),
                      ),
              ),




Container(width: 100,padding: EdgeInsets.only(top: 20),
  child:   Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: 
                      
                      
                      
                      
                      
                      
                      RaisedGradientButton(
                        child: Text(
    'Change',
    style: TextStyle(color: Colors.white),
  ),
  gradient:  LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        stops: [0.0, 1.0],
        colors: [
          c1,
          c2,
        ],
      ),
  onPressed:  (){
  
  
  showDialog(context: context, builder: (context){

                                        return Center(child: CircularProgressIndicator());

                                     });

  
  
                     FirebaseFirestore.instance.collection('DB').doc(_auth.currentUser!.uid).update({
                        'RTSP': chrtsp.text
                      }).then((value) => sucess()).timeout(const Duration(seconds: 10)).catchError((error, stackTrace) => failure());;   
 
                      
                        
                        
                        }, circular: 20, ))),
)









            ],
          ),



















            ],
            
          ),
          
        ],
      ),
               
    );
  }
}