import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:flutter/material.dart';


class fingerPrintSevice {
  final _auth = LocalAuthentication();

  Future<bool> hasBiometrics() async {
    try {
      return await _auth.canCheckBiometrics;
    } on PlatformException catch (e) {
      print(e);
      return false;
    }
  }

  Future<List<Enum>> getBiometrics() async {
    try {
      return await _auth.getAvailableBiometrics();
    } on PlatformException catch (e) {
      print(e);
      return <BiometricType>[];
    }
  }

  authenticate() async {
    final isAvailable = await hasBiometrics();
    if (!isAvailable) {
      return false;
    }

    try {
      return await _auth.authenticate(
  localizedReason: 'localized reason',
  
  options: const AuthenticationOptions(
    useErrorDialogs: true,
    stickyAuth: true,
  ),
);
    } on PlatformException catch (e) {
      print(e);
      return false;
    }
  }
}
