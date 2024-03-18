import 'dart:math';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';
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
import 'package:flutter_switch/flutter_switch.dart';

import 'package:adminsignin/colorutils.dart';
import 'package:adminsignin/component/appBarActionItems.dart';
import 'package:adminsignin/component/PDF.dart';
import 'package:adminsignin/component/header.dart';
import 'package:adminsignin/component/sideMenu.dart';
import 'package:adminsignin/component/editDmndPrix.dart';
import 'package:adminsignin/config/size_config.dart';
import 'package:intl/intl.dart';
import 'package:adminsignin/component/table.dart';

import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:adminsignin/style/colors.dart';
import 'package:flutter/material.dart';
import 'package:printing/printing.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart' show kIsWeb;

import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:http/http.dart' as http;


import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';

import '../profile/widget/textfield_widget.dart';
import 'editBC.dart';

class versF extends StatefulWidget {
  versF({super.key});

  @override
  State<versF> createState() => versFState();
}

class versFState extends State<versF> {
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

  // List<dynamic> villes = [];
  // String? villeId;
  FirebaseFirestore firebaseFiretore = FirebaseFirestore.instance;
  double deviceHieght(BuildContext context) => MediaQuery.of(context).size.height;
  //TextControllers

  TextEditingController _desigFournTextController = TextEditingController();
  TextEditingController _TTCTextController = TextEditingController();
  TextEditingController _idFactureTextController = TextEditingController();
  // TextEditingController _DateDeCommandeTextController = TextEditingController();
  // TextEditingController _MyCompanyNameTextController = TextEditingController();
  //
  // TextEditingController _nomArticleTextController = TextEditingController();
  // TextEditingController _referenceTextController = TextEditingController();
  // TextEditingController _DescripTextController = TextEditingController();
  // TextEditingController _QuantitTextController = TextEditingController();
  // TextEditingController _PrixUnitaireTextController = TextEditingController();
  // TextEditingController _TaxesTextController = TextEditingController();
  // TextEditingController _SousTTCTextController = TextEditingController();
  // TextEditingController _cdtTextController = TextEditingController();
  //Des Textes

  double _SMHT=0.00;
  double _MHT=0.00;
  double _TOTAL=0.00;

  //Doc PDF
  TextEditingController _villeTextController = TextEditingController();
  TextEditingController _adressTextController = TextEditingController();
  TextEditingController _codePostalTextController = TextEditingController();

  //infoFo

  String fCpostal = "";
  String fAdress = "";

  //infoFo


  String Slogan = "";
  String cPostal = "";
  String shippingAdrss = "";
  String EntrpNom = "";
  String fax = "";
  String tel = "";
  String email = "";


  String id_ville = "";

  late String id_entr;
  late String id_user;
  late String nomEmploye;

  late String descriptionArt;
  late String prixUnArticle;
  late List<Object> taxes=[];

  late List<String> ListArticleInfoToAdd=[];
  late  List<List<String>> listOfListsDesArticles=[];

/*generate dmnd PDF*/
  // final _pdf = pw.Document();
  final _storage = FirebaseStorage.instance;
  final _firestore = FirebaseFirestore.instance;

  // final _tableHeadersBC = ['Réference', 'Article','Date Prévue','Quantité','PU(DH)','Taxe(%)','HT(DH)','TTC(DH)'];
  // List<List<String>> _tableDataBC = [
  //   ['réf', 'Product 1', '10.00', '1', '10.00','','',''],
  //   ['réf', 'Product 2', '20.00', '2', '40.00','','',''],
  //   ['réf', 'Product 3', '15.00', '3', '45.00','','',''],
  // ];

  // late List<List<String>> _tableData;
  String _downloadUrl="";
  String id_commande="";
  late String link;



  late FournisseurModel dataEtrp;
  List<FournisseurModel> Etrp = [];
  late String id_entrF;

  late articlesModel dataArticle;
  List<articlesModel> Articles = [];
  late String id_article;
  late String referenceArticle;


  late villeModel dataville;
  List<villeModel> ville = [];

