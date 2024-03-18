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

class typeCharges extends StatefulWidget {
  typeCharges({super.key});

  @override
  State<typeCharges> createState() => typeChargesState();
}

class typeChargesState extends State<typeCharges> {
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

  List<dynamic> villes = [];
  String? villeId;
  FirebaseFirestore firebaseFiretore = FirebaseFirestore.instance;
  TextEditingController _desigCatTextController = TextEditingController();
  TextEditingController _aboutTextController = TextEditingController();
  TextEditingController dateinput = TextEditingController();
  TextEditingController _EntrpTextController = TextEditingController();
  TextEditingController _userTextController = TextEditingController();

  // final DataTableSource MyDataTable = MyData();
  String EntrpNom = "";
  late String id_entr;
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
          _userTextController.text = snapshot.data()!["nom"];
          id_user = snapshot.data()!["id_employe"];

          await FirebaseFirestore.instance
              .collection('infoEntrp')
              .doc(id_entr)
              .get()
              .then((snapshot) async {
            if (snapshot.exists) {
              setState(() {
                _EntrpTextController.text = snapshot.data()!["désignation"];
                EntrpNom = _EntrpTextController.text;
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


  String path = "https://cdn-icons-png.flaticon.com/512/1560/1560896.png";
  late final image = NetworkImage(path);

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
      body: SafeArea(
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
                        Header('Charges', 'Type de charge'),
                        SizedBox(
                          height: 60,
                        ),
                        PrimaryText(
                          text: 'AJOUTER UN TYPE DE CHARGE',
                          size: 18,
                          fontWeight: FontWeight.w800,
                          color: AppColors.them,
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        (!Responsive.isDesktop(context))
                            ? Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [

                              Padding(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: Column(
                                  mainAxisAlignment:
                                  MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context)
                                          .size
                                          .width,
                                      child: reusableTextFieldAdd(
                                          "Désignation",
                                          Icons.person_outline,
                                          false,
                                          _desigCatTextController,
                                          true),
                                    ),
                                  ],
                                ),
                              ),





                              const SizedBox(
                                height: 20,
                              ),
                              Column(
                                mainAxisAlignment:
                                MainAxisAlignment.center,
                                children: [
                                  Container(
                                    width:
                                    MediaQuery.of(context).size.width,
                                    child: firebaseUIButton(
                                        context, "AJOUTER", () {
                                      firebaseFiretore
                                          .collection("typeCharges")
                                          .add({

                                        "désignation":
                                        _desigCatTextController.text,
                                        "id_ajoutPar": id_user,
                                        "id_Etrp": id_entr,
                                        "state": "activated",
                                        "icon": "assets/charges.svg",
                                        // "id_cat": reference.documetID,
                                        "dateAjout": DateFormat('yyyy-MM-dd   HH:mm').format(DateTime.now()),

                                      }).then((myNewDoc)
                                      {
                                        firebaseFiretore
                                            .collection(
                                            "typeCharges")
                                            .doc(myNewDoc.id)
                                            .update({
                                          "id_type":
                                          "${myNewDoc.id}"
                                        });

                                        _desigCatTextController.text="";

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
                                    }, AppColors.them, Colors.white),
                                  ),
                                ],
                              ),

                              SizedBox(
                                height: 60,
                              ),

                            ])
                            : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [

                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 16, right: 16),
                                  child: Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: MediaQuery.of(context)
                                            .size
                                            .width/2,
                                        child: reusableTextFieldAdd(
                                            "Désignation",
                                            Icons.person_outline,
                                            false,
                                            _desigCatTextController,
                                            true),
                                      ),
                                    ],
                                  ),
                                ),



                                const SizedBox(
                                  height: 100,
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      right: 75, top: 20),
                                  child: Container(
                                    width: MediaQuery.of(context)
                                        .size
                                        .width/8,
                                    height: 80,
                                    child: firebaseUIButton(
                                        context, "AJOUTER", () {
                                      firebaseFiretore
                                          .collection("typeCharges")
                                          .add({
                                        "désignation":
                                        _desigCatTextController.text,
                                        "id_ajoutPar": id_user,
                                        "id_Etrp": id_entr,
                                        "state": "activated",
                                        "icon": "assets/charges.svg",

                                        // "id_cat": reference.documetID,
                                        "dateAjout": DateFormat('yyyy-MM-dd   HH:mm').format(DateTime.now()),
                                      }).then((myNewDoc)
                                      {
                                        firebaseFiretore
                                            .collection(
                                            "typeCharges")
                                            .doc(myNewDoc.id)
                                            .update({
                                          "id_type":
                                          "${myNewDoc.id}"
                                        });
                                        _desigCatTextController.text="";
                                      });
                                    }, AppColors.them, Colors.white),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 60,
                            ),

                          ],
                        ),

                        Center(
                          child: PrimaryText(
                            text: 'LISTE DES TYPES DES CHARGES DE LA ${EntrpNom.toUpperCase()}', size: 18, fontWeight: FontWeight.w800, color: AppColors.them,),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: double.infinity,
                              child: StreamBuilder<QuerySnapshot>(
                                  stream: FirebaseFirestore.instance.collection('typeCharges').orderBy('dateAjout', descending: true).snapshots(),
                                  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                    if (!snapshot.hasData) {
                                      return const CircularProgressIndicator();
                                    }

                                    if (snapshot.hasData) {
                                      List<DataRow>? rows = snapshot.data?.docs.where((doc) {
                                        var routeArgs = doc.data() as Map;

                                        return routeArgs['id_Etrp'] == id_entr && routeArgs['state'] =="activated"; // skip rows that don't match the condition
                                      }).map((doc) {
                                        var routeArgs = doc.data() as Map;
                                        // String idCat=routeArgs['id_cat'];


                                        return DataRow(
                                          cells: [
                                            DataCell(Row(mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                IconButton(
                                                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                                    iconSize: 20,
                                                    icon: Icon(Icons.delete, color: Colors.red),
                                                    onPressed: () {
                                                      // FirebaseFirestore.instance.collection('typeCharges').doc(doc.id).delete();
                                                      FirebaseFirestore.instance.collection('typeCharges').doc(doc.id).update({
                                                        "state": "deactivated",
                                                      });
                                                    }),
                                                // Icon(Icons.edit, color: AppColors.them),
                                                // Icon(Icons.delete, color: AppColors.them),

                                              ],


                                            ),),

                                            DataCell(Text(routeArgs['désignation'] ?? 'default value')),
                                            // DataCell(Text(routeArgs['about'] ?? 'default value')),
                                            // DataCell(Text(routeArgs['id_ajoutPar'] ?? 'default value')),
                                            DataCell(StreamBuilder(
                                                stream: FirebaseFirestore.instance.collection('employee').doc(routeArgs['id_ajoutPar']).snapshots(),
                                                builder: (context, snapshot) { if (snapshot.hasError) {
                                                  return Text('Something went wrong');
                                                }
                                                if (snapshot.hasData) {
                                                  String addBy;
                                                  addBy=snapshot.data!["nom"];

                                                  return Text(addBy ?? 'default value');
                                                }

                                                return Loading();

                                                }
                                            ),),
                                            // DataCell(Text(routeArgs['id_Etrp'] ?? 'default value')),
                                            DataCell(StreamBuilder(
                                                stream: FirebaseFirestore.instance.collection('infoEntrp').doc(routeArgs['id_Etrp']).snapshots(),
                                                builder: (context, snapshot) { if (snapshot.hasError) {
                                                  return Text('Something went wrong');
                                                }
                                                if (snapshot.hasData) {
                                                  String addBy;
                                                  addBy=snapshot.data!["désignation"];

                                                  return Text(addBy ?? 'default value');
                                                }

                                                return Loading();

                                                }
                                            ),),
                                            DataCell(Text(routeArgs['dateAjout'] ?? 'default value')),
                                            // add more cells as needed
                                          ],
                                        );
                                      }).toList();



                                      return PaginatedDataTable(
                                        columns: const [
                                          DataColumn(label: Padding(
                                            padding: EdgeInsets.only(left: 10),
                                            child: Center(child: Text("Action")),
                                          )),
                                          DataColumn(label: Center(child: Text("Désignation"))),
                                          // DataColumn(label: Center(child: Text("A propos"))),
                                          DataColumn(label: Center(child: Text("Ajouté par"))),
                                          DataColumn(label: Center(child: Text("Société"))),
                                          DataColumn(label: Center(child: Text("Date d'ajout"))),
                                        ],
                                        source: MyData(rows!),
                                        // header:  PrimaryText(
                                        //   text: 'LISTE DES CATEGORIES DE LA ${EntrpNom.toUpperCase()}', size: 18, fontWeight: FontWeight.w800, color: AppColors.them,)
                                        horizontalMargin: 2,
                                        rowsPerPage: 8,
                                      );
                                    }
                                    return Text("ERROR");


                                  }
                              ),
                            )
                          ],
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
      ),
    );
  }
}

