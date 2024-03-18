
import 'package:adminsignin/Model/Models.dart';
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
import 'package:adminsignin/component/newClient.dart';
import 'package:adminsignin/config/size_config.dart';
import 'package:intl/intl.dart';
import 'package:adminsignin/component/table.dart';

class client extends StatefulWidget {
  client({super.key});

  @override
  State<client> createState() => clientState();
}

class clientState extends State<client> {
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

  // List<dynamic> villes = [];
  // String? villeId;
  FirebaseFirestore firebaseFiretore = FirebaseFirestore.instance;
  TextEditingController _desigFournTextController = TextEditingController();

  TextEditingController _adresseTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _faxTextController = TextEditingController();
  TextEditingController _villeTextController = TextEditingController();
  TextEditingController _telTextController = TextEditingController();

  late villeModel dataville;
  List<villeModel> ville = [];

  // final DataTableSource MyDataTable = MyData();
  String EntrpNom = "";
  String id_ville = "";
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
          id_user = snapshot.data()!["id_employe"];

          await FirebaseFirestore.instance
              .collection('infoEntrp')
              .doc(id_entr)
              .get()
              .then((snapshot) async {
            if (snapshot.exists) {
              setState(() {
                EntrpNom =snapshot.data()!["désignation"];
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
                        Header('Clients', 'Ajout client'),
                        SizedBox(
                          height: 60,
                        ),
                        PrimaryText(
                          text: 'AJOUTER UN CLIENT ',
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
                                          _desigFournTextController,
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
                                          "Email",
                                          Icons.person_outline,
                                          false,
                                          _emailTextController,
                                          true),
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
                                          "Fax",
                                          Icons.person_outline,
                                          false,
                                          _faxTextController,
                                          true),
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
                                          "Téléphone",
                                          Icons.person_outline,
                                          false,
                                          _telTextController,
                                          true),
                                    ),
                                  ],
                                ),
                              ),
                              // Padding(
                              //   padding: const EdgeInsets.only(bottom: 8),
                              //   child: Column(
                              //     mainAxisAlignment:
                              //     MainAxisAlignment.center,
                              //     children: [
                              //       Container(
                              //         width: MediaQuery.of(context)
                              //             .size
                              //             .width,
                              //         child: reusableTextFieldAdd(
                              //             "Ville",
                              //             Icons.person_outline,
                              //             false,
                              //             _villeTextController,
                              //             true),
                              //       ),
                              //     ],
                              //   ),
                              // ),

                              Padding(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: Center(
                                  child: Stack(
                                    children: [
                                      Container(
                                        width: MediaQuery.of(context)
                                            .size
                                            .width,
                                        child: reusableTextFieldAdd(
                                            "Ville",
                                            Icons.person_outline,
                                            false,
                                            _villeTextController,
                                            false),
                                      ),
                                      Positioned(
                                        bottom: 5,
                                        right: 4,
                                        child: StreamBuilder(
                                            stream: FirebaseFirestore.instance.collection("villes").snapshots(),
                                            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                              if (snapshot.hasError) {
                                                return const Text('Something went wrong');
                                              }
                                              if (snapshot.hasData){
                                                List<villeModel> newList = [];
                                                var docs=snapshot.data?.docs;
                                                docs?.forEach(
                                                        (element){
                                                      var routeArgs = element.data() as Map;

                                                      dataville = villeModel(


                                                        id: routeArgs!["id_ville"],
                                                        designation: routeArgs!["désignation"],

                                                      );
                                                      newList.add(dataville);

                                                    });
                                                ville = newList;
                                                ville.sort((a, b) {
                                                  return a.DESIGNATION.toLowerCase().compareTo(b.DESIGNATION.toLowerCase());

                                                });


                                                // return Loading();
                                                return PopupMenuButton<
                                                    villeModel>(
                                                  offset: Offset(20, 0),
                                                  constraints: const BoxConstraints.expand(width: 200, height: 300),
                                                  elevation: 8.0,
                                                  shape: const TooltipShape(),
                                                  color: hexSrtingToColor(
                                                      "AFD6D0"),
                                                  icon: const Icon(
                                                      Icons
                                                          .arrow_right_outlined,
                                                      color: Colors.white),
                                                  onSelected: (choice) {
                                                    print(choice);
                                                    setState(() {
                                                      id_ville = choice.ID;

                                                    });
                                                    _villeTextController.text =
                                                        choice.DESIGNATION;
                                                  },
                                                  itemBuilder:
                                                      (BuildContext context) {

                                                    return ville.map(
                                                            (villeModel
                                                        choice) {
                                                          return PopupMenuItem<
                                                              villeModel>(
                                                            value: choice,
                                                            child: Row(children: [
                                                              const Padding(
                                                                padding:
                                                                EdgeInsets.only(
                                                                    left: 8.0,
                                                                    right:
                                                                    10.0),
                                                                // child: SvgPicture.asset(
                                                                //   'assets/pie-chart.svg',
                                                                //   color: AppColors.white,width: 20,height: 20,
                                                                // ),
                                                                child: Icon(
                                                                  Icons
                                                                      .circle_rounded,
                                                                  color:
                                                                  Colors.white,
                                                                  size: 10,
                                                                ),
                                                              ),
                                                              Text(
                                                                choice.DESIGNATION,
                                                                style: const TextStyle(
                                                                  color:
                                                                  Colors.white,
                                                                  // fontWeight: FontWeight.w400,
                                                                  // fontFamily: 'Poppins',
                                                                  fontSize: 14,
                                                                ),
                                                              ),
                                                            ]),
                                                          );
                                                        }).toList();
                                                  },
                                                );

                                              }
                                              return Loading();

                                            }
                                        ),
                                      ),
                                    ],
                                  ),
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
                                          "Adresse",
                                          Icons.person_outline,
                                          false,
                                          _adresseTextController,
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
                                          .collection("Clients")
                                          .add({
                                        "cPostal":"",
                                        "désignation":
                                        _desigFournTextController.text,
                                        "id_ajoutPar": id_user,
                                        "id_EtrpAddBy": id_entr,
                                        // "id_cat": reference.documetID,
                                        "dateAjout": DateFormat('yyyy-MM-dd   HH:mm').format(DateTime.now()),
                                        "ImagePath": "",
                                        "state": "activated",
                                        "adresse":
                                        _adresseTextController.text,
                                        "email":
                                        _emailTextController.text,
                                        "fax":
                                        _faxTextController.text,
                                        "id_ville":
                                        id_ville,
                                        "tel":
                                        _telTextController.text,
                                      }).then((myNewDoc)
                                      {
                                        firebaseFiretore
                                            .collection(
                                            "Clients")
                                            .doc(myNewDoc.id)
                                            .update({
                                          "id_Client":
                                          "${myNewDoc.id}"
                                        });

                                        _desigFournTextController.text="";
                                        _emailTextController.text="";
                                        _villeTextController.text="";
                                        _faxTextController.text="";
                                        _telTextController.text="";
                                        _adresseTextController.text="";

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
                                height: 10,
                              ),

                              MouseRegion(
                                cursor: SystemMouseCursors.click,
                                child: GestureDetector(
                                  onTap: () {

                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => newClient(),
                                      ),
                                    );

                                  },
                                  child: Text(
                                    'Trouver des clients?',
                                    style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      fontSize: 14, fontWeight: FontWeight.w200, color: AppColors.them,
                                    ),
                                  ),
                                ),
                              ),



                              SizedBox(
                                height: 60,
                              ),
                              PrimaryText(
                                text: 'LISTE DES CLIENTS DE LA ${EntrpNom.toUpperCase()}', size: 18, fontWeight: FontWeight.w800, color: AppColors.them,),
                              SizedBox(
                                height: 20,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: double.infinity,
                                    child: StreamBuilder<QuerySnapshot>(
                                        stream: FirebaseFirestore.instance.collection('Clients').orderBy('dateAjout', descending: true).snapshots(),
                                        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                          if (!snapshot.hasData) {
                                            return const CircularProgressIndicator();
                                          }

                                          if (snapshot.hasData) {
                                            List<DataRow>? rows = snapshot.data?.docs.where((doc) {
                                              var routeArgs = doc.data() as Map;

                                              return routeArgs['id_EtrpAddBy'] == id_entr && routeArgs['state'] == "activated"; // skip rows that don't match the condition
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
                                                      // IconButton(
                                                      //     padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                                      //     iconSize: 20,
                                                      //     icon: Icon(Icons.delete, color: Colors.red),
                                                      //     onPressed: () {
                                                      //
                                                      //       FirebaseFirestore.instance.collection('Fournisseurs').doc(doc.id).delete();
                                                      //     }),

                                                      IconButton(
                                                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                                          iconSize: 20,
                                                          icon: Icon(Icons.delete, color: Colors.red),
                                                          onPressed: () {
                                                            showDialog(
                                                              context: context,
                                                              builder: (BuildContext context) {
                                                                return AlertDialog(
                                                                  icon: Icon(Icons.delete, color: Colors.red),
                                                                  title: Text("Confirmation"),
                                                                  content: Text("Voulez-vous vraiment supprimer cet élément ?"),
                                                                  actions: [
                                                                    TextButton(
                                                                      child: PrimaryText(
                                                                        text: 'Annuler',
                                                                        size: 15,
                                                                        fontWeight: FontWeight.w400,
                                                                        color: AppColors.them,
                                                                      ),
                                                                      onPressed: () {
                                                                        Navigator.of(context).pop();
                                                                      },
                                                                    ),
                                                                    TextButton(
                                                                      child:
                                                                      PrimaryText(
                                                                        text: 'Supprimer',
                                                                        size: 15,
                                                                        fontWeight: FontWeight.w400,
                                                                        color:  Colors.red,
                                                                      ),
                                                                      onPressed: () {
                                                                        // FirebaseFirestore.instance.collection('Clients').doc(doc.id).delete();
                                                                        FirebaseFirestore.instance.collection('Clients').doc(doc.id).update({
                                                                          "state": "deactivated",
                                                                        });
                                                                        Navigator.of(context).pop();
                                                                      },
                                                                    ),
                                                                  ],
                                                                );
                                                              },
                                                            );
                                                          }
                                                      ),



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
                                                  DataCell(Text(routeArgs['email'] ?? 'default value')),
                                                  DataCell(Text(routeArgs['fax'] ?? 'default value')),
                                                  DataCell(Text(routeArgs['tel'] ?? 'default value')),
                                                  DataCell(Text(routeArgs['adresse'] ?? 'default value')),
                                                  DataCell(StreamBuilder(
                                                      stream: FirebaseFirestore.instance.collection('villes').doc(routeArgs['id_ville']).snapshots(),
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
                                                  // DataCell(Text(routeArgs['about'] ?? 'default value')),
                                                  // DataCell(Text(routeArgs['id_ajoutPar'] ?? 'default value')),
                                                  // DataCell(Text(routeArgs['adresse'] ?? 'default value')),
                                                  // DataCell(Text(routeArgs['id_Etrp'] ?? 'default value')),

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
                                                DataColumn(label: Center(child: Text("Email"))),
                                                DataColumn(label: Center(child: Text("Fax"))),
                                                DataColumn(label: Center(child: Text("Téléphone"))),
                                                DataColumn(label: Center(child: Text("Ville"))),
                                                DataColumn(label: Center(child: Text("Adresse"))),
                                                // DataColumn(label: Center(child: Text("A propos"))),
                                                DataColumn(label: Center(child: Text("Ajouté par"))),
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
                                            _desigFournTextController,
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
                                            "Email",
                                            Icons.person_outline,
                                            false,
                                            _emailTextController,
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
                                            "Fax",
                                            Icons.person_outline,
                                            false,
                                            _faxTextController,
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
                                            "Téléphone",
                                            Icons.person_outline,
                                            false,
                                            _telTextController,
                                            true),
                                      ),
                                    ],
                                  ),
                                ),

                                // Padding(
                                //   padding: const EdgeInsets.only(
                                //       left: 16, right: 16),
                                //   child: Column(
                                //     mainAxisAlignment:
                                //     MainAxisAlignment.center,
                                //     children: [
                                //       Container(
                                //         width: MediaQuery.of(context)
                                //             .size
                                //             .width /
                                //             4,
                                //         child: reusableTextFieldAdd(
                                //             "Ville",
                                //             Icons.person_outline,
                                //             false,
                                //             _villeTextController,
                                //             true),
                                //       ),
                                //     ],
                                //   ),
                                // ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 16, right: 16),
                                  child: Stack(
                                    children: [
                                      Container(
                                        width: MediaQuery.of(context)
                                            .size
                                            .width /
                                            4,
                                        child: reusableTextFieldAdd(
                                            "Ville",
                                            Icons.person_outline,
                                            false,
                                            _villeTextController,
                                            false),
                                      ),
                                      Positioned(
                                        bottom: 5,
                                        right: 4,
                                        child: StreamBuilder(
                                            stream: FirebaseFirestore.instance.collection("villes").snapshots(),
                                            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                              if (snapshot.hasError) {
                                                return const Text('Something went wrong');
                                              }
                                              if (snapshot.hasData){
                                                List<villeModel> newList = [];
                                                var docs=snapshot.data?.docs;
                                                docs?.forEach(
                                                        (element){
                                                      var routeArgs = element.data() as Map;

                                                      dataville = villeModel(


                                                        id: routeArgs!["id_ville"],
                                                        designation: routeArgs!["désignation"],

                                                      );
                                                      newList.add(dataville);

                                                    });
                                                ville = newList;
                                                ville.sort((a, b) {
                                                  return a.DESIGNATION.toLowerCase().compareTo(b.DESIGNATION.toLowerCase());

                                                });


                                                // return Loading();
                                                return PopupMenuButton<
                                                    villeModel>(
                                                  offset: Offset(20, 0),
                                                  constraints: const BoxConstraints.expand(width: 200, height: 300),
                                                  elevation: 8.0,
                                                  shape: const TooltipShape(),
                                                  color: hexSrtingToColor(
                                                      "AFD6D0"),
                                                  icon: const Icon(
                                                      Icons
                                                          .arrow_right_outlined,
                                                      color: Colors.white),
                                                  onSelected: (choice) {
                                                    print(choice);
                                                    setState(() {
                                                      id_ville = choice.ID;

                                                    });
                                                    _villeTextController.text =
                                                        choice.DESIGNATION;
                                                  },
                                                  itemBuilder:
                                                      (BuildContext context) {

                                                    return ville.map(
                                                            (villeModel
                                                        choice) {
                                                          return PopupMenuItem<
                                                              villeModel>(
                                                            value: choice,
                                                            child: Row(children: [
                                                              const Padding(
                                                                padding:
                                                                EdgeInsets.only(
                                                                    left: 8.0,
                                                                    right:
                                                                    10.0),
                                                                // child: SvgPicture.asset(
                                                                //   'assets/pie-chart.svg',
                                                                //   color: AppColors.white,width: 20,height: 20,
                                                                // ),
                                                                child: Icon(
                                                                  Icons
                                                                      .circle_rounded,
                                                                  color:
                                                                  Colors.white,
                                                                  size: 10,
                                                                ),
                                                              ),
                                                              Text(
                                                                choice.DESIGNATION,
                                                                style: const TextStyle(
                                                                  color:
                                                                  Colors.white,
                                                                  // fontWeight: FontWeight.w400,
                                                                  // fontFamily: 'Poppins',
                                                                  fontSize: 14,
                                                                ),
                                                              ),
                                                            ]),
                                                          );
                                                        }).toList();
                                                  },
                                                );

                                              }
                                              return Loading();

                                            }
                                        ),
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
                                            "Adresse",
                                            Icons.person_outline,
                                            false,
                                            _adresseTextController,
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
                                        .width /
                                        8,
                                    height: 80,
                                    child: firebaseUIButton(
                                        context, "AJOUTER", () {
                                      firebaseFiretore
                                          .collection("Clients")
                                          .add({
                                        "cPostal":"",
                                        "désignation":
                                        _desigFournTextController.text,
                                        "id_ajoutPar": id_user,
                                        "id_EtrpAddBy": id_entr,
                                        // "id_cat": reference.documetID,
                                        "dateAjout": DateFormat('yyyy-MM-dd   HH:mm').format(DateTime.now()),
                                        "ImagePath": "",
                                        "state": "activated",
                                        "adresse":
                                        _adresseTextController.text,
                                        "email":
                                        _emailTextController.text,
                                        "fax":
                                        _faxTextController.text,
                                        "id_ville":
                                        id_ville,
                                        "tel":
                                        _telTextController.text,
                                      }).then((myNewDoc)
                                      {
                                        firebaseFiretore
                                            .collection(
                                            "Clients")
                                            .doc(myNewDoc.id)
                                            .update({
                                          "id_Client":
                                          "${myNewDoc.id}"
                                        });

                                        _desigFournTextController.text="";
                                        _emailTextController.text="";
                                        _villeTextController.text="";
                                        _faxTextController.text="";
                                        _telTextController.text="";
                                        _adresseTextController.text="";

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
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),

                            MouseRegion(
                              cursor: SystemMouseCursors.click,
                              child: GestureDetector(
                                onTap: () {

                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => newClient(),
                                    ),
                                  );

                                },
                                child: Text(
                                  'Trouver des des clients?',
                                  style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    fontSize: 14, fontWeight: FontWeight.w200, color: AppColors.them,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 60,
                            ),
                            PrimaryText(
                              text: 'LISTE DES CLIENTS DE LA ${EntrpNom.toUpperCase()}', size: 18, fontWeight: FontWeight.w800, color: AppColors.them,),
                            SizedBox(
                              height: 20,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: double.infinity,
                                  child: StreamBuilder<QuerySnapshot>(
                                      stream: FirebaseFirestore.instance.collection('Clients').orderBy('dateAjout', descending: true).snapshots(),
                                      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                        if (!snapshot.hasData) {
                                          return const CircularProgressIndicator();
                                        }

                                        if (snapshot.hasData) {
                                          List<DataRow>? rows = snapshot.data?.docs.where((doc) {
                                            var routeArgs = doc.data() as Map;

                                            return routeArgs['id_EtrpAddBy'] == id_entr && routeArgs['state'] == "activated" ; // skip rows that don't match the condition
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
                                                          showDialog(
                                                            context: context,
                                                            builder: (BuildContext context) {
                                                              return AlertDialog(
                                                                icon: Icon(Icons.delete, color: Colors.red),
                                                                title: Text("Confirmation"),
                                                                content: Text("Voulez-vous vraiment supprimer cet élément ?"),
                                                                actions: [
                                                                  TextButton(
                                                                    child: PrimaryText(
                                                                      text: 'Annuler',
                                                                      size: 15,
                                                                      fontWeight: FontWeight.w400,
                                                                      color: AppColors.them,
                                                                    ),
                                                                    onPressed: () {
                                                                      Navigator.of(context).pop();
                                                                    },
                                                                  ),
                                                                  TextButton(
                                                                    child:
                                                                    const PrimaryText(
                                                                      text: 'Supprimer',
                                                                      size: 15,
                                                                      fontWeight: FontWeight.w400,
                                                                      color:  Colors.red,
                                                                    ),
                                                                    onPressed: () {
                                                                      // FirebaseFirestore.instance.collection('Clients').doc(doc.id).delete();
                                                                      FirebaseFirestore.instance.collection('Clients').doc(doc.id).update({
                                                                        "state": "deactivated",
                                                                      });
                                                                      Navigator.of(context).pop();
                                                                    },
                                                                  ),
                                                                ],
                                                              );
                                                            },
                                                          );
                                                        }
                                                    ),
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
                                                DataCell(Text(routeArgs['email'] ?? 'default value')),
                                                DataCell(Text(routeArgs['fax'] ?? 'default value')),
                                                DataCell(Text(routeArgs['tel'] ?? 'default value')),

                                                DataCell(StreamBuilder(
                                                    stream: FirebaseFirestore.instance.collection('villes').doc(routeArgs['id_ville']).snapshots(),
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
                                                // DataCell(Text(routeArgs['about'] ?? 'default value')),
                                                // DataCell(Text(routeArgs['id_ajoutPar'] ?? 'default value')),
                                                DataCell(Text(routeArgs['adresse'] ?? 'default value')),
                                                // DataCell(Text(routeArgs['id_Etrp'] ?? 'default value')),

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
                                              DataColumn(label: Center(child: Text("Email"))),
                                              DataColumn(label: Center(child: Text("Fax"))),
                                              DataColumn(label: Center(child: Text("Téléphone"))),
                                              DataColumn(label: Center(child: Text("Ville"))),
                                              DataColumn(label: Center(child: Text("Adresse"))),
                                              // DataColumn(label: Center(child: Text("A propos"))),
                                              DataColumn(label: Center(child: Text("Ajouté par"))),
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

//CLIENT