
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:testing/colors.dart';
import 'package:testing/smart/login_page.dart';
import 'package:testing/widget/card_planet.dart';
import 'package:concentric_transition/concentric_transition.dart';



class OnboardingPage extends StatelessWidget {
  OnboardingPage({Key? key}) : super(key: key);

  final data = [
    CardPlanetData(
      title: "OutDated",
      subtitle:
          "Ain't you Sick of Old Outdated CCTV Monitoring Systems.",
      image: 'animation/cctv.json',
      backgroundColor: Colors.white,
      titleColor: Colors.purple,
      subtitleColor: const Color.fromRGBO(0, 10, 56, 1),

      
      background: LottieBuilder.asset("animation/bg-1.json"),
    ),
    CardPlanetData(
      title: "SMART RECOGNITION",
      subtitle: "Use our Smart Person Recognition to recognize People at your DoorStep.",
      image:  'animation/recognition.json',
      backgroundColor: tone,
      titleColor: secondary,
      subtitleColor: Colors.white,
      background: LottieBuilder.asset("animation/bg-2.json"),
    ),
    CardPlanetData(
      title: "Secure Your Home",
      subtitle: "Use Intrusion Area and Line based Detection to Hard Fence your Home.",
      image: 'animation/wire.json',
      backgroundColor: Colors.white,
      titleColor: Colors.purple,
      subtitleColor:  Colors.black,
      background: LottieBuilder.asset("animation/bg-3.json"),
    ),
    CardPlanetData(
       title: "SECURED ACCESS",
      subtitle: "Secured App with Bultin Fingerprint and Email-based Access.",
      image:  'animation/privacy.json',
      backgroundColor: tone,
      titleColor: secondary,
      subtitleColor: Colors.white,
      background: LottieBuilder.asset("animation/bg-1.json"),
    ),
   
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ConcentricPageView(
        colors: data.map((e) => e.backgroundColor).toList(),
        itemCount: 4,
        itemBuilder: (int currentIndex) {
         
          return   CardPlanet(data: data[currentIndex]);
         
        },
        onFinish: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) =>  LoginPage()),
          );
        },
      ),
    );
  }
}



