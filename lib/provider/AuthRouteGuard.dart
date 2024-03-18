// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
//
// class AuthRouteGuard extends RouteGuard {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//
//   @override
//   Future<bool> canActivate(String path, BuildContext context) async {
//     final user = await _auth.currentUser!();
//     if (user == null) {
//       // Rediriger l'utilisateur vers l'écran d'authentification
//       Navigator.pushReplacementNamed(context, '/login');
//       return false;
//     } else {
//       return true;
//     }
//   }
// }
