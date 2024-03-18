import 'package:adminsignin/colorutils.dart';
import 'package:adminsignin/profile/page/profile_page.dart';
import 'package:adminsignin/reusable_widget/loading.dart';
import 'package:adminsignin/screens/signin_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:cloud_firestore/cloud_firestore.dart';




class AppBarActionItems extends StatefulWidget {
  @override
  State<AppBarActionItems> createState() => _AppBarActionItemsState();
}

class _AppBarActionItemsState extends State<AppBarActionItems> {
  var collectionStream = FirebaseFirestore.instance.collection('employee').doc(FirebaseAuth.instance.currentUser!.uid);

  String image='';

  String defaultPath="https://cdn-icons-png.flaticon.com/512/1560/1560896.png";


  Future getDataFromDatabase() async{
    await FirebaseFirestore.instance.collection('employee').doc(FirebaseAuth.instance.currentUser!.uid).get().then((snapshot) async{
      if(snapshot.exists){
        setState((){
          image=snapshot.data()!["ImagePath"];
        });
      }
    });
  }



  @override
  void initState(){
    super.initState();
    getDataFromDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        IconButton(
            icon: SvgPicture.asset('assets/ring.svg', width: 20.0,color: hexSrtingToColor('20B2AA')),
            onPressed: () {}),

        const SizedBox(width: 10),
    InkWell(
    child: CircleAvatar(
    radius: 17,
    backgroundImage: NetworkImage(
    image=='' ?defaultPath : image
    // image==null ?defaultPath : image!
    // defaultPath,

    ),


    ),
    onTap: () {
    print("moving to ${ProfilePage()}");
    Navigator.push(
    context,
    MaterialPageRoute(
    builder: (context) => ProfilePage(),
    ),
    );
    },
    ),

        const SizedBox(width: 15),


        // StreamBuilder(
        //     stream: collectionStream.snapshots(),
        //     builder: (context, snapshot) { if (snapshot.hasError) {
        //       return const Text('Something went wrong');
        //     }
        //     if (snapshot.hasData){
        //       var doc = snapshot.data!;
        //       image=doc["ImagePath"];
        //       return InkWell(
        //         child: CircleAvatar(
        //           radius: 17,
        //           backgroundImage: NetworkImage(
        //               image=='' ?defaultPath : image
        //             // image==null ?defaultPath : image!
        //             // defaultPath,
        //
        //           ),
        //
        //
        //         ),
        //         onTap: () {
        //           print("moving to ${ProfilePage()}");
        //           Navigator.push(
        //             context,
        //             MaterialPageRoute(
        //               builder: (context) => ProfilePage(),
        //             ),
        //           );
        //         },
        //       );
        //     }
        //     return Loading();
        //     }
        // ),


        // Row(children: [
        //   CircleAvatar(
        //     radius: 17,
        //     backgroundImage: NetworkImage(
        //       'https://cdn.shopify.com/s/files/1/0045/5104/9304/t/27/assets/AC_ECOM_SITE_2020_REFRESH_1_INDEX_M2_THUMBS-V2-1.jpg?v=8913815134086573859',
        //     ),
        //   ),
        //   Icon(Icons.arrow_drop_down_outlined,color: hexSrtingToColor('20B2AA'))
        // ]),



        // IconButton(
        //
        //     onPressed: () {
        //       // Navigator.push(context,
        //       //     MaterialPageRoute(builder: (context) => SignInScreen()));
        //
        //
        //
        //       Future<void> _signOut() async {
        //         await FirebaseAuth.instance.signOut().then((value) {
        //           print("Logged out");
        //         });
        //       }
        //
        //       _signOut();
        //
        //       Navigator.push(
        //         context,
        //         MaterialPageRoute(
        //           builder: (context) => const SignInScreen(),
        //         ),
        //       );
        //
        //     },
        //     icon: Icon(Icons.logout,color: hexSrtingToColor('20B2AA')))
        IconButton(
          onPressed: () async {
            await FirebaseAuth.instance.signOut().then((value) {
              print("Logged out");
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => SignInScreen()),
                    (route) => false,
              );
            });
          },
          icon: Icon(Icons.logout, color: hexSrtingToColor('20B2AA')),
        )

      ],
    );
  }
}
