import 'package:adminsignin/profile/page/edit_profile_page.dart';
import 'package:adminsignin/profile/widget/button_widget.dart';
import 'package:adminsignin/profile/widget/numbers_widget.dart';
import 'package:adminsignin/profile/widget/profile_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// class BusinessCardUI extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Container(
//           width: MediaQuery.of(context).size.width,
//           height: MediaQuery.of(context).size.height,
//           color: Colors.white,
//           child: CustomPaint(
//             painter: CurvePainter(),
//             child: Column(
//               children: [
//                 SizedBox(
//                   height: MediaQuery.of(context).size.height * 0.25,
//                 ),
//                 Container(
//                   padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
//                   child: CircleAvatar(
//                     radius: MediaQuery.of(context).size.width * 0.09,
//                     backgroundColor: Colors.white,
//                     child: CircleAvatar(
//                       radius: MediaQuery.of(context).size.width * 0.08,
//                       backgroundImage: AssetImage('images/user2.png'),
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   height: 10,
//                 ),
//                 Text(
//                   'Abby Williams',
//                   style: TextStyle(
//                     fontWeight: FontWeight.bold,
//                     fontSize: 18,
//                     letterSpacing: 1.15,
//                   ),
//                 ),
//                 SizedBox(
//                   height: 5,
//                 ),
//                 Text(
//                   'Flutter developer',
//                   style: TextStyle(
//                     color: Colors.grey.shade400,
//                   ),
//                 ),
//                 SizedBox(
//                   height: 3,
//                 ),
//                 Text(
//                   'Location',
//                   style: TextStyle(
//                     color: Colors.grey.shade400,
//                   ),
//                 ),
//                 SizedBox(
//                   height: 15,
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     GestureDetector(
//                       onTap: () {},
//                       child: Container(
//                         padding: EdgeInsets.fromLTRB(2, 1, 1, 3),
//                         width: MediaQuery.of(context).size.width * 0.08,
//                         height: MediaQuery.of(context).size.width * 0.08,
//                         decoration: BoxDecoration(
//                           color: Colors.greenAccent.shade400,
//                           shape: BoxShape.circle,
//                         ),
//                         child: Icon(
//                           CupertinoIcons.phone,
//                           color: Colors.white,
//                           size: 18,
//                         ),
//                       ),
//                     ),
//                     SizedBox(
//                       width: MediaQuery.of(context).size.width * 0.05,
//                     ),
//                     GestureDetector(
//                       onTap: () {},
//                       child: Container(
//                         width: MediaQuery.of(context).size.width * 0.08,
//                         height: MediaQuery.of(context).size.width * 0.08,
//                         decoration: BoxDecoration(
//                           color: Colors.redAccent.shade200,
//                           shape: BoxShape.circle,
//                         ),
//                         child: Icon(
//                           CupertinoIcons.mail,
//                           color: Colors.white,
//                           size: 18,
//                         ),
//                       ),
//                     )
//                   ],
//                 ),
//                 SizedBox(
//                   height: 20,
//                 ),
//                 Divider(
//                   thickness: 1.15,
//                   indent: MediaQuery.of(context).size.width * 0.1,
//                   endIndent: MediaQuery.of(context).size.width * 0.1,
//                   color: Colors.grey.shade400,
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     SizedBox(
//                       width: MediaQuery.of(context).size.width * 0.12,
//                       height: 20,
//                     ),
//                     Text(
//                       'OVERVIEW',
//                       style: TextStyle(
//                         fontSize: 14,
//                         letterSpacing: 1.15,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(
//                   height: 10,
//                 ),
//                 Container(
//                   width: MediaQuery.of(context).size.width * 0.7,
//                   padding: EdgeInsets.fromLTRB(20, 3, 1, 3),
//                   decoration: BoxDecoration(
//                     color: Colors.grey.shade100,
//                     border: Border.all(color: Colors.grey.shade200),
//                     borderRadius: BorderRadius.all(
//                       Radius.circular(20),
//                     ),
//                   ),
//                   child: Row(
//                     children: [
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             'PHONE',
//                             style: TextStyle(
//                               fontWeight: FontWeight.bold,
//                               fontSize: 12,
//                               letterSpacing: 1.15,
//                             ),
//                           ),
//                           SizedBox(
//                             height: 3,
//                           ),
//                           Text(
//                             '(123) 456 7890',
//                             style: TextStyle(
//                               color: Colors.grey,
//                               fontSize: 12,
//                               letterSpacing: 1.1,
//                             ),
//                           )
//                         ],
//                       ),
//                       SizedBox(
//                         width: MediaQuery.of(context).size.width * 0.32,
//                       ),
//                       Container(
//                         width: MediaQuery.of(context).size.width * 0.07,
//                         height: MediaQuery.of(context).size.width * 0.07,
//                         decoration: BoxDecoration(
//                           shape: BoxShape.circle,
//                           color: Colors.greenAccent.shade400,
//                         ),
//                         child: Icon(
//                           CupertinoIcons.phone,
//                           color: Colors.white,
//                           size: 18,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 SizedBox(
//                   height: 10,
//                 ),
//                 GestureDetector(
//                   onTap: () {},
//                   child: Container(
//                     width: MediaQuery.of(context).size.width * 0.7,
//                     padding: EdgeInsets.fromLTRB(20, 3, 1, 3),
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.all(
//                         Radius.circular(20),
//                       ),
//                       color: Colors.grey.shade100,
//                       border: Border.all(
//                         color: Colors.grey.shade200,
//                         width: 1,
//                       ),
//                     ),
//                     child: Row(
//                       children: [
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               'EMAIL',
//                               style: TextStyle(
//                                 fontSize: 12,
//                                 fontWeight: FontWeight.bold,
//                                 letterSpacing: 1.15,
//                               ),
//                             ),
//                             SizedBox(
//                               height: 3,
//                             ),
//                             Text(
//                               'abbywill@example.com',
//                               style: TextStyle(
//                                 color: Colors.grey,
//                                 letterSpacing: 1.0,
//                                 fontSize: 12,
//                               ),
//                             ),
//                           ],
//                         ),
//                         SizedBox(
//                           width: MediaQuery.of(context).size.width * 0.19,
//                         ),
//                         Container(
//                           width: MediaQuery.of(context).size.width * 0.07,
//                           height: MediaQuery.of(context).size.width * 0.07,
//                           decoration: BoxDecoration(
//                               shape: BoxShape.circle, color: Colors.redAccent),
//                           child: Icon(
//                             CupertinoIcons.mail,
//                             color: Colors.white,
//                             size: 16,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   height: 10,
//                 ),
//                 GestureDetector(
//                   onTap: () {},
//                   child: Container(
//                     width: MediaQuery.of(context).size.width * 0.7,
//                     padding: EdgeInsets.fromLTRB(20, 3, 1, 3),
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.all(
//                         Radius.circular(20),
//                       ),
//                       color: Colors.grey.shade100,
//                       border: Border.all(
//                         color: Colors.grey.shade200,
//                         width: 1,
//                       ),
//                     ),
//                     child: Row(
//                       children: [
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               'WEBSITE',
//                               style: TextStyle(
//                                 fontSize: 12,
//                                 fontWeight: FontWeight.bold,
//                                 letterSpacing: 1.15,
//                               ),
//                             ),
//                             SizedBox(
//                               height: 3,
//                             ),
//                             Text(
//                               'www.abbywill.com',
//                               style: TextStyle(
//                                 color: Colors.grey,
//                                 letterSpacing: 1.0,
//                                 fontSize: 12,
//                               ),
//                             ),
//                           ],
//                         ),
//                         SizedBox(
//                           width: MediaQuery.of(context).size.width * 0.27,
//                         ),
//                         Container(
//                           width: MediaQuery.of(context).size.width * 0.07,
//                           height: MediaQuery.of(context).size.width * 0.07,
//                           decoration: BoxDecoration(
//                             shape: BoxShape.circle,
//                             color: Colors.deepPurple.shade300,
//                           ),
//                           child: Icon(
//                             CupertinoIcons.globe,
//                             color: Colors.white,
//                             size: 16,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   height: 20,
//                 ),
//                 Divider(
//                   indent: MediaQuery.of(context).size.width * 0.1,
//                   endIndent: MediaQuery.of(context).size.width * 0.1,
//                   color: Colors.grey.shade400,
//                   thickness: 1,
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     SizedBox(
//                       width: MediaQuery.of(context).size.width * 0.12,
//                       height: 20,
//                     ),
//                     Text(
//                       'SOCIAL',
//                       style: TextStyle(
//                         fontSize: 14,
//                         letterSpacing: 1.15,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(
//                   height: 15,
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     SizedBox(
//                       width: 0,
//                     ),
//                     GestureDetector(
//                       onTap: () {},
//                       child: Container(
//                         width: MediaQuery.of(context).size.width * 0.09,
//                         height: MediaQuery.of(context).size.width * 0.09,
//                         child: Image(
//                           image: AssetImage('images/fb1.png'),
//                         ),
//                       ),
//                     ),
//                     GestureDetector(
//                       onTap: () {},
//                       child: Container(
//                         width: MediaQuery.of(context).size.width * 0.1,
//                         height: MediaQuery.of(context).size.width * 0.1,
//                         child: Image(
//                           image: AssetImage('images/twitter.png'),
//                         ),
//                       ),
//                     ),
//                     GestureDetector(
//                       onTap: () {},
//                       child: Container(
//                         width: MediaQuery.of(context).size.width * 0.1,
//                         height: MediaQuery.of(context).size.width * 0.1,
//                         child: Image(
//                           image: AssetImage('images/linkedIn.png'),
//                         ),
//                       ),
//                     ),
//                     GestureDetector(
//                       onTap: () {},
//                       child: Container(
//                         width: MediaQuery.of(context).size.width * 0.1,
//                         height: MediaQuery.of(context).size.width * 0.1,
//                         child: Image(
//                           image: AssetImage('images/insta-logo.jfif'),
//                         ),
//                       ),
//                     ),
//                     GestureDetector(
//                       onTap: () {},
//                       child: Container(
//                         width: MediaQuery.of(context).size.width * 0.1,
//                         height: MediaQuery.of(context).size.width * 0.1,
//                         child: Image(
//                           image: AssetImage('images/git.png'),
//                         ),
//                       ),
//                     ),
//                   ],
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }


import 'dart:math';

import 'package:adminsignin/Model/Models.dart';
import 'package:adminsignin/component/categorie.dart';
import 'package:adminsignin/component/employees.dart';
import 'package:adminsignin/config/responsive.dart';
import 'package:adminsignin/reusable_widget/loading.dart';
import 'package:adminsignin/reusable_widget/reusablewidget.dart';
import 'package:adminsignin/style/colors.dart';
import 'package:adminsignin/style/style.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:adminsignin/colorutils.dart';
import 'package:adminsignin/component/appBarActionItems.dart';
import 'package:adminsignin/component/header.dart';
import 'package:adminsignin/component/sideMenu.dart';
import 'package:adminsignin/config/size_config.dart';
import 'package:intl/intl.dart';
import 'package:adminsignin/component/table.dart';

import 'editInfo.dart';

class BusinessCardUI extends StatefulWidget {
  BusinessCardUI({super.key});

  @override
  State<BusinessCardUI> createState() => BusinessCardUIState();
}

class BusinessCardUIState extends State<BusinessCardUI> {
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

  List<dynamic> villes = [];
  String? villeId;
  // FirebaseFirestore firebaseFiretore = FirebaseFirestore.instance;
  TextEditingController _desigCatTextController = TextEditingController();
  TextEditingController _aboutTextController = TextEditingController();
  TextEditingController dateinput = TextEditingController();
  TextEditingController _EntrpTextController = TextEditingController();
  TextEditingController _userTextController = TextEditingController();

  // final DataTableSource MyDataTable = MyData();
  double deviceWidth(BuildContext context) => MediaQuery.of(context).size.width;
  String EntrpNom = "";
  late String id_entr="1";
  late String id_user;
  String defaultPath="https://cdn-icons-png.flaticon.com/512/1560/1560896.png";
  Future getDataFromDatabase() async {
    await FirebaseFirestore.instance
        .collection('employee')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((snapshot) async {
      if (snapshot.exists) {
        setState(() async {
          id_entr = snapshot.data()!["id_Etrp"];
          id_user = snapshot.data()!["id_employe"];

          await FirebaseFirestore.instance
              .collection('infoEntrp')
              .doc(id_entr)
              .get()
              .then((snapshot) async {
            if (snapshot.exists) {
              setState(() {
                String EntrpN = snapshot.data()!["désignation"];
                EntrpNom = EntrpN;
              });
            }
          });
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    getDataFromDatabase();
  }

  String ? name='';
  String ? id_roleEtrps='';
  String ? adresse='';
  String ? id_ville='';
  String ? fax='';
  String ? tel='';
  String ? infoBc='';


  String ? email='';
  String ? logo='';
  String ? about='';

  String ? image='';
  String docId=FirebaseAuth.instance.currentUser!.uid;


  // String path = "https://cdn-icons-png.flaticon.com/512/1560/1560896.png";


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
          : PreferredSize(
        preferredSize: Size.zero,
        child: SizedBox(),
      ),
      body:id_entr=="1"?Loading(): StreamBuilder(
          stream:  FirebaseFirestore.instance.collection('infoEntrp').doc(id_entr).snapshots(),
          builder: (context, snapshot) { if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.hasData) {
            name=snapshot.data!["désignation"];
            image=snapshot.data!["imagePath"];
            email=snapshot.data!["email"];
            about=snapshot.data!["à_propos"];
            infoBc=snapshot.data!["infoBc"];
            fax=snapshot.data!["fax"];
            tel=snapshot.data!["tel"];
            id_ville=snapshot.data!["id_ville"];
            adresse=snapshot.data!["adresse"];
            id_roleEtrps=snapshot.data!["id_roleEtrps"];
            logo=snapshot.data!["logo"];
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
                              Header('Informations', 'Entreprise'),
                              SizedBox(
                                height: 60,
                              ),
                              PrimaryText(
                                text: 'LES INFORMATIONS DE $EntrpNom',
                                size: 18,
                                fontWeight: FontWeight.w800,
                                color: AppColors.them,
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                height: 400,
                                color: Colors.white,
                                child: CustomPaint(
                                  painter: CurvePainter(),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 50,
                                      ),
                                      Container(
                                        padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                        child: CircleAvatar(
                                          radius: 110,
                                          backgroundColor: Colors.white,
                                          child: ProfileWidget(
                                            imagePath:image==null ?defaultPath : image!,
                                            onClicked: () {
                                              Navigator.of(context).push(
                                                MaterialPageRoute(builder: (context) => EditInfoPage(docId: id_entr,)),
                                              );
                                            },
                                          ),
                                        ),
                                      ),

                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                color: Colors.white,
                                child: Column(

                                  children: [
                                    // const SizedBox(height: 24),
                                    Center(child: buildName()),
                                    // const SizedBox(height: 24),
                                    // Center(child: buildUpgradeButton()),
                                    const SizedBox(height: 24),
                                    NumbersWidget(docId: id_entr, employe: false,),
                                    const SizedBox(height: 48),
                                    Divider(
                                      thickness: 1.15,
                                      indent: MediaQuery.of(context).size.width * 0.1,
                                      endIndent: MediaQuery.of(context).size.width * 0.1,
                                      color: Colors.grey.shade400,
                                    ),
                                    const SizedBox(height: 48),
                                    buildAbout(),
                                    const SizedBox(height: 20),
                                    // Divider(
                                    //   thickness: 1.15,
                                    //   indent: MediaQuery.of(context).size.width * 0.1,
                                    //   endIndent: MediaQuery.of(context).size.width * 0.1,
                                    //   color: Colors.grey.shade400,
                                    // ),
                                    // const SizedBox(height: 48),
                                    // buildAbout(),
                                  ],
                                ),
                              ),

                              SizedBox(
                                height: 60,
                              ),


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
    padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 48),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Fax : ',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.them),
                ),
                Expanded(
                  child: Text(
                    fax!,
                    style: TextStyle(fontSize: 20, height: 1.4),
                  ),
                ),

              ]

          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Téléphone : ',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.them),
                ),
                Expanded(
                  child: Text(
                    tel!,
                    style: TextStyle(fontSize: 20, height: 1.4),
                  ),
                ),
              ]

          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'RIB : ',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.them),
                ),
                Expanded(
                  child: Text(
                    infoBc!,
                    style: TextStyle(fontSize: 20, height: 1.4),
                  ),
                ),
              ]

          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Rôle : ',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.them),
                ),
                Expanded(
                  child: StreamBuilder(
                      stream:  FirebaseFirestore.instance.collection('roleEtrps').doc(id_roleEtrps).snapshots(),
                      builder: (context, snapshot) { if (snapshot.hasError) {
                        return Text('Something went wrong');
                      }
                      String role='';
                      if (snapshot.hasData) {
                        role=snapshot.data!["désignation"];

                        return Text(
                          role!,
                          style: TextStyle(fontSize: 20, height: 1.4),
                        );
                      }

                      return Loading();

                      }
                  ),
                ),
              ]

          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Ville : ',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.them),
                ),
                Expanded(
                  child: StreamBuilder(
                      stream:  FirebaseFirestore.instance.collection('villes').doc(id_ville).snapshots(),
                      builder: (context, snapshot) { if (snapshot.hasError) {
                        return Text('Something went wrong');
                      }
                      String ville='';
                      if (snapshot.hasData) {
                        ville=snapshot.data!["désignation"];

                        return Text(
                          ville!,
                          style: TextStyle(fontSize: 20, height: 1.4),
                        );
                      }

                      return Loading();

                      }
                  ),
                ),
              ]

          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Adresse : ',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.them),
                ),
                Expanded(
                  child: Text(
                    adresse!,
                    style: TextStyle(fontSize: 20, height: 1.4),
                  ),
                ),
              ]

          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 30),
          child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'A propos : ',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.them),
                ),
                Expanded(
                  child: Text(
                    about!,
                    style: TextStyle(fontSize: 20, height: 1.4),
                  ),
                ),
              ]

          ),
        ),
        Padding(
          padding:  EdgeInsets.symmetric(horizontal: deviceWidth(context) * 0.1),
          child: CircleAvatar(
            backgroundColor: Colors.black12,
            radius: 50,
            backgroundImage: NetworkImage(logo!),
          ),
        ),
      ],
    ),
  );

}






class CurvePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.style = PaintingStyle.fill;
    paint.shader = LinearGradient(
        colors: [Color(0xff00816D), Color(0xff20B2AA), Color(0xffBCF0AC)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight)
        .createShader(
      Rect.fromLTRB(
        size.width * 0.15,
        size.height * 0.15,
        size.width,
        size.height * 0.1,
      ),
    );
    var path = Path();
    path.moveTo(0, size.height * 0.15);
    path.quadraticBezierTo(
        size.width * 0.48, size.height * 0.38, size.width, size.height * 0.25);
    path.quadraticBezierTo(
        size.width * 0.9, size.height * 0.38, size.width, size.height * 0.25);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }
}