  // final DataTableSource MyDataTable = MyData();
  bool status = false;
  Future<void> _addVersementFournisseurToFirestore() async { // STOCKER DANS FACTURE AVEC LE MEME ID DE LA COMMANDE
    await _firestore
        .collection(
        "VersementFournisseur")
        .add({
      // 'downloadUrl': _downloadUrl,
      'dateAjout':  DateFormat('yyyy-MM-dd   HH:mm').format(DateTime.now()),
      'etrpID': id_entr,
      'IDaddBy': id_user,
      'id_entrF':  id_entrF,
      'totalTTC': _TTCTextController.text,
      "id_facture":_idFactureTextController.text,
    }).then((myNewDoc)
    async {
      firebaseFiretore
          .collection(
          "VersementFournisseur")
          .doc(myNewDoc.id)
          .update({
        "id_versement":myNewDoc.id,

      });


      // ListArticleInfoToAdd.add(_nomArticleTextController.text);
      // ListArticleInfoToAdd.add(_DescripTextController.text);
      // ListArticleInfoToAdd.add(_QuantitTextController.text);
      // ListArticleInfoToAdd.add(_PrixUnitaireTextController.text);
      // ListArticleInfoToAdd.add(_TaxesTextController.text);
      // ListArticleInfoToAdd.add(_SMHT.toStringAsFixed(2));
      // ListArticleInfoToAdd.add(_SousTTCTextController.text);
      // ListArticleInfoToAdd.add(id_article);


      // await FirebaseFirestore.instance.collection('BC').doc(widget.docId)
      //     .collection('CommandeArticles').get().then((querySnapshot) {
      //   querySnapshot.docs.forEach((doc) {
      //     doc.reference.delete();
      //   });
      // });

      // for (int i = 0; i < listOfListsDesArticles.length; i++) {
      //
      //   _firestore
      //       .collection('facture')
      //       .doc(widget.docId)
      //       .collection('CommandeArticles')
      //       .add({
      //     'nomArticle': listOfListsDesArticles[i][0],
      //     'Descrip': listOfListsDesArticles[i][1],
      //     'Quantit': listOfListsDesArticles[i][2],
      //     'PrixUnitaire': listOfListsDesArticles[i][3],
      //     'Taxes': listOfListsDesArticles[i][4],
      //     'SMHT': listOfListsDesArticles[i][5],
      //     'SousTTC': listOfListsDesArticles[i][6],
      //     'id_article': listOfListsDesArticles[i][7],
      //     'referenceArticle': listOfListsDesArticles[i][8],
      //   });
      // }



      // _desigFournTextController.text="";
      // _emailTextController.text="";
      // _villeTextController.text="";
      // _faxTextController.text="";
      // _telTextController.text="";
      // _adresseTextController.text="";

    });
  }


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
          nomEmploye= snapshot.data()!["nom"];

