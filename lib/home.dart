import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kf_drawer/kf_drawer.dart';
import 'package:testing/colors.dart';
import 'package:testing/main.dart';
import 'package:testing/methods.dart';
import 'package:testing/notifications.dart';
import 'package:testing/smart/login_page.dart';
import 'package:testing/smart/widgets/header_widget.dart';


 
final FirebaseAuth _auth = FirebaseAuth.instance;
class Home extends KFDrawerContent {
  Home({
    Key? key,
  });

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  VlcPlayerController _videoPlayerController = VlcPlayerController.network(
      rtspReal,
      hwAcc: HwAcc.auto,
      autoPlay: true,
      options: VlcPlayerOptions(),
    );



 







   @override
  void initState() {
    
    
 
    




    super.initState();
    

   

    
  }


 @override
  void dispose() async {
    super.dispose();
    await _videoPlayerController.stopRendererScanning();
    


    
  }


bool boo1=true;
bool boo2=false;



  @override
  Widget build(BuildContext context) {
    double swidth = MediaQuery. of(context). size. width ;
double sheight = MediaQuery. of(context). size. height;
 double   _headerHeight=150;

    return   SafeArea(

      child: 
      
      Column(
        children: [
          
          
          Container(
              height: _headerHeight,
              child: HeaderWidget(_headerHeight, true, Icon(Icons.login_rounded),false,fun: (){
                  showDialog(context: context, builder: (context){

                                        return Center(child: CircularProgressIndicator());

                                     });

                logout(context);}, notiText: 'HOME',), //let's create a common header widget
            ),
              
          ListView(shrinkWrap: true,
            children: <Widget>[
              Column(
                children: <Widget>[    
                  SizedBox(height: 0),
  
                          


                          
                       

              Container(margin: EdgeInsets.all(10),width: 350,height: 265,
                decoration: BoxDecoration(boxShadow:
                        [
            BoxShadow(
                blurRadius: 2,
                color: Colors.black38,
                offset: Offset(1, 1),
                )] ,
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5)),
                child: Stack(
                  children: [
                 
          
                    
                    Column(
                      children: [ 
                       
                                   Padding(
                          padding: EdgeInsets.fromLTRB(0, 10, 0,0),
                          child: Text('STREAM FOOTAGE ONE', textAlign: TextAlign.center,
                          style: GoogleFonts.bebasNeue(
                            
                            color: tone ,
                            
                            fontSize: 28,
                          ),
                          ),
                        ),
                                 

                        SafeArea(
                          child: Container(
                            
                            width: 350,
                              height: 200,
                            child: VlcPlayer(
                              controller: _videoPlayerController,
                              aspectRatio: 16 / 9,
                              placeholder: Center(child: CircularProgressIndicator()),
                            ),
                          ),
                        ),
                        
                      ],
                    ),
                  ],
                ),
              ),

              
                  SizedBox(height: 5,)
                  ,

                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 200,
                   
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        listItemStats(Icons.trending_up,"Intrusion Line",boo1),
                        listItemStats(Icons.face_outlined,"Face recogntion", boo2),
                        listItemStats(Icons.timelapse_rounded,"Scheduler", false)
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    
    );
    
  }

 

  Widget listItemStats(IconData i, String name, bool value){
Color c1 = Theme.of(context).primaryColor;
    Color c2 = Theme.of(context).accentColor;

    return Container(
      width: 110,
      height: 150,
      decoration: BoxDecoration(gradient:
          LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        stops: [0.0, 1.0],
        colors: [
          c1,
          c2,
        ],
      ),


          borderRadius: BorderRadius.circular(5),
          color: value  ? tone  : Colors.black26
      ),
      child: Column(
        children: <Widget>[
          SizedBox(height: 20),
          Icon(i,size: 45, color: value ? Colors.white : Colors.white),
          SizedBox(height: 15),
          Text(name, style: TextStyle(fontSize: 13, color: value  ? Colors.white : Colors.white)),
          SizedBox(height: 5),
          Switch(
            value: value,
            onChanged: (newVal){
              
              setState(() {
                
                if(name=="Intrusion Line"){boo1 = newVal;
                FirebaseFirestore.instance.collection('DB').doc(_auth.currentUser!.uid).update({
                'Mode': 1
        });
                if(boo1==true){boo2=!boo1;}
                }
                else  if(name=="Face recogntion"){boo2 = newVal;
                 FirebaseFirestore.instance.collection('DB').doc(_auth.currentUser!.uid).update({
                'Mode': 2
        });

                if(boo2==true){boo1=!boo2;}
                }

                
                print(newVal);
                print(boo1);
              });
            },
            activeColor: Colors.white,
            
          )
        ],
      ),
    );
  }
}
