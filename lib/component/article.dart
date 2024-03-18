/******New*******/



import 'dart:math';
import 'package:adminsignin/functions/functions.dart';
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
import 'package:adminsignin/component/table.dart';
import 'package:adminsignin/component/sideMenu.dart';
import 'package:adminsignin/config/size_config.dart';
import 'package:intl/intl.dart';

class ArticlesPage extends StatefulWidget {
  const ArticlesPage({super.key});

  @override
  State<ArticlesPage> createState() => ArticlesPageState();
}

class ArticlesPageState extends State<ArticlesPage> {
  final GlobalKey<ScaffoldState> _drawerKey = GlobalKey();


  late FournisseurModel dataEtrp;
  List<FournisseurModel> Etrp = [];
  late String id_entrF;


  List<dynamic> villes = [];
  String? villeId;
  FirebaseFirestore firebaseFiretore = FirebaseFirestore.instance;
  final TextEditingController _desigArticleTextController = TextEditingController();
  // TextEditingController dateinput = TextEditingController();
  final TextEditingController _EntrpTextController = TextEditingController();
  final TextEditingController _userTextController = TextEditingController();
  final TextEditingController _prixVenteTextController = TextEditingController();
  final TextEditingController _prixAchatTextController = TextEditingController();
  final TextEditingController _referenceTextController = TextEditingController();
  final TextEditingController _capitalTextController = TextEditingController();
  final TextEditingController _EntrpFTextController = TextEditingController();
  final TextEditingController _qttTextController = TextEditingController();
  TextEditingController descrTextController = TextEditingController();
  TextEditingController categTextController = TextEditingController();

  // final DataTableSource MyDataTable = MyData();
  String EntrpNom = "";
  String id_entr="";
  // late String id_entrF;

  late String id_user;

  late String id_cat;

  late String rolEtrp="";


  /***/
  // var collectionStreamFourn = FirebaseFirestore.instance.collection('infoEntrp').doc(FirebaseAuth.instance.currentUser!.uid);
  // var collectionStreamCategorie= FirebaseFirestore.instance.collection("catégories").get();

  // /***/
  //
  // Stream<QuerySnapshot> getArticlesStream() {
  //   return  FirebaseFirestore.instance.collection('articles').snapshots();
  // }


  // String getName(String nomCollec, String idDoc, String nom) async{
  //   String NomID="not set";
  //   await FirebaseFirestore.instance
  //       .collection(nomCollec)
  //       .doc(idDoc)
  //       .get()
  //       .then((snapshot) async {
  //     if (snapshot.exists) {
  //       setState(() {
  //         NomID="njdcjsqdncjsk:";
  //         // NomID=snapshot.data()![nom];
  //       });
  //
  //
  //
  //     }
  //
  //   });
  //   return NomID;
  // }

  // late entrpInfoModel dataEtrp;
  // List<entrpInfoModel> Etrp = [];

  //On doit traiter les cas selon le role du currentEntrp pour afficher que les fournisseurs concernés

//   Future getFournData() async {
//     List<entrpInfoModel> newList = [];
//     QuerySnapshot featureSnapShot =
//     await FirebaseFirestore.instance.collection("infoEntrp").get();
//     featureSnapShot.docs.forEach(
//           (element) {
//         dataEtrp = entrpInfoModel(
//           id_Etrp: element["id_Etrp"],
//           designation: element["désignation"],
//           about: element["à_propos"],
//           fax: element["fax"],
//           email: element["email"],
//           id_roleEtrps: element["id_roleEtrps"],
//           ImagePath: element["imagePath"],
//           id_ville: element["id_ville"],
//           infoBc: element["infoBc"],
//           tel: element["tel"],
//           localisation: element["localisation"],
//           adresse: element["adresse"],
//         );
//
//         //Lorsque j'initialise id_entr prend immediatement "", alors que les popAvant de cliquer meme ils prennent cette valeur, car la fct est appelée au debut, mais apres un certain temps
//
//         if (id_entr == "3RExF18oFMEYSatplJIM") {
//           print("Vous etes une Pharmacy");
//           if (dataEtrp.id_roleEtrps == "00jTKhiAdfMt5LO6xet0") {
//             newList.add(dataEtrp);
//           }
//         }
//         else if(id_entr=="00jTKhiAdfMt5LO6xet0"){
//           print("Vous etes un Grossiste");
//           if (dataEtrp.id_roleEtrps == "s5VgYPc7Xu2RNL5lOe3i") {
//             newList.add(dataEtrp);
//           }
//         }
//         else if(id_entr=="s5VgYPc7Xu2RNL5lOe3i"){
//           print("Vous etes une Laboratoire");
//         }
// // ????????
//
//         // if (dataEtrp.id_roleEtrps == "00jTKhiAdfMt5LO6xet0") {
//         //   newList.add(dataEtrp);
//         // }
//       },
//     );
//
//     Etrp = newList;
//     Etrp.sort((a, b) {
//       return a.DESIGNATION.toLowerCase().compareTo(b.DESIGNATION.toLowerCase());
//     });
//   }

  late categoriesModel datacategory;
  List<categoriesModel> category = [];

