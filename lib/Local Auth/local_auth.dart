// import 'package:flutter/services.dart';
// import 'package:local_auth/local_auth.dart';

// class LocalAuthPi {
//   static final _auth = LocalAuthentication();

//   static Future<bool> hasBiometrics() async {
//     try {
//       return await _auth.canCheckBiometrics;
//     // ignore: unused_catch_clause
//     } on PlatformException catch (e) {
//       return false;
//     }
//   }

//   static Future<bool> authenticate() async {
//     final isAvaliable = await hasBiometrics();
//     if (!isAvaliable) return false;
//     try {
//       return await _auth.authenticateWithBiometrics(
//         localizedReason: "Scan fingerprint to Authenticate",
//         useErrorDialogs: true,
//         stickyAuth: true,
//       );
//     // ignore: unused_catch_clause
//     } on PlatformException catch (e) {
//       return false;
//     }
//   }
// }
