import 'dart:io';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';
import 'package:testing/colors.dart';

import 'package:testing/main.dart';
import 'package:testing/methods.dart';
import 'package:testing/smart/login_page.dart';


class Draw extends StatefulWidget {
  @override
  _DrawState createState() => _DrawState();
}

class _DrawState extends State<Draw> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late VlcPlayerController _videoPlayerController;

  Color selectedColor = Colors.black;
  Color pickerColor = Colors.black;
  double strokeWidth = 3.0;
  List<DrawingPoints> points =[];
  Map<double,double>ps={};
   
  bool showBottomList = false;
  double opacity = 1.0;
  StrokeCap strokeCap = (Platform.isAndroid) ? StrokeCap.butt : StrokeCap.round;
  SelectedMode selectedMode = SelectedMode.StrokeWidth;
  List<Color> colors = [
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.amber,
    Colors.black

  ];


sucess(){


      
    
 Navigator.of(context).pop();
                       alertbox(context,'Changes Successful','Intrusion Area has been changed.','images/sucess.gif' );
  
   


}

failure(){


   Navigator.of(context).pop();
     alertbox(context, 'Connection Failed', 'Please Check your Internet Connection', 'images/alerts.gif');
     return null;
}




   @override
  void initState() {
    
    
 
    




    super.initState();
    


    _videoPlayerController = VlcPlayerController.network(
      rtspReal,
      hwAcc: HwAcc.full,
      autoPlay: true,
      options: VlcPlayerOptions(),
    );

    
  }


 @override
  void dispose() async {
    super.dispose();
    await _videoPlayerController.stopRendererScanning();
    
  }



  
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
     double w = MediaQuery.of(context).size.width;
    return Scaffold(
      
      
      body: GestureDetector(
        onPanUpdate: (details) {
          setState(() {
            RenderBox? renderBox = context.findRenderObject() as RenderBox;
            points.add(DrawingPoints(
                points: renderBox.globalToLocal(details.globalPosition),
                paint: Paint()
                  ..strokeCap = strokeCap
                  ..isAntiAlias = true
                  ..color = selectedColor.withOpacity(opacity)
                  ..strokeWidth = strokeWidth));
          });
        },
        onPanStart: (details) {
          setState(() {
            print("height $h x $w");
            RenderBox? renderBox = context.findRenderObject() as RenderBox;
            points.add(DrawingPoints(
                points: renderBox.globalToLocal(details.globalPosition),
                paint: Paint()
                  ..strokeCap = strokeCap
                  ..isAntiAlias = true
                  ..color = selectedColor.withOpacity(opacity)
                  ..strokeWidth = strokeWidth));
          });
        },
        onPanEnd: (details) {
          setState(() {
          
            points.asMap().forEach((key, value) { 
             
              ps[points[key].points.dx]=points[key].points.dy;

            print(ps);
            });




          });
        },
        child: Stack(
          children: [RotatedBox(
            quarterTurns: 3,
            child: Container(
              height: MediaQuery.of(context).size.width,
              child:  VlcPlayer(
                      controller: _videoPlayerController,
                      aspectRatio: 19.5 / 9,
                      placeholder: Center(child: CircularProgressIndicator()),
                    ),
              
            ),
          ),
           CustomPaint(
              
                        size:Size( MediaQuery.of(context).size.width,  MediaQuery.of(context).size.height),
              painter: DrawingPainter(
                pointsList: points,
              ),
            ),
            
            
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50.0),
                  color: tone),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        IconButton(
                            icon: Icon(Icons.done,color: Colors.white),
                            onPressed: () {
                               showDialog(context: context, builder: (context){

                                        return Center(child: CircularProgressIndicator());

                                     });


                                FirebaseFirestore.instance.collection('DB').doc(_auth.currentUser!.uid).update({
                      'Intrusion Points': ps.toString()
                    }).then((value) => sucess()).timeout(const Duration(seconds: 10)).catchError((error, stackTrace) => failure());


            
                            }),
                        IconButton(
                            icon: Icon(Icons.opacity,color: Colors.white),
                            onPressed: () {
                              setState(() {
                                if (selectedMode == SelectedMode.Opacity)
                                  showBottomList = !showBottomList;
                                selectedMode = SelectedMode.Opacity;
                              });
                            }),
                        IconButton(
                            icon: Icon(Icons.color_lens,color: Colors.white),
                            onPressed: () {
                              setState(() {
                                if (selectedMode == SelectedMode.Color)
                                  showBottomList = !showBottomList;
                                selectedMode = SelectedMode.Color;
                              });
                            }),
                        IconButton(
                            icon: Icon(Icons.clear,color: Colors.white),
                            onPressed: () {
                              setState(() {
                                showBottomList = false;
                                points.clear();
                                ps.clear();
                              });
                            }),
                      ],
                    ),
                    Visibility(
                      child: (selectedMode == SelectedMode.Color)
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: getColorList(),
                            )
                          : Slider(
                              value: (selectedMode == SelectedMode.StrokeWidth)
                                  ? strokeWidth
                                  : opacity,
                              max: (selectedMode == SelectedMode.StrokeWidth)
                                  ? 50.0
                                  : 1.0,
                              min: 0.0,
                              onChanged: (val) {
                                setState(() {
                                  if (selectedMode == SelectedMode.StrokeWidth)
                                    strokeWidth = val;
                                  else
                                    opacity = val;
                                });
                              }),
                      visible: showBottomList,
                    ),
                  ],
                ),
              )),
                  ),
            ),
          
          









          
          ]
        ),
      ),
    );
  }

  getColorList() {
    List<Widget> listWidget = [];
    for (Color color in colors) {
      listWidget.add(colorCircle(color));
    }
    
    
    return listWidget;
  }

  Widget colorCircle(Color color) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedColor = color;
        });
      },
      child: ClipOval(
        child: Container(
          padding: const EdgeInsets.only(bottom: 16.0),
          height: 36,
          width: 36,
          color: color,
        ),
      ),
    );
  }
}

class DrawingPainter extends CustomPainter {
  DrawingPainter({required this.pointsList});
  List<DrawingPoints> pointsList;
  List<Offset> offsetPoints = [];
  
  @override
  void paint(Canvas canvas, Size size) {
   
    for (int i = 0; i < pointsList.length - 1; i++) {
      if (pointsList[i] != null && pointsList[i + 1] != null) {
        canvas.drawLine(pointsList[i].points, pointsList[i + 1].points,
            pointsList[i].paint);
      } else if (pointsList[i] != null && pointsList[i + 1] == null) {
        offsetPoints.clear();
        offsetPoints.add(pointsList[i].points);
        offsetPoints.add(Offset(
            pointsList[i].points.dx + 0.1, pointsList[i].points.dy + 0.1));
        canvas.drawPoints(PointMode.points, offsetPoints, pointsList[i].paint);
      }
    }
  }

  @override
  bool shouldRepaint(DrawingPainter oldDelegate) => true;
}

class DrawingPoints {
  Paint paint;
  Offset points;
  DrawingPoints({required this.points, required this.paint});
}

enum SelectedMode { StrokeWidth, Opacity, Color }