  // Future getCategData() async {
  //   List<categoriesModel> newList = [];
  //   QuerySnapshot featureSnapShot =
  //       await FirebaseFirestore.instance.collection("catégories").get();
  //   featureSnapShot.docs.forEach(
  //     (element) {
  //       datacategory = categoriesModel(
  //         id_cat: element["id_cat"],
  //         designation: element["désignation"],
  //         about: element["about"],
  //         id_Etrp: element["id_Etrp"],
  //         dateAjout: element["dateAjout"],
  //         id_ajoutPar: element["id_ajoutPar"],
  //         ImagePath: element["ImagePath"],
  //       );
  //       newList.add(datacategory);
  //     },
  //   );
  //
  //   category = newList;
  //   category.sort((a, b) {
  //     return a.DESIGNATION.toLowerCase().compareTo(b.DESIGNATION.toLowerCase());
  //   });
  // }

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
                rolEtrp=snapshot.data()!["id_roleEtrps"];
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
    // getCategData();
    // getFournData();
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
                        Header('Stock', 'Médicaments'),
                        SizedBox(
                          height: 60,
                        ),
                        PrimaryText(
                          text: 'AJOUTER UN MEDICAMENT',
                          size: 18,
                          fontWeight: FontWeight.w800,
                          color: AppColors.them,
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        if (!Responsive.isDesktop(context)) Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(
                                height: 100,
                              ),


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

                              const SizedBox(
                                height: 20,
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
                                          "Désignation",
                                          Icons.circle_rounded,
                                          false,
                                          _desigArticleTextController,
                                          true),
                                    ),
                                  ],
                                ),
                              ),
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
                                            "Catégorie",
                                            Icons.circle_rounded,
                                            false,
                                            categTextController,
                                            false),
                                      ),
                                      Positioned(
                                        bottom: 5,
                                        right: 4,
                                        child: StreamBuilder(
                                            stream: FirebaseFirestore.instance.collection("catégories").snapshots(),
                                            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                              if (snapshot.hasError) {
                                                return const Text('Something went wrong');
                                              }
                                              if (snapshot.hasData){
                                                List<categoriesModel> newList = [];
                                                var docs=snapshot.data?.docs;
                                                docs?.forEach(
                                                        (element){
                                                      var routeArgs = element.data() as Map;

                                                      datacategory = categoriesModel(


                                                        id_cat: routeArgs!["id_cat"],
                                                        designation: routeArgs!["désignation"],
                                                        about: routeArgs!["about"],
                                                        id_Etrp: routeArgs!["id_Etrp"],
                                                        dateAjout: routeArgs!["dateAjout"],
                                                        id_ajoutPar: routeArgs!["id_ajoutPar"],
                                                        ImagePath: routeArgs!["ImagePath"],
                                                        state: routeArgs!["state"],

                                                      );
                                                      if(datacategory.id_Etrp==id_entr && datacategory.state=="activated"){
                                                        newList.add(datacategory);
                                                        // print("datacategory ${id_entr},,, ${datacategory.id_Etrp}");
                                                      }

                                                    });
                                                category = newList;
                                                category.sort((a, b) {
                                                  return a.DESIGNATION.toLowerCase().compareTo(b.DESIGNATION.toLowerCase());

                                                });


                                                // return Loading();
                                                return PopupMenuButton<
                                                    categoriesModel>(
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
                                                      id_cat = choice.ID;

                                                    });
                                                    categTextController.text =
                                                        choice.DESIGNATION;
                                                  },
                                                  itemBuilder:
                                                      (BuildContext context) {

                                                    return category.map(
                                                            (categoriesModel
                                                        choice) {
                                                          return PopupMenuItem<
                                                              categoriesModel>(
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
                                          "Réference",
                                          Icons.circle_rounded,
                                          false,
                                          _referenceTextController,
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



                                      child: TextField(
                                        enabled: true,
                                        controller: _prixAchatTextController,
                                        obscureText: false,
                                        enableSuggestions: !false,
                                        autocorrect: !false,
                                        cursorColor: AppColors.them,
                                        style: const TextStyle(color: AppColors.them),
                                        decoration: InputDecoration(
                                          prefixIcon: const Icon(
                                            Icons.circle_rounded,
                                            color: Colors.white,
                                          ),
                                          labelText: "Prix Achat",
                                          labelStyle: TextStyle(color: Colors.white.withOpacity(0.9)),
                                          filled: true,
                                          floatingLabelBehavior: FloatingLabelBehavior.never,
                                          fillColor: AppColors.them.withOpacity(0.3),
                                          border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(30.0),
                                              borderSide: const BorderSide(width: 0, style: BorderStyle.none)),
                                        ),
                                        keyboardType: false
                                            ? TextInputType.visiblePassword
                                            : TextInputType.emailAddress,

                                        onChanged: (value) {
                                          _updateProduct();
                                        },


                                      ),
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
                                          "Prix Vente",
                                          Icons.circle_rounded,
                                          false,
                                          _prixVenteTextController,
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

                                      child:TextField(
                                        enabled: true,
                                        controller: _qttTextController,
                                        obscureText: false,
                                        enableSuggestions: !false,
                                        autocorrect: !false,
                                        cursorColor: AppColors.them,
                                        style: const TextStyle(color: AppColors.them),
                                        decoration: InputDecoration(
                                          prefixIcon: const Icon(
                                            Icons.circle_rounded,
                                            color: Colors.white,
                                          ),
                                          labelText: "Quantité",
                                          labelStyle: TextStyle(color: Colors.white.withOpacity(0.9)),
                                          filled: true,
                                          floatingLabelBehavior: FloatingLabelBehavior.never,
                                          fillColor: AppColors.them.withOpacity(0.3),
                                          border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(30.0),
                                              borderSide: const BorderSide(width: 0, style: BorderStyle.none)),
                                        ),
                                        keyboardType: false
                                            ? TextInputType.visiblePassword
                                            : TextInputType.emailAddress,

                                        onChanged: (value) {
                                          _updateProduct();
                                        },


                                      ),
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
                                          "Capital",
                                          Icons.circle_rounded,
                                          false,
                                          _capitalTextController,
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
                                          "Déscription",
                                          Icons.circle_rounded,
                                          false,
                                          descrTextController,
                                          true),
                                    ),
                                  ],
                                ),
                              ),

                              Padding(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: Center(
                                  child: Stack(
                                    children: [
                                      Container(
                                        width: MediaQuery.of(context)
                                            .size
                                            .width/4,
                                        child: reusableTextFieldAdd(
                                            "Choisissez Un Fournisseur",
                                            Icons.business,
                                            false,
                                            _EntrpFTextController,
                                            false),
                                      ),
                                      Positioned(
                                        bottom: 5,
                                        right: 4,
                                        child: StreamBuilder(
                                            stream: FirebaseFirestore.instance.collection("Fournisseurs").snapshots(),
                                            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                              if (snapshot.hasError) {
                                                return const Text('Something went wrong');
                                              }
                                              if (snapshot.hasData){

                                                List<FournisseurModel> newList = [];
                                                var docs=snapshot.data?.docs;
                                                docs?.forEach(
                                                        (element){
                                                      var routeArgs = element.data() as Map;

                                                      dataEtrp = FournisseurModel(

                                                        cPostal: element["cPostal"],
                                                        dateAjout: element["dateAjout"],

                                                        id_ajoutPar: element["id_ajoutPar"],

                                                        id_EtrpAddBy: element["id_EtrpAddBy"],


                                                        ImagePath: element["ImagePath"],

                                                        id_Fourn: element["id_Fourn"],
                                                        designation: element["désignation"],

                                                        fax: element["fax"],
                                                        email: element["email"],
                                                        id_ville: element["id_ville"],

                                                        tel: element["tel"],
                                                        state: element["state"],

                                                        adresse: element["adresse"],
                                                      );


                                                      if(dataEtrp.id_EtrpAddBy==id_entr && dataEtrp.state=="activated"){
                                                        newList.add(dataEtrp);
                                                        // print("datacategory ${id_entr},,, ${datacategory.id_Etrp}");

                                                      }




                                                      // newList.add(dataEtrp);
                                                      // print("datacategory ${id_entr},,, ${datacategory.id_Etrp}");


                                                    });
                                                Etrp = newList;
                                                Etrp.sort((a, b) {
                                                  return a.DESIGNATION.toLowerCase().compareTo(b.DESIGNATION.toLowerCase());

                                                });


                                                // return Loading();
                                                return PopupMenuButton<
                                                    FournisseurModel>(
                                                  offset: Offset(20, 0),
                                                  elevation: 8.0,
                                                  shape: const TooltipShape(),
                                                  color:
                                                  hexSrtingToColor("AFD6D0"),
                                                  icon: const Icon(
                                                      Icons.arrow_right_outlined,
                                                      color: Colors.white),
                                                  onSelected: (choice) {
                                                    print(choice);
                                                    setState(() {
                                                      id_entrF = choice.ID;
                                                    });
                                                    _EntrpFTextController.text =
                                                        choice.DESIGNATION;
                                                  },
                                                  itemBuilder:
                                                      (BuildContext context) {
                                                    return Etrp.map(
                                                            (FournisseurModel choice) {
                                                          return PopupMenuItem<
                                                              FournisseurModel>(
                                                            value: choice,
                                                            child: Row(children: [
                                                              const Padding(
                                                                padding:
                                                                EdgeInsets.only(
                                                                    left: 8.0,
                                                                    right: 10.0),

                                                                child: Icon(
                                                                  Icons
                                                                      .circle_rounded,
                                                                  color: Colors.white,
                                                                  size: 10,
                                                                ),
                                                              ),
                                                              Text(
                                                                choice.DESIGNATION,
                                                                style: TextStyle(
                                                                  color: Colors.white,

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
                                          "Ajouté par",
                                          Icons.circle_rounded,
                                          false,
                                          _userTextController,
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
                                          Icons.circle_rounded,
                                          false,
                                          _EntrpTextController,
                                          false),
                                    ),
                                  ],
                                ),
                              ),

                              //time
    //                           Padding(
    //                             padding: const EdgeInsets.only(bottom: 8),
    //                             child: Column(
    //                               mainAxisAlignment:
    //                               MainAxisAlignment.center,
    //                               children: [
    //                                 Container(
    //                                   width: MediaQuery.of(context)
    //                                       .size
    //                                       .width,
    //                                   child:
    //                                     reusableTextFieldAdd( 'Date',
    //                                       Icons.calendar_today,
    //                                       false,
    //                                       dateinput,false)
    //
    // // reusableTextFieldDate(
    // // DateFormat('yyyy-MM-dd   HH:mm')
    // //     .format(DateTime.now()),
    // // Icons.calendar_today,
    // // false,
    // // dateinput, () async {
    // // // dateinput.text=DateFormat('yyyy-MM-dd   HH:mm:ss').format(DateTime.now());
    // // DateTime? pickedDate =
    // // await showDatePicker(
    // // context: context,
    // // initialDate:
    // // DateTime.now(),
    // // firstDate: DateTime(2000),
    // // //DateTime.now() - not to allow to choose before today.
    // // lastDate: DateTime(2101));
    // //
    // // TimeOfDay? pickedTime =
    // // await showTimePicker(
    // // initialTime: TimeOfDay.now(),
    // // context:
    // // context, //context of current state
    // // );
    // //
    // // if (pickedDate != null &&
    // // pickedTime != null) {
    // // print(
    // // pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
    // // String formattedDate =
    // // DateFormat('yyyy-MM-dd')
    // //     .format(pickedDate);
    // // print(
    // // formattedDate); //formatted date output using intl package =>  2021-03-16
    // // //you can implement different kind of Date Format here according to your requirement
    // //
    // // DateTime parsedTime =
    // // DateFormat.jm().parse(
    // // pickedTime
    // //     .format(context)
    // //     .toString());
    // // //converting to DateTime so that we can further format on different pattern.
    // // print(
    // // parsedTime); //output 1970-01-01 22:53:00.000
    // // String formattedTime =
    // // DateFormat('HH:mm')
    // //     .format(parsedTime);
    // //
    // // setState(() {
    // // dateinput.text = formattedDate +
    // // "  " +
    // // formattedTime; //set output date to TextField value.
    // // });
    // // } else {
    // // ScaffoldMessenger.of(context)
    // //     .showSnackBar(SnackBar(
    // // content: Text(
    // // "Selectionner une date!"),
    // // backgroundColor: Colors.red,
    // // showCloseIcon: true,
    // // ));
    // // print("Date is not selected ");
    // // }
    // // }),
    //
    //
    //                                 ),
    //                               ],
    //                             ),
    //                           ),




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
                                          .collection("articles")
                                          .add({
                                        "description":
                                        descrTextController.text,
                                        "désignation":
                                        _desigArticleTextController.text,
                                        "id_ajoutPar": id_user,
                                        // "addBy":addBy,
                                        "id_EtrpC": id_entr,
                                        "state": "activated",
                                        "id_EtrpF": id_entrF,
                                        // "nomF": nomF,
                                        "id_cat": id_cat,
                                        // "nom_cat": nom_Cat,
                                        "prixAchat":
                                        _prixAchatTextController.text,
                                        "prixVente":
                                        _prixVenteTextController.text,
                                        "reference":
                                        _referenceTextController.text,
                                        "Qte": _qttTextController.text,
                                        "capital": _capitalTextController.text,
                                        //prixAchat*qte
                                        "dateAjout": DateFormat('yyyy-MM-dd   HH:mm').format(DateTime.now()),
                                        "ImagePath": "",
                                      }).then((myNewDoc)
                                      async {
                                                  firebaseFiretore
                                                      .collection("articles")
                                                      .doc(myNewDoc.id)
                                                      .update({
                                                    "id_article":
                                                        "${myNewDoc.id}"
                                                  });

                                                  await createHistory( id_entr,  id_user,  DateFormat('yyyy-MM-dd   HH:mm').format(DateTime.now()),  "Ajout de l'article : ${_desigArticleTextController.text} ");


                                      _capitalTextController.text="";
                                                  _qttTextController.text="";
                                                  _referenceTextController.text="";
                                                  _prixVenteTextController.text="";
                                                  _prixAchatTextController.text="";
                                                  _desigArticleTextController.text="";
                                                  descrTextController.text="";
                                                  _EntrpFTextController.text="";
                                                  categTextController.text="";
                                                  ScaffoldMessenger.of(context).showSnackBar(
                                                      SnackBar(content: Text("Ajouté avec succès"),backgroundColor: AppColors.them,showCloseIcon: true,)
                                                  );

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


    PrimaryText(
                                text:
                                'LISTE DES MEDICAMENTS DE LA ${EntrpNom.toUpperCase()}',
                                size: 18,
                                fontWeight: FontWeight.w800,
                                color: AppColors.them,
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
                                        stream: FirebaseFirestore.instance.collection('articles').orderBy('dateAjout', descending: true).snapshots(),
                                        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                          if (!snapshot.hasData) {
                                            return const CircularProgressIndicator();
                                          }

                                          if (snapshot.hasData) {
                                            List<DataRow>? rows = snapshot.data?.docs.where((doc) {
                                              var routeArgs = doc.data() as Map;

                                              return routeArgs['id_EtrpC'] == id_entr && routeArgs['state'] == "activated" ;; // skip rows that don't match the condition
                                            }).map((doc)  {
                                              var routeArgs = doc.data() as Map;
                                              String idCat=routeArgs['id_cat'];
                                              // var nomCat;
                                              // await FirebaseFirestore.instance.collection("catégories").doc(idCat).get().then((snapshot) async {
                                              //   if (snapshot.exists) {
                                              //     setState(() {
                                              //       nomCat="njdcjsqdncjsk:";
                                              //       nomCat=snapshot.data()!['désignation'];
                                              //     });
                                              //
                                              //
                                              //
                                              //   }
                                              //
                                              // });


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
                                                            // FirebaseFirestore.instance.collection('articles').doc(doc.id).delete();
                                                            FirebaseFirestore.instance.collection('articles').doc(doc.id).update({
                                                              "state": "deactivated",
                                                            });
                                                          }),
                                                      // Icon(Icons.edit, color: AppColors.them),
                                                      // Icon(Icons.delete, color: AppColors.them),

                                                    ],


                                                  ),),
                                                  DataCell(Text(routeArgs['reference'] ?? 'default value')),
                                                  DataCell(Text(routeArgs['désignation'] ?? 'default value')),
                                                  DataCell(Text(routeArgs['Qte'] ?? 'default value')),
                                                  DataCell(Text(routeArgs['prixAchat'] ?? 'default value')),
                                                  DataCell(Text(routeArgs['prixVente'] ?? 'default value')),
                                                  DataCell(Text(routeArgs['capital'] ?? 'default value')),
                                                  DataCell(StreamBuilder(
                                                      stream: FirebaseFirestore.instance.collection('catégories').doc(routeArgs['id_cat']).snapshots(),
                                                      builder: (context, snapshot) { if (snapshot.hasError) {
                                                        return Text('Something went wrong');
                                                      }
                                                      if (snapshot.hasData) {
                                                        String NomCat;
                                                        NomCat=snapshot.data!["désignation"];

                                                        return Text(NomCat ?? 'default value');
                                                      }

                                                      return Loading();

                                                      }
                                                  ),),
                                                  DataCell(Text(routeArgs['description'] ?? 'default value')),
                                                  DataCell(StreamBuilder(
                                                      stream: FirebaseFirestore.instance.collection('Fournisseurs').doc(routeArgs['id_EtrpF']).snapshots(),
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
                                                DataColumn(label: Center(child: Text("Réference"))),
                                                DataColumn(label: Center(child: Text("Désignation"))),
                                                DataColumn(label: Center(child: Text("Stock"))),
                                                DataColumn(label: Center(child: Text("Prix Achat"))),
                                                DataColumn(label: Center(child: Text("Prix Vente"))),
                                                DataColumn(label: Center(child: Text("Capital"))),
                                                DataColumn(label: Center(child: Text("Catégorie"))),
                                                DataColumn(label: Center(child: Text("Description"))),
                                                DataColumn(label: Center(child: Text("Fournisseur"))),
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




                            ]) else Column(
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
                                              Icons.circle_rounded,
                                              false,
                                              _desigArticleTextController,
                                              true),
                                        ),
                                      ],
                                    ),
                                  ),

                                        //catPop
                                        Center(
                                          child: Stack(
                                            children: [
                                              Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    4,
                                                child: reusableTextFieldAdd(
                                                    "Catégorie",
                                                    Icons.circle_rounded,
                                                    false,
                                                    categTextController,
                                                    false),
                                              ),
                                              Positioned(
                                                bottom: 5,
                                                right: 4,
                                                child: StreamBuilder(
                                                    stream: FirebaseFirestore.instance.collection("catégories").snapshots(),
                                                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                                      if (snapshot.hasError) {
                                                        return const Text('Something went wrong');
                                                      }
                                                      if (snapshot.hasData){
                                                        List<categoriesModel> newList = [];
                                                        var docs=snapshot.data?.docs;
                                                        docs?.forEach(
                                                                (element){
                                                                  var routeArgs = element.data() as Map;

                                                              datacategory = categoriesModel(


                                                                id_cat: routeArgs!["id_cat"],
                                                                designation: routeArgs!["désignation"],
                                                                about: routeArgs!["about"],
                                                                id_Etrp: routeArgs!["id_Etrp"],
                                                                dateAjout: routeArgs!["dateAjout"],
                                                                id_ajoutPar: routeArgs!["id_ajoutPar"],
                                                                ImagePath: routeArgs!["ImagePath"],
                                                                state: routeArgs!["state"],
                                                              );
                                                              if(datacategory.id_Etrp==id_entr && datacategory.state=="activated"){
                                                                newList.add(datacategory);
                                                                // print("datacategory ${id_entr},,, ${datacategory.id_Etrp}");
                                                              }

                                                            });
                                                        category = newList;
                                                        category.sort((a, b) {
                                                          return a.DESIGNATION.toLowerCase().compareTo(b.DESIGNATION.toLowerCase());

                                                        });


                                                        // return Loading();
                                                        return PopupMenuButton<
                                                            categoriesModel>(
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
                                                              id_cat = choice.ID;

                                                            });
                                                            categTextController.text =
                                                                choice.DESIGNATION;
                                                          },
                                                          itemBuilder:
                                                              (BuildContext context) {

                                                            return category.map(
                                                                    (categoriesModel
                                                                choice) {
                                                                  return PopupMenuItem<
                                                                      categoriesModel>(
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
                                        // Column(
                                        //   mainAxisAlignment:
                                        //   MainAxisAlignment.center,
                                        //   children: [
                                        //     Container(
                                        //       width: MediaQuery.of(context)
                                        //           .size
                                        //           .width /
                                        //           4,
                                        //       child: reusableTextFieldDate(
                                        //           DateFormat(
                                        //               'yyyy-MM-dd   HH:mm')
                                        //               .format(DateTime.now()),
                                        //           Icons.calendar_today,
                                        //           false,
                                        //           dateinput, () async {
                                        //         // dateinput.text=DateFormat('yyyy-MM-dd   HH:mm:ss').format(DateTime.now());
                                        //         DateTime? pickedDate =
                                        //         await showDatePicker(
                                        //             context: context,
                                        //             initialDate:
                                        //             DateTime.now(),
                                        //             firstDate:
                                        //             DateTime(2000),
                                        //             //DateTime.now() - not to allow to choose before today.
                                        //             lastDate:
                                        //             DateTime(2101));
                                        //
                                        //         TimeOfDay? pickedTime =
                                        //         await showTimePicker(
                                        //           initialTime: TimeOfDay.now(),
                                        //           context:
                                        //           context, //context of current state
                                        //         );
                                        //
                                        //         if (pickedDate != null &&
                                        //             pickedTime != null) {
                                        //           print(
                                        //               pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                                        //           String formattedDate =
                                        //           DateFormat('yyyy-MM-dd')
                                        //               .format(pickedDate);
                                        //           print(
                                        //               formattedDate); //formatted date output using intl package =>  2021-03-16
                                        //           //you can implement different kind of Date Format here according to your requirement
                                        //
                                        //           DateTime parsedTime =
                                        //           DateFormat.jm().parse(
                                        //               pickedTime
                                        //                   .format(context)
                                        //                   .toString());
                                        //           //converting to DateTime so that we can further format on different pattern.
                                        //           print(
                                        //               parsedTime); //output 1970-01-01 22:53:00.000
                                        //           String formattedTime =
                                        //           DateFormat('HH:mm')
                                        //               .format(parsedTime);
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
                                          "Réference",
                                          Icons.circle_rounded,
                                          false,
                                          _referenceTextController,
                                          true),
                                    ),
                                  ],
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



                                        child: TextField(
                                          enabled: true,
                                          controller: _prixAchatTextController,
                                          obscureText: false,
                                          enableSuggestions: !false,
                                          autocorrect: !false,
                                          cursorColor: AppColors.them,
                                          style: const TextStyle(color: AppColors.them),
                                          decoration: InputDecoration(
                                            prefixIcon: const Icon(
                                              Icons.circle_rounded,
                                              color: Colors.white,
                                            ),
                                            labelText: "Prix Achat",
                                            labelStyle: TextStyle(color: Colors.white.withOpacity(0.9)),
                                            filled: true,
                                            floatingLabelBehavior: FloatingLabelBehavior.never,
                                            fillColor: AppColors.them.withOpacity(0.3),
                                            border: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(30.0),
                                                borderSide: const BorderSide(width: 0, style: BorderStyle.none)),
                                          ),
                                          keyboardType: false
                                              ? TextInputType.visiblePassword
                                              : TextInputType.emailAddress,

                                          onChanged: (value) {
                                            _updateProduct();
                                          },


                                        ),
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
                                          "Prix Vente",
                                          Icons.circle_rounded,
                                          false,
                                          _prixVenteTextController,
                                          true),
                                    ),
                                  ],
                                ),



                                const SizedBox(
                                  height: 100,
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                  mainAxisAlignment:
                                  MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context)
                                          .size
                                          .width /
                                          4,

                                      child:TextField(
                                        enabled: true,
                                        controller: _qttTextController,
                                        obscureText: false,
                                        enableSuggestions: !false,
                                        autocorrect: !false,
                                        cursorColor: AppColors.them,
                                        style: const TextStyle(color: AppColors.them),
                                        decoration: InputDecoration(
                                          prefixIcon: const Icon(
                                            Icons.circle_rounded,
                                            color: Colors.white,
                                          ),
                                          labelText: "Quantité",
                                          labelStyle: TextStyle(color: Colors.white.withOpacity(0.9)),
                                          filled: true,
                                          floatingLabelBehavior: FloatingLabelBehavior.never,
                                          fillColor: AppColors.them.withOpacity(0.3),
                                          border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(30.0),
                                              borderSide: const BorderSide(width: 0, style: BorderStyle.none)),
                                        ),
                                        keyboardType: false
                                            ? TextInputType.visiblePassword
                                            : TextInputType.emailAddress,

                                        onChanged: (value) {
                                          _updateProduct();
                                        },


                                      ),
                                    ),
                                  ],
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
                                            "Capital",
                                            Icons.circle_rounded,
                                            false,
                                            _capitalTextController,
                                            true),
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
                                          "Déscription",
                                          Icons.circle_rounded,
                                          false,
                                          descrTextController,
                                          true),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 100,
                                ),
                              ],
                            ),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // popF
                                Center(
                                  child: Stack(
                                    children: [
                                      Container(
                                        width: MediaQuery.of(context)
                                            .size
                                            .width/4,
                                        child: reusableTextFieldAdd(
                                            "Choisissez Un Fournisseur",
                                            Icons.business,
                                            false,
                                            _EntrpFTextController,
                                            false),
                                      ),
                                      Positioned(
                                        bottom: 5,
                                        right: 4,
                                        child: StreamBuilder(
                                            stream: FirebaseFirestore.instance.collection("Fournisseurs").snapshots(),
                                            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                              if (snapshot.hasError) {
                                                return const Text('Something went wrong');
                                              }
                                              if (snapshot.hasData){

                                                List<FournisseurModel> newList = [];
                                                var docs=snapshot.data?.docs;
                                                docs?.forEach(
                                                        (element){
                                                      var routeArgs = element.data() as Map;

                                                      dataEtrp = FournisseurModel(

                                                        cPostal: element["cPostal"],
                                                        dateAjout: element["dateAjout"],

                                                        id_ajoutPar: element["id_ajoutPar"],

                                                        id_EtrpAddBy: element["id_EtrpAddBy"],


                                                        ImagePath: element["ImagePath"],
                                                        state: element["state"],

                                                        id_Fourn: element["id_Fourn"],
                                                        designation: element["désignation"],

                                                        fax: element["fax"],
                                                        email: element["email"],
                                                        id_ville: element["id_ville"],

                                                        tel: element["tel"],

                                                        adresse: element["adresse"],
                                                      );


                                                      if(dataEtrp.id_EtrpAddBy==id_entr && dataEtrp.state=="activated"){
                                                        newList.add(dataEtrp);
                                                        // print("datacategory ${id_entr},,, ${datacategory.id_Etrp}");

                                                      }




                                                      // newList.add(dataEtrp);
                                                      // print("datacategory ${id_entr},,, ${datacategory.id_Etrp}");


                                                    });
                                                Etrp = newList;
                                                Etrp.sort((a, b) {
                                                  return a.DESIGNATION.toLowerCase().compareTo(b.DESIGNATION.toLowerCase());

                                                });


                                                // return Loading();
                                                return PopupMenuButton<
                                                    FournisseurModel>(
                                                  offset: Offset(20, 0),
                                                  elevation: 8.0,
                                                  shape: const TooltipShape(),
                                                  color:
                                                  hexSrtingToColor("AFD6D0"),
                                                  icon: const Icon(
                                                      Icons.arrow_right_outlined,
                                                      color: Colors.white),
                                                  onSelected: (choice) {
                                                    print(choice);
                                                    setState(() {
                                                      id_entrF = choice.ID;
                                                    });
                                                    _EntrpFTextController.text =
                                                        choice.DESIGNATION;
                                                  },
                                                  itemBuilder:
                                                      (BuildContext context) {
                                                    return Etrp.map(
                                                            (FournisseurModel choice) {
                                                          return PopupMenuItem<
                                                              FournisseurModel>(
                                                            value: choice,
                                                            child: Row(children: [
                                                              const Padding(
                                                                padding:
                                                                EdgeInsets.only(
                                                                    left: 8.0,
                                                                    right: 10.0),

                                                                child: Icon(
                                                                  Icons
                                                                      .circle_rounded,
                                                                  color: Colors.white,
                                                                  size: 10,
                                                                ),
                                                              ),
                                                              Text(
                                                                choice.DESIGNATION,
                                                                style: TextStyle(
                                                                  color: Colors.white,

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
                                            "Ajouté par",
                                            Icons.circle_rounded,
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
                                          Icons.circle_rounded,
                                          false,
                                          _EntrpTextController,
                                          false),
                                    ),
                                  ],
                                ),

                                const SizedBox(
                                  height: 100,
                                ),
                              ],
                            ),
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.center,
                            //   children: [
                            //     Column(
                            //       mainAxisAlignment:
                            //       MainAxisAlignment.center,
                            //       children: [
                            //         Container(
                            //             width: MediaQuery.of(context)
                            //                 .size
                            //                 .width/4,
                            //             child:
                            //             reusableTextFieldAdd( 'Date',
                            //                 Icons.calendar_today,
                            //                 false,
                            //                 dateinput,false)
                            //
                            //           // reusableTextFieldDate(
                            //           // DateFormat('yyyy-MM-dd   HH:mm')
                            //           //     .format(DateTime.now()),
                            //           // Icons.calendar_today,
                            //           // false,
                            //           // dateinput, () async {
                            //           // // dateinput.text=DateFormat('yyyy-MM-dd   HH:mm:ss').format(DateTime.now());
                            //           // DateTime? pickedDate =
                            //           // await showDatePicker(
                            //           // context: context,
                            //           // initialDate:
                            //           // DateTime.now(),
                            //           // firstDate: DateTime(2000),
                            //           // //DateTime.now() - not to allow to choose before today.
                            //           // lastDate: DateTime(2101));
                            //           //
                            //           // TimeOfDay? pickedTime =
                            //           // await showTimePicker(
                            //           // initialTime: TimeOfDay.now(),
                            //           // context:
                            //           // context, //context of current state
                            //           // );
                            //           //
                            //           // if (pickedDate != null &&
                            //           // pickedTime != null) {
                            //           // print(
                            //           // pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                            //           // String formattedDate =
                            //           // DateFormat('yyyy-MM-dd')
                            //           //     .format(pickedDate);
                            //           // print(
                            //           // formattedDate); //formatted date output using intl package =>  2021-03-16
                            //           // //you can implement different kind of Date Format here according to your requirement
                            //           //
                            //           // DateTime parsedTime =
                            //           // DateFormat.jm().parse(
                            //           // pickedTime
                            //           //     .format(context)
                            //           //     .toString());
                            //           // //converting to DateTime so that we can further format on different pattern.
                            //           // print(
                            //           // parsedTime); //output 1970-01-01 22:53:00.000
                            //           // String formattedTime =
                            //           // DateFormat('HH:mm')
                            //           //     .format(parsedTime);
                            //           //
                            //           // setState(() {
                            //           // dateinput.text = formattedDate +
                            //           // "  " +
                            //           // formattedTime; //set output date to TextField value.
                            //           // });
                            //           // } else {
                            //           // ScaffoldMessenger.of(context)
                            //           //     .showSnackBar(SnackBar(
                            //           // content: Text(
                            //           // "Selectionner une date!"),
                            //           // backgroundColor: Colors.red,
                            //           // showCloseIcon: true,
                            //           // ));
                            //           // print("Date is not selected ");
                            //           // }
                            //           // }),
                            //
                            //
                            //         ),
                            //       ],
                            //     ),
                            //     Padding(
                            //       padding: const EdgeInsets.only(
                            //           left: 16, right: 16),
                            //       child: Column(
                            //         mainAxisAlignment:
                            //         MainAxisAlignment.center,
                            //         children: [
                            //           Container(
                            //             width: MediaQuery.of(context)
                            //                 .size
                            //                 .width /
                            //                 4,
                            //             child: Text(""),
                            //           ),
                            //         ],
                            //       ),
                            //     ),
                            //     Column(
                            //       mainAxisAlignment:
                            //       MainAxisAlignment.center,
                            //       children: [
                            //         Container(
                            //           width: MediaQuery.of(context)
                            //               .size
                            //               .width /
                            //               4,
                            //           child: Text(""),
                            //         ),
                            //       ],
                            //     ),
                            //     const SizedBox(
                            //       height: 100,
                            //     ),
                            //   ],
                            // ),
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
                                          .collection("articles")
                                          .add({
                                        "description":
                                        descrTextController.text,
                                        "désignation":
                                        _desigArticleTextController.text,
                                        "id_ajoutPar": id_user,
                                        // "addBy":addBy,
                                        "id_EtrpC": id_entr,
                                        "id_EtrpF": id_entrF,
                                        "state": "activated",
                                        // "nomF": nomF,
                                        "id_cat": id_cat,
                                        // "nom_cat": nom_Cat,
                                        "prixAchat":
                                        _prixAchatTextController.text,
                                        "prixVente":
                                        _prixVenteTextController.text,
                                        "reference":
                                        _referenceTextController.text,
                                        "Qte": _qttTextController.text,
                                        "capital": _capitalTextController.text,
                                        //prixAchat*qte
                                        "dateAjout": DateFormat('yyyy-MM-dd   HH:mm').format(DateTime.now()),
                                        "ImagePath": "",
                                      }).then((myNewDoc)
                                      async {
                                                  firebaseFiretore
                                                      .collection("articles")
                                                      .doc(myNewDoc.id)
                                                      .update({
                                                    "id_article":
                                                        "${myNewDoc.id}"
                                                  });
                                                  await createHistory( id_entr,  id_user,  DateFormat('yyyy-MM-dd   HH:mm').format(DateTime.now()),  "Ajout de l'article : ${_desigArticleTextController.text} ");

                                      ScaffoldMessenger.of(context).showSnackBar(
                                                      SnackBar(content: Text("Ajouté avec succès"),backgroundColor: AppColors.them,showCloseIcon: true,)
                                                  );
                                                  _capitalTextController.text="";
                                                  _qttTextController.text="";
                                                  _referenceTextController.text="";
                                                  _prixVenteTextController.text="";
                                                  _prixAchatTextController.text="";
                                                  _desigArticleTextController.text="";
                                                  descrTextController.text="";
                                                  _EntrpFTextController.text="";
                                                  categTextController.text="";
                                                }

                                                );
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
                              height: 60,
                            ),
                            PrimaryText(
                              text:
                              'LISTE DES MEDICAMENTS DE LA ${EntrpNom.toUpperCase()}',
                              size: 18,
                              fontWeight: FontWeight.w800,
                              color: AppColors.them,
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
                                    stream: FirebaseFirestore.instance.collection('articles').orderBy('dateAjout', descending: true).snapshots(),
                                    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                      if (!snapshot.hasData) {
                                        return const CircularProgressIndicator();
                                      }

                                      if (snapshot.hasData) {

                                  // var docs=snapshot.data?.docs;
                                  // List<DataRow>? rows=docs?.forEach(
                                  // (element){
                                  // var routeArgs = element.data() as Map;


    //                               List<DataRow>? rows = snapshot.data?.docs.map((doc) {
    //                                         var routeArgs = doc.data() as Map;
    //
    //                 // if(routeArgs!['désignation']==id_entr){
    //
    //                                       return DataRow(
    //
    //                                         cells: [
    //                                     DataCell(Center(child: Text(routeArgs!['désignation'] ??'default value'))),
    //                                           DataCell(Center(child: Text(routeArgs!['reference'] ??'default value' ))),
    //                                           DataCell(Center(child: Text(routeArgs!['Qte'] ??'default value' ))),
    //                                           DataCell(Center(child: Text(routeArgs!['prixAchat'] ??'default value' ))),
    //                                           DataCell(Center(child: Text(routeArgs!['prixVente'] ??'default value' ))),
    //                                           DataCell(Center(child: Text(routeArgs!['capital'] ??'default value' ))),
    //                                           DataCell(Center(child: Text(routeArgs!['id_cat'] ??'default value' ))),
    //                                           DataCell(Center(child: Text(routeArgs!['id_EtrpF'] ??'default value' ))),
    //                                           DataCell(Center(child: Text(routeArgs!['id_ajoutPar'] ??'default value' ))),
    //                                           DataCell(Center(child: Text(routeArgs!['dateAjout'] ??'default value' ))),
    //                                           // add more cells as needed
    //                                         ],
    //                                       );
    //                                     // }
    // }
    //                                     ).toList();


                                        List<DataRow>? rows = snapshot.data?.docs.where((doc) {
                                          var routeArgs = doc.data() as Map;

                                          return routeArgs['id_EtrpC'] == id_entr && routeArgs['state'] == "activated" ;; // skip rows that don't match the condition
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
                                                        // FirebaseFirestore.instance.collection('articles').doc(doc.id).delete();
                                                        FirebaseFirestore.instance.collection('articles').doc(doc.id).update({
                                                          "state": "deactivated",
                                                        });
                                                      }),
                                                  // Icon(Icons.edit, color: AppColors.them),
                                                  // Icon(Icons.delete, color: AppColors.them),

                                                ],


                                              ),),
                                              DataCell(Text(routeArgs['reference'] ?? 'default value')),
                                              DataCell(Text(routeArgs['désignation'] ?? 'default value')),
                                              DataCell(Text(routeArgs['Qte'] ?? 'default value')),
                                              DataCell(Text(routeArgs['prixAchat'] ?? 'default value')),
                                              DataCell(Text(routeArgs['prixVente'] ?? 'default value')),
                                              DataCell(Text(routeArgs['capital'] ?? 'default value')),
                                              DataCell(StreamBuilder(
                                                  stream: FirebaseFirestore.instance.collection('catégories').doc(routeArgs['id_cat']).snapshots(),
                                                  builder: (context, snapshot) { if (snapshot.hasError) {
                                                    return Text('Something went wrong');
                                                  }
                                                  if (snapshot.hasData) {
                                                    String NomCat;
                                                    NomCat=snapshot.data!["désignation"];

                                                    return Text(NomCat ?? 'default value');
                                                  }

                                                  return Loading();

                                                  }
                                              ),),
                                              DataCell(Text(routeArgs['description'] ?? 'default value')),
                                              // DataCell(StreamBuilder(
                                              //     stream: FirebaseFirestore.instance.collection('infoEntrp').doc(routeArgs['id_EtrpF']).snapshots(),
                                              //     builder: (context, snapshot) { if (snapshot.hasError) {
                                              //       return Text('Something went wrong');
                                              //     }
                                              //     if (snapshot.hasData) {
                                              //       String NomFour;
                                              //       NomFour=snapshot.data!["désignation"];
                                              //
                                              //       return Text(NomFour ?? 'default value');
                                              //     }
                                              //
                                              //     return Loading();
                                              //
                                              //     }
                                              // ),),
                                              DataCell(StreamBuilder(
                                                  stream: FirebaseFirestore.instance.collection('Fournisseurs').doc(routeArgs['id_EtrpF']).snapshots(),
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
                                            DataColumn(label: Center(child: Text("Réference"))),
                                            DataColumn(label: Center(child: Text("Désignation"))),
                                            DataColumn(label: Center(child: Text("Stock"))),
                                            DataColumn(label: Center(child: Text("Prix Achat"))),
                                            DataColumn(label: Center(child: Text("Prix Vente"))),
                                            DataColumn(label: Center(child: Text("Capital"))),
                                            DataColumn(label: Center(child: Text("Catégorie"))),
                                            DataColumn(label: Center(child: Text("Description"))),
                                            DataColumn(label: Center(child: Text("Fournisseur"))),
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
  //
  void _updateProduct() {
    double value1 = double.tryParse(_qttTextController.text) ?? 0.0;
    double value2 = double.tryParse(_prixAchatTextController.text) ?? 0.0;
    double product = value1 * value2;
    _capitalTextController.text = product.toStringAsFixed(2);
  }

}


