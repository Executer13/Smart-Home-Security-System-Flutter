import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

import 'package:testing/pages/onboarding_page.dart';


import 'fingerpage.dart';


class VerifyCheck extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    if (_auth.currentUser == null) {
      return OnboardingPage();
    } else {
      return FingerWndow();
    }
  }
}
