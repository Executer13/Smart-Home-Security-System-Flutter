
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:kf_drawer/kf_drawer.dart';
import 'package:path/path.dart';
import 'package:testing/colors.dart';
import 'package:testing/main.dart';
import 'package:testing/methods.dart';
import 'package:testing/smart/widgets/header_widget.dart';

import 'common/theme_helper.dart';
TextEditingController picname=TextEditingController();
FirebaseAuth _auth = FirebaseAuth.instance;
class ImageUploads extends KFDrawerContent {
  ImageUploads({Key? key}) ;

  @override
  _ImageUploadsState createState() => _ImageUploadsState();
}

class _ImageUploadsState extends State<ImageUploads>  {
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
      var pickedFile;

  File? _photo;
  final ImagePicker _picker = ImagePicker();

pica() async {

     pickedFile = await _picker.pickImage(source: ImageSource.gallery);
  }

  
  @override
  Widget build(BuildContext context) {






  

 
  Future uploadFile() async {
    String? em=_auth.currentUser!.email;
    if (_photo == null) return;
    final fileName = basename(_photo!.path);
    final destination = em;


  showDialog(context: context, builder: (context){

                                        return Center(child: CircularProgressIndicator());

                                     });

    try {
      final ref = firebase_storage.FirebaseStorage.instance
          .ref(destination)
          .child(picname.text+".jpg");
      await ref.putFile(_photo!);
      Navigator.of(context).pop();
      alertbox(context, 'Upload Sucessful', 'Please restart Python Server for the files to Sync', 'images/uploading.gif');

      
    } catch (e) {
      Navigator.of(context).pop();
      
       alertbox(context, 'Upload Failed', 'Please Check your Internet Connection', 'images/alerts.gif');
    }
  }




Future imgFromGallery() async {
    

    setState(() {
      if (pickedFile != null) {
        _photo = File(pickedFile.path);
        uploadFile();
      } else {
        alertbox(context, 'No Image Selected', 'Please Upload a File', 'images/alerts.gif');
      }
    });
  }









    return SafeArea(

      
      
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[Container(
                height: 150,
                child: HeaderWidget(150, true, Icon(Icons.login_rounded), false,fun: (){}, notiText: 'Faces',), //let's create a common header widget
              ),
              
               Padding(
                            padding: EdgeInsets.fromLTRB(45, 10, 40,0),
                            child: Text('Kindly Upload the Image with the name of Person.', textAlign: TextAlign.center,
                            style: GoogleFonts.bebasNeue(
                              
                              color: Colors.grey ,
                              
                              fontSize: 20,
                            ),
                            ),
                          ),
                
            SizedBox(
              height: 22,
            ),
            Container(padding: EdgeInsets.fromLTRB(10, 10, 10,10) ,
                                child: TextField(controller: picname,
                                  decoration: ThemeHelper().textInputDecoration('Person Name', 'Enter Name of Person in Image'),
                                ),
                                decoration: ThemeHelper().inputBoxDecorationShaddow(),
                              ),
                              SizedBox(
              height: 22,
            ),
            Center(
              child: GestureDetector(
                onTap: () {
                  _showPicker(context);
                },
                child: CircleAvatar(
                  radius: 55,
                  backgroundColor: Color(0xffFDCF09),
                  child: _photo != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Image.file(
                            _photo!,
                            width: 100,
                            height: 100,
                            fit: BoxFit.fitHeight,
                          ),
                        )
                      : Container(
                          decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(50)),
                          width: 100,
                          height: 100,
                          child: Icon(
                            Icons.camera_alt,
                            color: Colors.grey[800],
                          ),
                        ),
                ),
              ),
            ),
            SizedBox(
              height: 22,
            ),
            Container(
                                decoration: ThemeHelper().buttonBoxDecoration(context),
                                child: ElevatedButton(
                                  style: ThemeHelper().buttonStyle(),
                                  child: Padding(
                                    padding: EdgeInsets.fromLTRB(40, 10, 40, 10),
                                    child: Text('Upload'.toUpperCase(), style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),),
                                  ),
                                  onPressed: () async {
                                  try{

                                    imgFromGallery();
                                                                        
                                  }
                                  catch (e) {
    print(e);
     alertbox(context, 'Upload Failed', 'Please Check your Internet Connection', 'images/alerts.gif');
    return null;
  }
                                  
                                  },
                                ),
                              ),
          ],
        ),
      ),
    );
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Gallery'),
                      onTap: () {
                        pica();
                        Navigator.of(context).pop();
                      }),
                 
                ],
              ),
            ),
          );
        });
  }
}