          await FirebaseFirestore.instance
              .collection('infoEntrp')
              .doc(id_entr)
              .get()
              .then((snapshot) async {
            if (snapshot.exists) {
              setState(() {
                link = snapshot.data()!["logo"] ?? defaultPath;
                shippingAdrss =snapshot.data()!["shippingAdrss"];
                cPostal =snapshot.data()!["cPostal"];
                Slogan =snapshot.data()!["Slogan"];
                email =snapshot.data()!["email"];
                tel =snapshot.data()!["tel"];
                fax =snapshot.data()!["fax"];

                EntrpNom =snapshot.data()!["désignation"];
                // _MyCompanyNameTextController.text=EntrpNom;
                taxes =snapshot.data()!["Taxes"];
                for(var Item in taxes){
                  print("Item");
                  print(Item);
                  print("Item");
                };
                taxes.sort();
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
                        Header('Fournisseurs', 'Versement'),
                        SizedBox(
                          height: 60,
                        ),
                        Responsive.isDesktop(context)?
                        PrimaryText(
                          text: 'AJOUTER UN VERSEMENT ',
                          size: 18,
                          fontWeight: FontWeight.w800,
                          color: AppColors.them,
                        ):PrimaryText(
                          text: '',
                          size: 18,
                          fontWeight: FontWeight.w800,
                          color: AppColors.them,
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        (!Responsive.isDesktop(context))
                        //Mobile
                            ? Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8),
                                child:  Column(
                                  children: [
                                    const PrimaryText(
                                      text: 'Fournisseur: ',
                                      size: 14,
                                      fontWeight: FontWeight.w800,
                                      color: AppColors.them,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 8, right:8),
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
                                                _desigFournTextController,
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

                                                            adresse: element["adresse"],
                                                            state: element["state"],
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
                                                          // _referenceFourTextController.text=id_entrF;
                                                          fCpostal=choice.FAX;
                                                          fAdress=choice.ADRESSE;

                                                        });
                                                        _desigFournTextController.text =
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

                              Column(
                                children: [
                                  const PrimaryText(
                                    text: 'Id Facture: ',
                                    size: 14,
                                    fontWeight: FontWeight.w800,
                                    color: AppColors.them,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 8, right:8),
                                    child: Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: MediaQuery.of(context)
                                              .size
                                              .width/4,
                                          child: reusableTextFieldAdd(
                                              "ID",
                                              Icons.data_array,
                                              false,
                                              _idFactureTextController,
                                              true),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  const PrimaryText(
                                    text: 'Montant (DH) ',
                                    size: 14,
                                    fontWeight: FontWeight.w800,
                                    color: AppColors.them,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 8, right:8),
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
                                              "Montant (DH)",
                                              Icons.monetization_on,
                                              false,
                                              _TTCTextController,
                                              true),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
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
                                        context, "ENREGISTRER", () async {
                                      // await _generateInvoice();
                                      // await _savePdfToFirebaseStorage();
                                      await _addVersementFournisseurToFirestore();
                                      ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(content: Text("Versement enregistré avec succès"),backgroundColor:AppColors.them,showCloseIcon: true,)
                                      );
                                      // Navigator.push(
                                      //   context,
                                      //   MaterialPageRoute(
                                      //     builder: (context) => InvoiceGenerator(),
                                      //   ),
                                      // );
                                      // _desigFournTextController.text="";
                                    }, AppColors.them, Colors.white),
                                  ),
                                ],
                              ),

                            ])
                        //Web
                            : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.end,
                            //   children: [
                            //     SizedBox(
                            //       width:150,
                            //       child:  Stack(
                            //         children: [
                            //           firebaseUIButton(
                            //               context, "ENVOYER ", () {
                            //             Navigator.push(
                            //               context,
                            //               MaterialPageRoute(
                            //                 builder: (context) => InvoiceGenerator(),
                            //               ),
                            //             );
                            //             // _desigFournTextController.text="";
                            //           }, AppColors.btn, AppColors.them),
                            //           Positioned(
                            //             bottom: 30,
                            //             right: 10,
                            //             child: Icon(
                            //                 Icons.alternate_email,
                            //                 color: AppColors.them),
                            //           ),
                            //         ],
                            //       ),
                            //     ),
                            //     SizedBox(
                            //       width:20,
                            //     ),
                            //     SizedBox(
                            //       width:150,
                            //       child:  Stack(
                            //         children: [
                            //           firebaseUIButton(
                            //               context, "IMPRIMER ", ()async {
                            //             // await _generateInvoice();
                            //             await _print();
                            //
                            //             // _desigFournTextController.text="";
                            //           }, AppColors.btn, AppColors.them),
                            //           Positioned(
                            //             bottom: 30,
                            //             right: 10,
                            //             child: Icon(
                            //                 Icons.print,
                            //                 color: AppColors.them),
                            //           ),
                            //         ],
                            //       ),
                            //     ),
                            //     SizedBox(
                            //       width:110,
                            //     ),
                            //   ],
                            // ),
                            //                         Row(
                            //                           mainAxisAlignment: MainAxisAlignment.end,
                            //                           children: [
                            //                             SizedBox(
                            // width:600,
                            //                               child: Divider(
                            //                                     thickness: 1.15,
                            //                                     indent: 30,
                            //                                     endIndent: 90,
                            //                                     color: Colors.black45,
                            //                                   ),
                            //                             ),
                            //                           ],
                            //                         ),


                            SizedBox(height: 20),
                            Padding(
                              padding: const EdgeInsets.only(top: 0),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.center,
                                children: [
                                  Column(
                                    children: [
                                      const PrimaryText(
                                        text: 'Fournisseur: ',
                                        size: 14,
                                        fontWeight: FontWeight.w800,
                                        color: AppColors.them,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(bottom: 8, right:8),
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
                                                  _desigFournTextController,
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

                                                              adresse: element["adresse"],
                                                              state: element["state"],
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
                                                            // _referenceFourTextController.text=id_entrF;
                                                            fCpostal=choice.FAX;
                                                            fAdress=choice.ADRESSE;

                                                          });
                                                          _desigFournTextController.text =
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
                                    ],
                                  ),

                                  Column(
                                    children: [
                                      const PrimaryText(
                                        text: 'Id Facture: ',
                                        size: 14,
                                        fontWeight: FontWeight.w800,
                                        color: AppColors.them,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(bottom: 8, right:8),
                                        child: Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width/4,
                                              child: reusableTextFieldAdd(
                                                  "ID",
                                                  Icons.data_array,
                                                  false,
                                                  _idFactureTextController,
                                                  true),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      const PrimaryText(
                                        text: 'Montant (DH) ',
                                        size: 14,
                                        fontWeight: FontWeight.w800,
                                        color: AppColors.them,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(bottom: 8, right:8),
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
                                                  "Montant (DH)",
                                                  Icons.monetization_on,
                                                  false,
                                                  _TTCTextController,
                                                  true),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),

                            ),
                            // Padding(
                            //   padding: const EdgeInsets.only(top: 0),
                            //   child: Row(
                            //     mainAxisAlignment:
                            //     MainAxisAlignment.center,
                            //     children: [
                            //
                            //       Column(
                            //         children: [
                            //           const PrimaryText(
                            //             text: 'Mon entreprise: ',
                            //             size: 14,
                            //             fontWeight: FontWeight.w800,
                            //             color: AppColors.them,
                            //           ),
                            //           Padding(
                            //             padding: const EdgeInsets.only(bottom: 8, right:8),
                            //             child: Column(
                            //               mainAxisAlignment:
                            //               MainAxisAlignment.center,
                            //               children: [
                            //                 Container(
                            //                   width: MediaQuery.of(context)
                            //                       .size
                            //                       .width/4,
                            //                   child: reusableTextFieldAdd(
                            //                       "Entreprise",
                            //                       Icons.person_outline,
                            //                       false,
                            //                       _MyCompanyNameTextController,
                            //                       false),
                            //                 ),
                            //               ],
                            //             ),
                            //           ),
                            //         ],
                            //       ),
                            //       Column(
                            //         children: [
                            //           const PrimaryText(
                            //             text: '',
                            //             size: 14,
                            //             fontWeight: FontWeight.w800,
                            //             color: AppColors.them,
                            //           ),
                            //           Padding(
                            //             padding: const EdgeInsets.only(bottom: 8, right:8),
                            //             child: Column(
                            //               mainAxisAlignment:
                            //               MainAxisAlignment.center,
                            //               children: [
                            //                 Container(
                            //                     width: MediaQuery.of(context)
                            //                         .size
                            //                         .width /
                            //                         4,
                            //                     child: Text("")
                            //                 ),
                            //               ],
                            //             ),
                            //           ),
                            //         ],
                            //       ),
                            //       Column(
                            //         children: [
                            //           const PrimaryText(
                            //             text: 'Date Prévue: ',
                            //             size: 14,
                            //             fontWeight: FontWeight.w800,
                            //             color: AppColors.them,
                            //           ),
                            //
                            //           Padding(
                            //             padding: const EdgeInsets.only(bottom: 8, right:8),
                            //             child: Column(
                            //               mainAxisAlignment:
                            //               MainAxisAlignment.center,
                            //               children: [
                            //                 Container(
                            //                   width: MediaQuery.of(context)
                            //                       .size
                            //                       .width/4,
                            //                   child:
                            //
                            //
                            //                   reusableTextFieldDate(
                            //                       DateFormat('yyyy-MM-dd   HH:mm')
                            //                           .format(DateTime.now()),
                            //                       Icons.calendar_today,
                            //                       false,
                            //                       _DateDeCommandeTextController, () async {
                            //                     // dateinput.text=DateFormat('yyyy-MM-dd   HH:mm:ss').format(DateTime.now());
                            //                     DateTime? pickedDate =
                            //                     await showDatePicker(
                            //                         context: context,
                            //                         initialDate:
                            //                         DateTime.now(),
                            //                         firstDate: DateTime(2000),
                            //                         //DateTime.now() - not to allow to choose before today.
                            //                         lastDate: DateTime(2101));
                            //
                            //                     TimeOfDay? pickedTime =
                            //                     await showTimePicker(
                            //                       initialTime: TimeOfDay.now(),
                            //                       context:
                            //                       context, //context of current state
                            //                     );
                            //
                            //                     if (pickedDate != null &&
                            //                         pickedTime != null) {
                            //                       print(
                            //                           pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                            //                       String formattedDate =
                            //                       DateFormat('yyyy-MM-dd')
                            //                           .format(pickedDate);
                            //                       print(
                            //                           formattedDate); //formatted date output using intl package =>  2021-03-16
                            //                       //you can implement different kind of Date Format here according to your requirement
                            //
                            //                       DateTime parsedTime =
                            //                       DateFormat.jm().parse(
                            //                           pickedTime
                            //                               .format(context)
                            //                               .toString());
                            //                       //converting to DateTime so that we can further format on different pattern.
                            //                       print(
                            //                           parsedTime); //output 1970-01-01 22:53:00.000
                            //                       String formattedTime =
                            //                       DateFormat('HH:mm')
                            //                           .format(parsedTime);
                            //
                            //                       setState(() {
                            //                         _DateDeCommandeTextController.text = "$formattedDate  $formattedTime"; //set output date to TextField value.
                            //                       });
                            //                     } else {
                            //                       ScaffoldMessenger.of(context)
                            //                           .showSnackBar(const SnackBar(
                            //                         content: Text(
                            //                             "Selectionner une date!"),
                            //                         backgroundColor: Colors.red,
                            //                         showCloseIcon: true,
                            //                       ));
                            //                       print("Date is not selected ");
                            //                     }
                            //                   }),
                            //
                            //
                            //                 ),
                            //               ],
                            //             ),
                            //           ),
                            //
                            //         ],
                            //       ),
                            //
                            //
                            //     ],
                            //   ),
                            //
                            // ),

                            const SizedBox(
                              height: 40,
                            ),

  // Row(
                            //   children: [
                            //     Expanded(
                            //       child: TextFieldWidget(
                            //         label: 'Conditions de réglement',
                            //         controller: _cdtTextController,
                            //         maxLines: 5,
                            //         onChanged: (about) {},
                            //       ),
                            //     ),
                            //   ],
                            // ),


                            //Choix des articles




//Table temporaire
//                             Padding(
//                               padding: const EdgeInsets.only(top: 16, left: 50, right: 50),
//                               child: Table(
//                                 border: TableBorder.all(color: Colors.black45),
//                                 children: [
//                                   const TableRow(
//                                     children: [
//                                       TableCell(
//                                         verticalAlignment: TableCellVerticalAlignment.middle,
//                                         child: Center(
//                                           child: PrimaryText(
//                                             text: 'Action',
//                                             size: 14,
//                                             fontWeight: FontWeight.w600,
//                                             color: Colors.black,
//                                           ),
//                                         ),
//                                       ),
//                                       TableCell(
//                                         verticalAlignment: TableCellVerticalAlignment.middle,
//                                         child: Center(
//                                           child: PrimaryText(
//                                             text: 'Reference Article',
//                                             size: 14,
//                                             fontWeight: FontWeight.w600,
//                                             color: Colors.black,
//                                           ),
//                                         ),
//                                       ),
//                                       TableCell(
//                                         verticalAlignment: TableCellVerticalAlignment.middle,
//                                         child: Center(
//                                           child: PrimaryText(
//                                             text: 'Article',
//                                             size: 14,
//                                             fontWeight: FontWeight.w600,
//                                             color: Colors.black,
//                                           ),
//                                         ),
//                                       ),
//                                       TableCell(
//                                         verticalAlignment: TableCellVerticalAlignment.middle,
//                                         child: Center(
//                                           child: PrimaryText(
//                                             text: 'Déscription',
//                                             size: 14,
//                                             fontWeight: FontWeight.w600,
//                                             color: Colors.black,
//                                           ),
//                                         ),
//                                       ),
//                                       TableCell(
//                                         verticalAlignment: TableCellVerticalAlignment.middle,
//                                         child: Center(
//                                           child: PrimaryText(
//                                             text: 'Quantité',
//                                             size: 14,
//                                             fontWeight: FontWeight.w600,
//                                             color: Colors.black,
//                                           ),
//                                         ),
//                                       ),
//                                       TableCell(
//                                         verticalAlignment: TableCellVerticalAlignment.middle,
//                                         child: Center(
//                                           child: PrimaryText(
//                                             text: 'Prix Unitaire (DH)',
//                                             size: 14,
//                                             fontWeight: FontWeight.w600,
//                                             color: Colors.black,
//                                           ),
//                                         ),
//                                       ),
//                                       TableCell(
//                                         verticalAlignment: TableCellVerticalAlignment.middle,
//                                         child: Center(
//                                           child: PrimaryText(
//                                             text: 'Taxe (%)',
//                                             size: 14,
//                                             fontWeight: FontWeight.w600,
//                                             color: Colors.black,
//                                           ),
//                                         ),
//                                       ),
//                                       TableCell(
//                                         verticalAlignment: TableCellVerticalAlignment.middle,
//                                         child: Center(
//                                           child: PrimaryText(
//                                             text: 'HT (DH)',
//                                             size: 14,
//                                             fontWeight: FontWeight.w600,
//                                             color: Colors.black,
//                                           ),
//                                         ),
//                                       ),
//                                       TableCell(
//                                         verticalAlignment: TableCellVerticalAlignment.middle,
//                                         child: Center(
//                                           child: PrimaryText(
//                                             text: 'TTC (DH)',
//                                             size: 14,
//                                             fontWeight: FontWeight.w600,
//                                             color: Colors.black,
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//
//                                   for (var item in listOfListsDesArticles.reversed)
//                                     TableRow(
//                                       children: [
//                                         TableCell(
//                                           child: IconButton(
//                                               padding: const EdgeInsets.symmetric(horizontal: 10.0),
//                                               iconSize: 20,
//                                               icon: Icon(Icons.delete, color: Colors.red),
//                                               onPressed: () {
//                                                 setState(() {
//                                                   listOfListsDesArticles.remove(item);
//                                                   double? ht=0;
//                                                   double? ttc=0;
//                                                   ht=double.tryParse(item[5]);
//                                                   print("ht: $ht");
//                                                   _MHT=(_MHT - ht!)!;
//                                                   print("_MHT: $_MHT");
//                                                   ttc=double.tryParse(item[6]);
//                                                   print("ttc: $ttc");
//                                                   _TOTAL=(_TOTAL - ttc!)!;
//                                                   print("_TOTAL: $_TOTAL");
//
//                                                 });
//
//                                                 // FirebaseFirestore.instance.collection('articles').doc(doc.id).delete();
//                                               }),
//                                         ),
//
//                                         TableCell(
//                                           verticalAlignment: TableCellVerticalAlignment.middle,
//                                           child: Center(
//                                             child: PrimaryText(
//                                               text: item[8],
//                                               size: 12,
//                                               fontWeight: FontWeight.w400,
//                                               color: Colors.black,
//                                             ),
//                                           ),
//                                         ),
//                                         TableCell(
//                                           verticalAlignment: TableCellVerticalAlignment.middle,
//                                           child: Center(
//                                             child: PrimaryText(
//                                               text: item[0],
//                                               size: 12,
//                                               fontWeight: FontWeight.w400,
//                                               color: Colors.black,
//                                             ),
//                                           ),
//                                         ),
//                                         TableCell(
//                                           verticalAlignment: TableCellVerticalAlignment.middle,
//                                           child: Center(
//                                             child: PrimaryText(
//                                               text: item[1],
//                                               size: 12,
//                                               fontWeight: FontWeight.w400,
//                                               color: Colors.black,
//                                             ),
//                                           ),
//                                         ),
//                                         TableCell(
//                                           verticalAlignment: TableCellVerticalAlignment.middle,
//                                           child: Center(
//                                             child: PrimaryText(
//                                               text: item[2],
//                                               size: 12,
//                                               fontWeight: FontWeight.w400,
//                                               color: Colors.black,
//                                             ),
//                                           ),
//                                         ),
//                                         TableCell(
//                                           verticalAlignment: TableCellVerticalAlignment.middle,
//                                           child: Center(
//                                             child: PrimaryText(
//                                               text:item[3],
//                                               size: 12,
//                                               fontWeight: FontWeight.w400,
//                                               color: Colors.black,
//                                             ),
//                                           ),
//                                         ),
//                                         TableCell(
//                                           verticalAlignment: TableCellVerticalAlignment.middle,
//                                           child: Center(
//                                             child: PrimaryText(
//                                               text: item[4],
//                                               size: 12,
//                                               fontWeight: FontWeight.w400,
//                                               color: Colors.black,
//                                             ),
//                                           ),
//                                         ),
//                                         TableCell(
//                                           verticalAlignment: TableCellVerticalAlignment.middle,
//                                           child: Center(
//                                             child: PrimaryText(
//                                               text: item[5],
//                                               size: 12,
//                                               fontWeight: FontWeight.w400,
//                                               color: Colors.black,
//                                             ),
//                                           ),
//                                         ),
//                                         TableCell(
//                                           verticalAlignment: TableCellVerticalAlignment.middle,
//                                           child: Center(
//                                             child: PrimaryText(
//                                               text: item[6],
//                                               size: 12,
//                                               fontWeight: FontWeight.w400,
//                                               color: Colors.black,
//                                             ),
//                                           ),
//                                         ),
//
//                                       ],
//                                     ),
//                                 ],
//                               ),
//                             ),
                            SizedBox(
                              height: 60,
                            ),




                            firebaseUIButton(
                                context, "ENREGISTRER", () async {
                              // await _generateInvoice();
                              // await _savePdfToFirebaseStorage();
                              await _addVersementFournisseurToFirestore();
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text("Versement enregistré avec succès"),backgroundColor:AppColors.them,showCloseIcon: true,)
                              );
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (context) => InvoiceGenerator(),
                              //   ),
                              // );
                              // _desigFournTextController.text="";
                            }, AppColors.them, Colors.white),

                          ],
                        ),
                        SizedBox(
                          height: 60,
                        ),




                        //Tableau d'affichage


                        Center(
                          child: PrimaryText(
                            text: 'LISTE DES VERSEMENTS DE  ${EntrpNom.toUpperCase()}', size: 18, fontWeight: FontWeight.w800, color: AppColors.them,),
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
                                  stream: FirebaseFirestore.instance.collection('VersementFournisseur').orderBy('dateAjout', descending: true).snapshots(),
                                  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                    if (!snapshot.hasData) {
                                      return const CircularProgressIndicator();
                                    }

                                    if (snapshot.hasData) {
                                      List<DataRow>? rows = snapshot.data?.docs.where((doc) {
                                        var routeArgs = doc.data() as Map;

                                        return routeArgs['etrpID'] == id_entr; // skip rows that don't match the condition
                                      }).map((doc) {
                                        var routeArgs = doc.data() as Map;

                                        return DataRow(
                                          cells: [
                                            DataCell(Row(mainAxisAlignment: MainAxisAlignment.center,
                                              children: [

                                                // IconButton(
                                                //     padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                                //     iconSize: 20,
                                                //     icon: Icon(Icons.edit, color: AppColors.them),
                                                //     onPressed: () {
                                                //       Navigator.push(
                                                //         context,
                                                //         MaterialPageRoute(
                                                //           builder: (context) => editBC(docId: routeArgs['id_Commande'],),
                                                //         ),
                                                //       );
                                                //     }),
                                                IconButton(
                                                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                                    iconSize: 20,
                                                    icon: Icon(Icons.delete, color: Colors.red),
                                                    onPressed: () async {
                                                      await FirebaseFirestore.instance.collection('VersementFournisseur').doc(doc.id).delete();
                                                      // Reference reference = FirebaseStorage.instance.refFromURL(routeArgs['documentPDF']);
                                                      // await reference.delete();
                                                    }),
                                                // Icon(Icons.edit, color: AppColors.them),
                                                // Icon(Icons.delete, color: AppColors.them),

                                              ],


                                            ),),
                                            // DataCell(Text(routeArgs['id_Commande'] ?? 'default value')),

                                            DataCell(Text(routeArgs['id_facture'] ?? 'default value')),
                                            DataCell(StreamBuilder(
                                                stream: FirebaseFirestore.instance.collection('Fournisseurs').doc(routeArgs['id_entrF']).snapshots(),
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
                                            DataCell(Text(routeArgs['totalTTC'] ?? 'default value')),

                                            DataCell(StreamBuilder(
                                                stream: FirebaseFirestore.instance.collection('employee').doc(routeArgs['IDaddBy']).snapshots(),
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
                                            DataCell(Text(routeArgs['dateAjout'].toString() ?? 'default value')),
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
                                          DataColumn(label: Center(child: Text("Id Facture"))),

                                          DataColumn(label: Center(child: Text("Fournisseur"))),
                                          DataColumn(label: Center(child: Text("Montant (DH)"))),
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

