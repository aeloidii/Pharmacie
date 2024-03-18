import 'package:adminsignin/screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../reusable_widget/reusablewidget.dart';
import '../utils/colorutils.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _userNameTextController = TextEditingController();

  FirebaseFirestore firebaseFiretore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Sign Up",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
            hexSrtingToColor("20B2AA"),
            hexSrtingToColor("00816D"),
            hexSrtingToColor("BCF0AC")
          ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
          child: SingleChildScrollView(
              child: Padding(
            padding: EdgeInsets.fromLTRB(20, 120, 20, 0),
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 20,
                ),
                reusableTextField("Enter UserName", Icons.person_outline, false,
                    _userNameTextController),
                const SizedBox(
                  height: 20,
                ),
                reusableTextField("Enter Email Id", Icons.person_outline, false,
                    _emailTextController),
                const SizedBox(
                  height: 20,
                ),
                reusableTextField("Enter Password", Icons.lock_outlined, true,
                    _passwordTextController),
                const SizedBox(
                  height: 20,
                ),
                firebaseUIButton(context, "Sign Up", () {
                  FirebaseAuth.instance
                      .createUserWithEmailAndPassword(
                          email: _emailTextController.text,
                          password: _passwordTextController.text)
                      .then((value) {
                    print("username: ${_userNameTextController.text}");
                    print("email: ${_emailTextController.text}");
                    print("Password: ${_passwordTextController.text}");
                    //firestoreStart
                    firebaseFiretore
                        .collection("admins")
                        .doc(value.user?.uid)
                        .set({
                      "FullName": _userNameTextController.text,
                      "id": value.user?.uid,
                      "Email": _emailTextController.text,
                      "Password": _passwordTextController.text,
                    });
                    //old config
                    /**
                        rules_version = '2';
                        service cloud.firestore {
                          match /databases/{database}/documents {
                            match /{document=**} {
                        allow read, write: if false;
                        }
                        }
                        }
                            */
                    //firestoreEnd

                    print("Created New Account");
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HomeScreen()));
                  }).onError((error, stackTrace) {
                    print("Error❗✅ ${error.toString()}");
                  });
                }, Colors.white, Colors.black87)
              ],
            ),
          ))),
    );
  }
}
