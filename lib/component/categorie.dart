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
import 'package:adminsignin/functions/functions.dart';

import 'package:adminsignin/colorutils.dart';
import 'package:adminsignin/component/appBarActionItems.dart';
import 'package:adminsignin/component/header.dart';
import 'package:adminsignin/component/sideMenu.dart';
import 'package:adminsignin/config/size_config.dart';
import 'package:intl/intl.dart';
import 'package:adminsignin/component/table.dart';

class CategoriePage extends StatefulWidget {
  CategoriePage({super.key});

  @override
  State<CategoriePage> createState() => CategoriePageState();
}

class CategoriePageState extends State<CategoriePage> {
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
  Future<void> ADD() async { // STOCKER DANS FACTURE AVEC LE MEME ID DE LA COMMANDE

    await firebaseFiretore
        .collection("catégories")
        .add({
      "about":
      _aboutTextController.text,
      "désignation":
      _desigCatTextController.text,
      "id_ajoutPar": id_user,
      "id_Etrp": id_entr,
      "dateAjout": DateFormat('yyyy-MM-dd   HH:mm').format(DateTime.now()),
      "ImagePath": "",
      "state": "activated",
    }).then((myNewDoc)
    async {
      await firebaseFiretore
          .collection(
          "catégories")
          .doc(myNewDoc.id)
          .update({
        "id_cat":
        "${myNewDoc.id}"
      });

    });

    await createHistory( id_entr,  id_user,  DateFormat('yyyy-MM-dd   HH:mm').format(DateTime.now()),  "Ajout de la catégorie : ${_desigCatTextController.text} ");
    _desigCatTextController.text="";

  }

  @override
  void initState() {
    super.initState();
    getDataFromDatabase();
  }

  // Future<List<OrderModel>> getAllOrders() async =>
  //     firebaseFiretore.collection(collection).get().then((result) {
  //       List<OrderModel> orders = [];
  //       for (DocumentSnapshot order in result.docs) {
  //         orders.add(OrderModel.fromSnapshot(order));
  //       }
  //       return orders;
  //     });

  String path = "https://cdn-icons-png.flaticon.com/512/1560/1560896.png";
  late final image = NetworkImage(path);

