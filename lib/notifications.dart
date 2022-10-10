import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kf_drawer/kf_drawer.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:testing/colors.dart';
import 'package:testing/constants.dart';
import 'package:testing/main.dart';
import 'package:testing/skelton.dart';
import 'package:testing/smart/widgets/header_widget.dart';


import 'Hero.dart';
import 'methods.dart';













class Notifications extends KFDrawerContent {
  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {

final FirebaseAuth _auth = FirebaseAuth.instance;

late List captures=[];
 late bool _isLoading;



fetchDatabaselist()  async {
    List resultant = await GetData().getData();
    resultant=resultant.reversed.toList();
    print(resultant);
    if (resultant == null) {
      print('error');
    } else {
      setState(() {
        
        captures = resultant;
        
      });
    }
  }

  @override
  void initState() {
 _isLoading = true;
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _isLoading = false;
      });
    });


    super.initState();
    
  fetchDatabaselist();
  }

Future<void> _pullRefresh() async {
    
    setState(() {
     fetchDatabaselist();
    });
    // why use freshWords var? https://stackoverflow.com/a/52992836/2301224
  }







 





  listviewgenerator() {
    return RefreshIndicator( onRefresh: _pullRefresh,
      child: ListView.builder( 
          physics: NeverScrollableScrollPhysics(),
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: captures.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                var temp = captures[index];
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => HeroA(drinks: temp, index: index)));
              },
              child: Card( 
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),),
                elevation: 3,
                child: ListTile( 
                  
                  leading: Hero(
                    tag: captures[index]["Link"],
                    child: Container(
                      child:
                          Image.network(captures[index]["Link"], scale: 4),
                    ),
                  ),
                  subtitle:Text(captures[index]["Date"] ) ,
                  title: Text(
                    captures[index]["Name"],
                    style: GoogleFonts.roboto(
                        
                        color: Colors.black,
                        fontSize: 18),
                  ),
                  
                ),
              ),
            );
          }),
    );
  }
















  @override
  Widget build(BuildContext context) {
    return 
    
       SafeArea(
         child: Stack(
           children: [
             SingleChildScrollView(
               child:
       
                                     
       
       
                                  
                                      Column(
                                        children: [

Container(
                height: 150,
                child: HeaderWidget(150, true, Icon(Icons.clear_all),false,fun: () async {
                  
  showDialog(context: context, builder: (context){

                                        return Center(child: CircularProgressIndicator());

                                     });
                  
       
       var collection = FirebaseFirestore.instance.collection('DB').doc(_auth.currentUser!.uid).collection('Captures');
       var snapshots = await collection.get();
       try{
       for (var doc in snapshots.docs) {
         await doc.reference.delete();
       


       }
         Navigator.of(context).pop();
                                alertbox(context,'Notifications Cleared','Notifications Cleared Successfully!','images/successful.gif');
                                

       }
       catch(e){
        
   Navigator.of(context).pop();
     alertbox(context, 'Connection Failed', 'Please Check your Internet Connection', 'images/alerts.gif');

       }
       
       
       setState(() {
       fetchDatabaselist();
       listviewgenerator();
       
       });
       
       
                                          
       
       
       
       
                  
                  
                  
                  
                  
                  
                  
                  
                  
                  
                  }, notiText: 'Notifications',), //let's create a common header widget
              ),

       
       SizedBox(height:10,),
       
       
                                          Padding(
              padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
                                            child: 
                                             
                                               _isLoading
                                                  ? NewsCardSkelton()
                                                  : listviewgenerator(),
                                                  ),
                                        ],
                                      ),
                                    
                                
                              ),
                              
                
           ],
         ),
       );
                      
      



  }
}



class NewsCardSkelton extends StatelessWidget {
  const NewsCardSkelton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer(
       duration: Duration(seconds: 3),
        // This is NOT the default value. Default value: Duration(seconds: 0)
        interval: Duration(seconds: 2),
        // This is the default value
        color: Colors.white,
        // This is the default value
        colorOpacity: 0.5,
        // This is the default value
        enabled: true,
        // This is the default value
        direction: ShimmerDirection.fromLTRB(),
      child: Column(children: [Row(
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
      ),
      SizedBox(height: 10,),
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
      ), 
      SizedBox(height: 10,),
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
      ),
    SizedBox(height: 10,),
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
      ),
      SizedBox(height: 10,),
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
      ),
    
    
    
    
    
    
    
      ],),
    );
  }
}