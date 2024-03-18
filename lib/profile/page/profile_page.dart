

import 'package:adminsignin/reusable_widget/loading.dart';
import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:adminsignin/profile/model/user.dart';
import 'package:adminsignin/profile/page/edit_profile_page.dart';
import 'package:adminsignin/profile/utils/user_preferences.dart';
import 'package:adminsignin/profile/widget/button_widget.dart';
import 'package:adminsignin/profile/widget/numbers_widget.dart';
import 'package:adminsignin/profile/widget/profile_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:adminsignin/config/responsive.dart';
import 'package:adminsignin/style/colors.dart';
import 'package:adminsignin/colorutils.dart';
import 'package:adminsignin/component/appBarActionItems.dart';
import 'package:adminsignin/component/header.dart';
import 'package:adminsignin/component/sideMenu.dart';
import 'package:adminsignin/config/size_config.dart';


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfilePage extends StatefulWidget {

  ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}



class _ProfilePageState extends State<ProfilePage> {
  //
// String? g= FirebaseAuth.instance.currentUser?.email;

  String ? name='';

  String ? email='';
  String ? about='';

  String ? image='';
  String docId=FirebaseAuth.instance.currentUser!.uid;
  var collectionStream = FirebaseFirestore.instance.collection('employee').doc(FirebaseAuth.instance.currentUser!.uid);


  // var test = FirebaseFirestore.instance.collection('testSubCollection').get();
  // late var restaurantRef = test.reference.parent.parent;
  //


  String defaultPath="https://cdn-icons-png.flaticon.com/512/1560/1560896.png";

  // Future getDataFromDatabase() async{
  //   await FirebaseFirestore.instance.collection('admins').doc(FirebaseAuth.instance.currentUser!.uid).get().then((snapshot) async{
  //     if(snapshot.exists){
  //       setState((){
  //         name=snapshot.data()!["FullName"];
  //         email=snapshot.data()!["Email"];
  //         image=snapshot.data()!["ImagePath"];
  //         about=snapshot.data()!["About"];
  //       });
  //     }
  //   });
  // }
  //
  // @override
  // void initState(){
  //   super.initState();
  //   getDataFromDatabase();
  // }

  //
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      key: _drawerKey,
      drawer: SizedBox(width: 109, child: SideMenu()),
      appBar: !Responsive.isDesktop(context)
          ? AppBar(
        elevation: 0,
        backgroundColor: AppColors.white,
        leading: IconButton(

            onPressed: () {
              _drawerKey.currentState?.openDrawer();
            },
            icon: Icon(Icons.menu, color: hexSrtingToColor('20B2AA'))),
        actions: [
          AppBarActionItems(),
        ],
      )
          : const PreferredSize(
        preferredSize: Size.zero,
        child: SizedBox(),
      ),
      body: StreamBuilder(
        stream: collectionStream.snapshots(),
        builder: (context, snapshot) { if (snapshot.hasError) {
          return Text('Something went wrong');
        }
        // void testing() async{
        //   var col = FirebaseFirestore.instance.collectionGroup('last');
        //   var snapshottest = await col.get();
        //   for (var doc in snapshottest.docs) {
        //     print(doc.reference.parent.parent?.id); // Prints document1, document2
        //
        //     //I need the parent root(The parent of this parent)
        //
        //   }
        // }
        print("************************************");
        // testing();

        print("************************************");


        if (snapshot.hasData) {
          name=snapshot.data!["nom"];
          image=snapshot.data!["ImagePath"];
          email=snapshot.data!["email"];
          about=snapshot.data!["à_propos"];
         return SafeArea(
           child: Row(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               if (Responsive.isDesktop(context))
                 SizedBox(
                   width: 100,
                   child: SideMenu(),
                 ),
               Expanded(
                   flex: 10,
                   child: SafeArea(
                     child: SingleChildScrollView(
                       padding: EdgeInsets.symmetric(vertical: 30, horizontal: 30),
                       child: Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                           Header("SuperAdmin","Profile"),
                           SizedBox(
                             height: SizeConfig.blockSizeVertical * 4*4,
                           ),
                           ProfileWidget(
                             imagePath:image==null ?defaultPath : image!,
                             onClicked: () {
                               // Navigator.of(context).push(
                               //   MaterialPageRoute(builder: (context) => EditProfilePage(docId: docId,)),
                               // );
                             },
                           ),
                           const SizedBox(height: 24),
                           Center(child: buildName()),
                           // const SizedBox(height: 24),
                           // Center(child: buildUpgradeButton()),
                           const SizedBox(height: 24),
                           NumbersWidget(docId: docId, employe: true,),
                           const SizedBox(height: 48),
                           buildAbout(),
                           //   ],
                           // ),
                         ],
                       ),
                     ),
                   )),

             ],
           ),
         );
        }
        
        return Loading();

        }
      ),
    );
  }

  //








  //

  Widget buildName()=> Column(
    children: [
      Text(
        name!,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
      ),
      const SizedBox(height: 4),
      Text(
        email!,
        style: TextStyle(color: Colors.grey),
      )
    ],
  );

  Widget buildUpgradeButton() => ButtonWidget(
    text: 'Upgrade To PRO',
    onClicked: () {},
  );

  Widget buildAbout() => Container(
    padding: EdgeInsets.symmetric(horizontal: 48),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'About',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        Text(
          about!,
          style: TextStyle(fontSize: 16, height: 1.4),
        ),
      ],
    ),
  );
}