  @override
  Widget build(BuildContext context) {
    // final ProductProvider villeProvider = Provider.of<ProductProvider>(context);
    // villeProvider.getFeatureData();
    // List<villeModel> listeVille= villeProvider.getFeatureList;

    // dateinput.text=DateFormat('yyyy-MM-dd   HH:mm').format(DateTime.now());
    // print( dateinput.text);

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
                        Header('Stock', 'Catégories'),
                        SizedBox(
                          height: 60,
                        ),
                        PrimaryText(
                          text: 'AJOUTER UNE CATEGORIE',
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
                                    // const SizedBox(
                                    //   height: 300,
                                    // ),

                                    //à remplacer par l'mage
                                    Column(
                                      children: [
                                        // const Padding(
                                        // padding: EdgeInsets.all(8.0),
                                        // child: PrimaryText(
                                        // color: AppColors.them,
                                        // text: "Ajouter une image",
                                        // size: 14,
                                        // fontWeight: FontWeight.w800),
                                        // ),

                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 30, bottom: 20),
                                          child: Center(
                                            child: Container(
                                              width: 80,
                                              child: ClipOval(
                                                child: Material(
                                                  color: Colors.transparent,
                                                  child: Ink.image(
                                                    image: image,
                                                    fit: BoxFit.cover,
                                                    width: 80,
                                                    height: 80,
                                                    child:
                                                        InkWell(onTap: () {}),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),

                                    // const SizedBox(
                                    //   height: 20,
                                    // ),
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
                                    // Padding(
                                    //   padding: const EdgeInsets.only(bottom: 8),
                                    //   child: Column(
                                    //     mainAxisAlignment:
                                    //         MainAxisAlignment.center,
                                    //     children: [
                                    //       Container(
                                    //         width: MediaQuery.of(context)
                                    //             .size
                                    //             .width,
                                    //         child: reusableTextFieldDate(
                                    //             DateFormat('yyyy-MM-dd   HH:mm')
                                    //                 .format(DateTime.now()),
                                    //             Icons.calendar_today,
                                    //             false,
                                    //             dateinput, () async {
                                    //           // dateinput.text=DateFormat('yyyy-MM-dd   HH:mm:ss').format(DateTime.now());
                                    //           DateTime? pickedDate =
                                    //               await showDatePicker(
                                    //                   context: context,
                                    //                   initialDate:
                                    //                       DateTime.now(),
                                    //                   firstDate: DateTime(2000),
                                    //                   //DateTime.now() - not to allow to choose before today.
                                    //                   lastDate: DateTime(2101));
                                    //
                                    //           TimeOfDay? pickedTime =
                                    //               await showTimePicker(
                                    //             initialTime: TimeOfDay.now(),
                                    //             context:
                                    //                 context, //context of current state
                                    //           );
                                    //
                                    //           if (pickedDate != null &&
                                    //               pickedTime != null) {
                                    //             print(
                                    //                 pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                                    //             String formattedDate =
                                    //                 DateFormat('yyyy-MM-dd')
                                    //                     .format(pickedDate);
                                    //             print(
                                    //                 formattedDate); //formatted date output using intl package =>  2021-03-16
                                    //             //you can implement different kind of Date Format here according to your requirement
                                    //
                                    //             DateTime parsedTime =
                                    //                 DateFormat.jm().parse(
                                    //                     pickedTime
                                    //                         .format(context)
                                    //                         .toString());
                                    //             //converting to DateTime so that we can further format on different pattern.
                                    //             print(
                                    //                 parsedTime); //output 1970-01-01 22:53:00.000
                                    //             String formattedTime =
                                    //                 DateFormat('HH:mm')
                                    //                     .format(parsedTime);
                                    //
                                    //             setState(() {
                                    //               dateinput.text = formattedDate +
                                    //                   "  " +
                                    //                   formattedTime; //set output date to TextField value.
                                    //             });
                                    //           } else {
                                    //             ScaffoldMessenger.of(context)
                                    //                 .showSnackBar(SnackBar(
                                    //               content: Text(
                                    //                   "Selectionner une date!"),
                                    //               backgroundColor: Colors.red,
                                    //               showCloseIcon: true,
                                    //             ));
                                    //             print("Date is not selected ");
                                    //           }
                                    //         }),
                                    //       ),
                                    //     ],
                                    //   ),
                                    // ),

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
                                                "Entreprise",
                                                Icons.person_outline,
                                                false,
                                                _EntrpTextController,
                                                false),
                                          ),
                                        ],
                                      ),
                                    ),
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
                                                "Entreprise",
                                                Icons.person_outline,
                                                false,
                                                _userTextController,
                                                false),
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
                                              context, "AJOUTER", () async {


                                            await ADD();
                                            // firebaseFiretore
                                            //     .collection("catégories")
                                            //     .add({
                                            //   "about":
                                            //       _aboutTextController.text,
                                            //   "désignation":
                                            //       _desigCatTextController.text,
                                            //   "id_ajoutPar": id_user,
                                            //   "id_Etrp": id_entr,
                                            //   // "id_cat": reference.documetID,
                                            //   "dateAjout": DateFormat('yyyy-MM-dd   HH:mm').format(DateTime.now()),
                                            //   "ImagePath": "",
                                            // }).then((myNewDoc)
                                            // {
                                            //           firebaseFiretore
                                            //               .collection(
                                            //                   "catégories")
                                            //               .doc(myNewDoc.id)
                                            //               .update({
                                            //             "id_cat":
                                            //                 "${myNewDoc.id}"
                                            //           });
                                            //
                                            //           _desigCatTextController.text="";
                                            //
                                            //         });
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
                                  PrimaryText(
                                    text: 'LISTE DES CATEGORIES DE LA ${EntrpNom.toUpperCase()}', size: 18, fontWeight: FontWeight.w800, color: AppColors.them,),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width: double.infinity,
                                        child: StreamBuilder<QuerySnapshot>(
                                            stream: FirebaseFirestore.instance.collection('catégories').orderBy('dateAjout', descending: true).snapshots(),
                                            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                              if (!snapshot.hasData) {
                                                return const CircularProgressIndicator();
                                              }

                                              if (snapshot.hasData) {
                                                List<DataRow>? rows = snapshot.data?.docs.where((doc) {
                                                  var routeArgs = doc.data() as Map;

                                                  return routeArgs['id_Etrp'] == id_entr && routeArgs['state'] == "activated" ; // skip rows that don't match the condition
                                                }).map((doc) {
                                                  var routeArgs = doc.data() as Map;
                                                  // String idCat=routeArgs['id_cat'];
                                                  var photo= routeArgs['ImagePath'];

                                                  return DataRow(
                                                    cells: [
                                                      DataCell(Row(mainAxisAlignment: MainAxisAlignment.center,
                                                        children: [
                                                          IconButton(
                                                              padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                                              iconSize: 20,
                                                              icon: Icon(Icons.edit, color: AppColors.them),
                                                              onPressed: () {
                                                                // Navigator.push(
                                                                //   context,
                                                                //   MaterialPageRoute(
                                                                //     builder: (context) => employees(),
                                                                //   ),
                                                                // );
                                                              }),
                                                          IconButton(
                                                              padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                                              iconSize: 20,
                                                              icon: Icon(Icons.delete, color: Colors.red),
                                                              onPressed: () {
                                                                // FirebaseFirestore.instance.collection('catégories').doc(doc.id).delete();
                                                                FirebaseFirestore.instance.collection('catégories').doc(doc.id).update({
                                                                  "state": "deactivated",
                                                                });
                                                              }),
                                                          // Icon(Icons.edit, color: AppColors.them),
                                                          // Icon(Icons.delete, color: AppColors.them),

                                                        ],


                                                      ),),
                                                      DataCell(InkWell(
                                                        child: CircleAvatar(
                                                          radius: 17,
                                                          backgroundImage: NetworkImage(
                                                              image=='' ?defaultPath : photo
                                                            // image==null ?defaultPath : image!
                                                            // defaultPath,

                                                          ),


                                                        ),
                                                        onTap: () {
                                                          print("moving to EmployeesProfile");
                                                        },
                                                      )),

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
                                                    DataColumn(label: Center(child: Text("Image"))),
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
                                  )
                                  ])
                            : Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        //à remplacer par l'mage
                                        Column(
                                          children: [
                                            // const Padding(
                                            // padding: EdgeInsets.all(8.0),
                                            // child: PrimaryText(
                                            // color: AppColors.them,
                                            // text: "Ajouter une image",
                                            // size: 14,
                                            // fontWeight: FontWeight.w800),
                                            // ),
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  4,
                                              // height: MediaQuery. of(context). size. width/12,
                                              child: Center(
                                                // width: MediaQuery. of(context). size. width/12,
                                                // height: MediaQuery. of(context). size. width/12,
                                                child: ClipOval(
                                                  child: Material(
                                                    color: Colors.transparent,
                                                    child: Ink.image(
                                                      image: image,
                                                      fit: BoxFit.cover,
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width /
                                                              12,
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width /
                                                              12,
                                                      child:
                                                          InkWell(onTap: () {}),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),

                                        // const SizedBox(
                                        //   height: 20,
                                        // ),
                                        Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                                  4,
                                              child: Text(""),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                                  4,
                                              child: Text(""),
                                            ),
                                          ],
                                        ),
                                        // Column(
                                        //   mainAxisAlignment:
                                        //       MainAxisAlignment.center,
                                        //   children: [
                                        //     Container(
                                        //       width: MediaQuery.of(context)
                                        //               .size
                                        //               .width /
                                        //           4,
                                        //       child: reusableTextFieldDate(
                                        //           DateFormat(
                                        //                   'yyyy-MM-dd   HH:mm')
                                        //               .format(DateTime.now()),
                                        //           Icons.calendar_today,
                                        //           false,
                                        //           dateinput, () async {
                                        //         // dateinput.text=DateFormat('yyyy-MM-dd   HH:mm:ss').format(DateTime.now());
                                        //         DateTime? pickedDate =
                                        //             await showDatePicker(
                                        //                 context: context,
                                        //                 initialDate:
                                        //                     DateTime.now(),
                                        //                 firstDate:
                                        //                     DateTime(2000),
                                        //                 //DateTime.now() - not to allow to choose before today.
                                        //                 lastDate:
                                        //                     DateTime(2101));
                                        //
                                        //         TimeOfDay? pickedTime =
                                        //             await showTimePicker(
                                        //           initialTime: TimeOfDay.now(),
                                        //           context:
                                        //               context, //context of current state
                                        //         );
                                        //
                                        //         if (pickedDate != null &&
                                        //             pickedTime != null) {
                                        //           print(
                                        //               pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                                        //           String formattedDate =
                                        //               DateFormat('yyyy-MM-dd')
                                        //                   .format(pickedDate);
                                        //           print(
                                        //               formattedDate); //formatted date output using intl package =>  2021-03-16
                                        //           //you can implement different kind of Date Format here according to your requirement
                                        //
                                        //           DateTime parsedTime =
                                        //               DateFormat.jm().parse(
                                        //                   pickedTime
                                        //                       .format(context)
                                        //                       .toString());
                                        //           //converting to DateTime so that we can further format on different pattern.
                                        //           print(
                                        //               parsedTime); //output 1970-01-01 22:53:00.000
                                        //           String formattedTime =
                                        //               DateFormat('HH:mm')
                                        //                   .format(parsedTime);
                                        //
                                        //           setState(() {
                                        //             dateinput.text = formattedDate +
                                        //                 "  " +
                                        //                 formattedTime; //set output date to TextField value.
                                        //           });
                                        //         } else {
                                        //           ScaffoldMessenger.of(context)
                                        //               .showSnackBar(SnackBar(
                                        //             content: Text(
                                        //                 "Selectionner une date!"),
                                        //             backgroundColor: Colors.red,
                                        //             showCloseIcon: true,
                                        //           ));
                                        //           print("Date is not selected");
                                        //         }
                                        //       }),
                                        //     ),
                                        //   ],
                                        // ),

                                        // const SizedBox(
                                        //   height: 20,
                                        // ),
                                      ],
                                    ),
                                  ),
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
                                                  .width /
                                                  4,
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
                                                      .width /
                                                  4,
                                              child: reusableTextFieldAdd(
                                                  "Ajouté par",
                                                  Icons.person_outline,
                                                  false,
                                                  _userTextController,
                                                  false),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                4,
                                            child: reusableTextFieldAdd(
                                                "Entreprise",
                                                Icons.person_outline,
                                                false,
                                                _EntrpTextController,
                                                false),
                                          ),
                                        ],
                                      ),

                                      // Padding(
                                      //   padding: const EdgeInsets.only(right:20),
                                      //   child: Container(
                                      //     width: MediaQuery. of(context). size. width/8,
                                      //     height: 80,
                                      //     child: firebaseUIButton(context, "AJOUTER", () {
                                      //       firebaseFiretore.collection("catégories").add({
                                      //         "about": _aboutTextController.text,
                                      //         "désignation": _desigCatTextController.text,
                                      //         "id_ajoutPar": id_user ,
                                      //         "id_Etrp": id_entr,
                                      //         "dateAjout": dateinput.text,
                                      //         "ImagePath": "",
                                      //
                                      //       }).then((myNewDoc) => firebaseFiretore.collection("catégories").doc(myNewDoc.id).update({"cart": "${myNewDoc.id}"}));
                                      //
                                      //
                                      //     }, AppColors.them,Colors.white),
                                      //   ),
                                      // ),

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
                                                  .width /
                                              8,
                                          height: 80,
                                          child: firebaseUIButton(
                                              context, "AJOUTER", () async {
                                            await ADD();
                                          }, AppColors.them, Colors.white),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 60,
                                  ),
                                  PrimaryText(
                                    text: 'LISTE DES CATEGORIES DE LA ${EntrpNom.toUpperCase()}', size: 18, fontWeight: FontWeight.w800, color: AppColors.them,),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width: double.infinity,
                                        child: StreamBuilder<QuerySnapshot>(
                                            stream: FirebaseFirestore.instance.collection('catégories').orderBy('dateAjout', descending: true).snapshots(),
                                            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                              if (!snapshot.hasData) {
                                                return const CircularProgressIndicator();
                                              }

                                              if (snapshot.hasData) {
                                                List<DataRow>? rows = snapshot.data?.docs.where((doc) {
                                                  var routeArgs = doc.data() as Map;

                                                  return routeArgs['id_Etrp'] == id_entr && routeArgs['state'] == "activated" ;
                                                }).map((doc) {
                                                  var routeArgs = doc.data() as Map;
                                                  // String idCat=routeArgs['id_cat'];
                                                  var photo= routeArgs['ImagePath'];

                                                  return DataRow(
                                                    cells: [
                                                      DataCell(Row(mainAxisAlignment: MainAxisAlignment.center,
                                                        children: [
                                                          IconButton(
                                                              padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                                              iconSize: 20,
                                                              icon: Icon(Icons.edit, color: AppColors.them),
                                                              onPressed: () {
                                                                // Navigator.push(
                                                                //   context,
                                                                //   MaterialPageRoute(
                                                                //     builder: (context) => employees(),
                                                                //   ),
                                                                // );
                                                              }),
                                                          IconButton(
                                                              padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                                              iconSize: 20,
                                                              icon: Icon(Icons.delete, color: Colors.red),
                                                              onPressed: () {
                                                                // FirebaseFirestore.instance.collection('catégories').doc(doc.id).delete();
                                                                FirebaseFirestore.instance.collection('catégories').doc(doc.id).update({
                                                                  "state": "deactivated",
                                                                });
                                                              }),
                                                          // Icon(Icons.edit, color: AppColors.them),
                                                          // Icon(Icons.delete, color: AppColors.them),

                                                        ],


                                                      ),),
                                                      DataCell(InkWell(
                                                        child: CircleAvatar(
                                                          radius: 17,
                                                          backgroundImage: NetworkImage(
                                                              image=='' ?defaultPath : photo
                                                            // image==null ?defaultPath : image!
                                                            // defaultPath,

                                                          ),


                                                        ),
                                                        onTap: () {
                                                          print("moving to EmployeesProfile");
                                                        },
                                                      )),

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
                                                    DataColumn(label: Center(child: Text("Image"))),
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

