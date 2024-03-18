import 'package:adminsignin/reusable_widget/loading.dart';
import 'package:adminsignin/reusable_widget/reusablewidget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../utils/colorutils.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({Key? key}) : super(key: key);

  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  bool loading=false;
  TextEditingController _emailTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Réinitialisation du mot de passe",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      body:loading? Loadingpas(): Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                hexSrtingToColor("20B2AA"),hexSrtingToColor("00816D"),hexSrtingToColor("BCF0AC")
              ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
          child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.fromLTRB(20, 120, 20, 0),
                child: Column(
                  children: <Widget>[
                    const SizedBox(
                      height: 20,
                    ),
                    reusableTextField("Entrez votre email", Icons.person_outline, false,
                        _emailTextController),
                    const SizedBox(
                      height: 20,
                    ),
                    firebaseUIButton(context, "Réinitialiser le mot de passe", () {
                      setState(() {
                        loading=true;
                      });
                      FirebaseAuth.instance
                          .sendPasswordResetEmail(email: _emailTextController.text)
                          .then((value) =>

                          Navigator.of(context).pop(ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Check your email"), backgroundColor: Colors.green,showCloseIcon: true,)
                          ))


                      )

                          .onError((error, stackTrace) {
                        setState(() {
                          loading=false;
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Please enter an existed email!"),backgroundColor: Colors.red,showCloseIcon: true,)
                        );
                        print("Error ${error.toString()}");
                      });;
                    },Colors.white,Colors.black87)
                  ],
                ),
              ))),
    );
  }
}