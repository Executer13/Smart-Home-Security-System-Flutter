import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'components/rounded_btn/rounded_btn.dart';
import 'methods.dart';
import 'package:gallery_saver/gallery_saver.dart';

 final FirebaseAuth _auth = FirebaseAuth.instance;
class HeroA extends StatefulWidget {
  final drinks;
  final index;
  const HeroA({Key? key, required this.drinks, required this.index})
      : super(key: key);

  @override
  _HeroAState createState() => _HeroAState();
}

class _HeroAState extends State<HeroA> {
  @override
  Widget build(BuildContext context) {
    var sizeheight = MediaQuery.of(context).size.height;
    var sizewidth = MediaQuery.of(context).size.width;
    return Scaffold(
      
      body: Column(
        children: [
          SizedBox(height: sizeheight / 15),
          
             Hero(
              tag: this.widget.drinks["Link"],
              child: Material(
                
                child:                 
                    
                       Container(
                        height: sizeheight / 3,
                        width: sizewidth / 1,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            image: DecorationImage(
                                image:
                                    NetworkImage(this.widget.drinks["Link"]),
                                fit: BoxFit.contain)),
                      ),
                    
                  
                
              ),
            ),
           Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              this.widget.drinks["Name"],
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                  color: Color(0xfff3B324E)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Date:"+
              this.widget.drinks["Date"],
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                  color: Color(0xfff3B324E)),
            ),
          ),
         Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Time:"+
              this.widget.drinks["Time"],
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                  color: Color(0xfff3B324E)),
            ),
          ),
          SizedBox(
            height: sizeheight / 35,
          ),
         Row(
           children: [
             Container(margin: EdgeInsets.only(left: 10),width: 120,height: 100,child: RoundedButton(
              circular: 20,
              btnText:'Download', color:  Color(0xfff1877F2) ,onPressed:()=>{GallerySaver.saveImage(this.widget.drinks["Link"]),showSimpleBar(context, 'Capture Saved to Gallery')} ,)),
             Spacer(),
              Container(
                margin: EdgeInsets.only(right: 10),
                width: 120,height: 100,
           child: RoundedButton(
            circular: 20,
            btnText:'Delete', color:  Color(0xfff1877F2) ,onPressed:() async =>{
            
        
        await FirebaseFirestore.instance.collection('DB').doc(_auth.currentUser!.uid).collection('Captures').doc( this.widget.drinks["Date"]+" "+ this.widget.drinks["Time"].replaceAll(RegExp(':'), '-')).delete()
        ,showSimpleBar(context, 'Capture Deleted')
           } ,),
         )
           ],
         ) ,
        
        ],
      ),
    );
  }
}
