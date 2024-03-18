

import 'package:adminsignin/reusable_widget/loading.dart';
import 'package:adminsignin/reusable_widget/reusablewidget.dart';
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
// import 'package:firebase_auth/firebase_auth.dart';

class EmployeesProfile extends StatefulWidget {
  String docId;
  String role;
  EmployeesProfile({super.key, required this.docId, required this.role});
  // String? get DOCId => docId;
  @override
  State<EmployeesProfile> createState() => _EmployeesProfileState();
}



class _EmployeesProfileState extends State<EmployeesProfile> {


late String _docId;

  @override
  void initState() {
    super.initState();
    _docId = widget.docId;
  }


  String ? name='';

  String ? email='';
  String ? about='';

  String ? image='';
  // var collectionStream = FirebaseFirestore.instance.collection('test').doc(_docId);


TextEditingController _birthTextController = TextEditingController();

  String defaultPath="https://cdn-icons-png.flaticon.com/512/1560/1560896.png";


  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

bool _isTextVisible = true;

void _toggleWidget() {
  setState(() {
    _isTextVisible = !_isTextVisible;
  });
}
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
          stream: FirebaseFirestore.instance.collection('employee').doc(_docId).snapshots(),
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
          // print("************************************");
          // testing();
          //
          // print("************************************");


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
                              Header("${widget.role.toUpperCase()}","Profile"),
                              SizedBox(
                                height: SizeConfig.blockSizeVertical * 4*4,
                              ),
                              ProfileWidget(
                                imagePath:image==null ?defaultPath : image!,
                                onClicked: () {
                                  // Navigator.of(context).push(
                                  //   MaterialPageRoute(builder: (context) => EditProfilePage(docId: _docId,)),
                                  // );
                                },
                              ),
                              const SizedBox(height: 24),
                              Center(child: buildName()),
                              // const SizedBox(height: 24),
                              // Center(child: buildUpgradeButton()),
                              const SizedBox(height: 24),
                              NumbersWidget(docId: _docId, employe: true,),
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
          'EXPERIENCE PROFESSIONNELLE',
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










