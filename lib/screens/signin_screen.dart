import 'package:adminsignin/dashboard.dart';
import 'package:adminsignin/reusable_widget/loading.dart';
import 'package:adminsignin/screens/resetpass.dart';
import 'package:adminsignin/screens/signup_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../reusable_widget/reusablewidget.dart';
import '../utils/colorutils.dart';
import 'home_screen.dart';
import 'package:provider/provider.dart';

class SignInScreen extends StatefulWidget{
  const SignInScreen({Key? key}) :super(key: key);
  @override
  _SignInScreenState createState() => _SignInScreenState();


}

class _SignInScreenState extends State<SignInScreen> {

  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
  bool loading=false;
  bool isPasswordType=true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,

      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors:[hexSrtingToColor("20B2AA"),hexSrtingToColor("00816D"),hexSrtingToColor("BCF0AC")],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter)),

      child: SingleChildScrollView(

        child: Padding(

            padding: EdgeInsets.fromLTRB(20, MediaQuery.of(context).size.height*0.2, 20, 0),
            child: Column(
              children: <Widget>[
                logoWidget("images/appLogo.png"),
                SizedBox(
                  height: 30,
                ),
                Container(
                    width: 500,
                    child: reusableTextField("Nom d'utilisateur", Icons.person_outlined, false, _emailTextController)
                ),
                // reusableTextField("Enter Password", Icons.lock_outlined, true, _passwordTextController)
                SizedBox(
                  height: 20,
                ),
                Container(
                    width: 500,
                    child:TextField(
                      controller: _passwordTextController,
                      obscureText: isPasswordType,
                      enableSuggestions: !false,
                      autocorrect: !false,
                      cursorColor: Colors.white,
                      style: TextStyle(color: Colors.white.withOpacity(0.9)),
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.lock_outlined,
                          color: Colors.white70,
                        ),

                        suffixIcon: GestureDetector(onTap:(){
                          setState((){
                            isPasswordType=!isPasswordType;
                          });

                        }

                            ,child: Padding(
                              padding: const EdgeInsets.only(right: 12),
                              child: Icon(isPasswordType ? Icons.visibility: Icons.visibility_off),
                            )
                        ),
                        labelText: "Mot de passe",
                        labelStyle: TextStyle(color: Colors.white.withOpacity(0.9)),
                        filled: true,
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        fillColor: Colors.white.withOpacity(0.3),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            borderSide: const BorderSide(width: 0, style: BorderStyle.none)),
                      ),
                      keyboardType: isPasswordType
                          ? TextInputType.visiblePassword
                          : TextInputType.emailAddress,
                    )
                ),

                SizedBox(
                  height: 5,
                ),

                Container(
                  width: 500,
                  child:  forgetPassword(context),
                ),






                loading? Loading(): Container(
                  width: 500,
                  child:
                  // firebaseUIButton(context,"SE CONNECTER", () {
                  //   setState(() {
                  //     loading=true;
                  //   });
                  //
                  //   FirebaseAuth.instance
                  //       .signInWithEmailAndPassword(
                  //       email: _emailTextController.text,
                  //       password: _passwordTextController.text)
                  //       .then((value) {
                  //     print("Logged in");
                  //
                  //      Navigator.push(context,
                  //         MaterialPageRoute(builder: (context) => Dashboard()));
                  //     Future((){
                  //
                  //       setState(() {
                  //       loading=false;
                  //     });
                  //
                  //       _emailTextController.text="";
                  //       _passwordTextController.text="";
                  //
                  //     });
                  //
                  //   }).onError((error, stackTrace) {
                  //
                  //     setState(() {
                  //       loading=false;
                  //     });
                  //
                  //     ScaffoldMessenger.of(context).showSnackBar(
                  //         SnackBar(content: Text("Login failed!"),backgroundColor: Colors.red,showCloseIcon: true,)
                  //     );
                  //     print("Error ${error.toString()}");
                  //   });
                  // }, Colors.white,Colors.black87),
                  firebaseUIButton(context, "SE CONNECTER", () async {
                    setState(() {
                      loading = true;
                    });

                    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
                        .collection('employee')
                        .where('email', isEqualTo: _emailTextController.text)
                        .get();

                    if (querySnapshot.docs.isNotEmpty) {
                      DocumentSnapshot userSnapshot = querySnapshot.docs.first;
                      Map<String, dynamic>? userData = userSnapshot.data() as Map<String, dynamic>?;

                      if (userData != null && userData['state'] == 'activated') {
                        try {
                          UserCredential userCredential = await FirebaseAuth.instance
                              .signInWithEmailAndPassword(
                              email: _emailTextController.text,
                              password: _passwordTextController.text);

                          User? user = userCredential.user;
                          if (user != null) {
                            String userId = user.uid;
                          print("userId: $userId");
                            // Perform your desired actions with the authenticated user
                            // String id_role="-1";
                            // await FirebaseFirestore.instance
                            //     .collection('employee')
                            //     .doc(userId)
                            //     .get()
                            //     .then((snapshot) async {
                            //   if (snapshot.exists) {
                            //     setState(() async {
                            //       id_role = snapshot.data()!["id_roleEmpls"];
                            //     });
                            //   }
                            // });



                            // Perform your desired actions with the authenticated user
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Dashboard(),
                              ),
                            );
                          }
                        } catch (error) {
                          print("Authentication error: $error");
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Échec de la connexion !"),
                              backgroundColor: Colors.red,
                              showCloseIcon: true,
                            ),
                          );
                        }
                      } else {
                        print("User is not activated");
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Cet utilisateur n'existe plus"),
                            backgroundColor: Colors.red,
                            showCloseIcon: true,
                          ),
                        );
                      }
                    } else {
                      print("User does not exist");
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Cet utilisateur n'esxite pas"),
                          backgroundColor: Colors.red,
                          showCloseIcon: true,
                        ),
                      );
                    }

                    setState(() {
                      loading = false;
                    });

                    _emailTextController.text = "";
                    _passwordTextController.text = "";
                  }, Colors.white, Colors.black87),


                ),


                // Container(
                //   width: 500,
                //   child: signUpOption(),
                //
                // )

              ],
            )

        ),),),);
    }


  Row signUpOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Don't have account?",
            style: TextStyle(color: Colors.white70)),
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => SignUpScreen()));
          },
          child: const Text(
            " Sign Up",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }

  Widget forgetPassword(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 35,
      alignment: Alignment.bottomRight,
      child: TextButton(
        child: const Text(
          "Mot de passe oublié?",
          style: TextStyle(color: Colors.white70),
          textAlign: TextAlign.right,
        ),
        onPressed: () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => ResetPassword())),
      ),
    );
  }


}