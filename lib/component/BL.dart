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

import '../functions/functions.dart';
import '../profile/widget/textfield_widget.dart';
import 'editBC.dart';
import 'editBL.dart';

class BL extends StatefulWidget {
  BL({super.key});

  @override
  State<BL> createState() => BLState();
}

class BLState extends State<BL> {
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

  // List<dynamic> villes = [];
  // String? villeId;
  FirebaseFirestore firebaseFiretore = FirebaseFirestore.instance;
  double deviceHieght(BuildContext context) => MediaQuery.of(context).size.height;
  //TextControllers

  TextEditingController _desigFournTextController = TextEditingController();
  TextEditingController _referenceFourTextController = TextEditingController();
  TextEditingController _ListeDePrixTextController = TextEditingController();
  TextEditingController _DateDeCommandeTextController = TextEditingController();
  TextEditingController _MyCompanyNameTextController = TextEditingController();

  TextEditingController _nomArticleTextController = TextEditingController();
  TextEditingController _referenceTextController = TextEditingController();
  TextEditingController _DescripTextController = TextEditingController();
  TextEditingController _QuantitTextController = TextEditingController();
  TextEditingController _PrixUnitaireTextController = TextEditingController();
  TextEditingController _TaxesTextController = TextEditingController();
  TextEditingController _SousTTCTextController = TextEditingController();
  TextEditingController _cdtTextController = TextEditingController();
  TextEditingController _desigLivreurTextController = TextEditingController();

  //Des Textes
  String faxC = "";

  double _SMHT=0.00;
  double _MHT=0.00;
  double _TOTAL=0.00;

  late String id_livreur;
  late LivreurModel dataLivreur;
  List<LivreurModel> Livreur = [];
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
  int qttTableAchat= 0;
  bool _isLoading = false;
  bool _isLoadingPrint= false;
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

  final _tableHeadersBL = ['Réference', 'Article', 'Déscription', 'PU(DH)', 'Quantité'];
  List<List<String>> _tableDataBL = [
    ['réf', 'Product 1', '10.00', '1', '10.00'],
    ['réf', 'Product 2', '20.00', '2', '40.00'],
    ['réf', 'Product 3', '15.00', '3', '45.00'],
  ];

  final _tableHeadersFacture = ['Réference', 'Article','Quantité','PU(DH)','Taxe(%)','HT(DH)','TTC(DH)'];
  List<List<String>> _tableDataFacture = [
    ['réf', 'Product 1', '10.00', '1', '10.00','',''],
    ['réf', 'Product 2', '20.00', '2', '40.00','',''],
    ['réf', 'Product 3', '15.00', '3', '45.00','',''],
  ];




  // late List<List<String>> _tableData;
  String _downloadUrl="";
  String id_commande="";
  late String link;
  var _pdf;
  Future<void> _generateInvoice(String whichDoc) async {
    setState(() {
      _pdf = pw.Document();
    });


    _tableDataBL=[];
    for (var item in listOfListsDesArticles.reversed){
      List<String> _list=[item[8],item[0],item[1],item[3],item[2]];
      _tableDataBL.add(_list);
    }


    _tableDataFacture=[];
    for (var item in listOfListsDesArticles.reversed){
      List<String> _list=[item[8],item[0],item[2],item[3],item[4],item[5],item[6]];
      _tableDataFacture.add(_list);
    }


    final netImage = await networkImage(link);
    // final ByteData image = await rootBundle.load('ImageTest/appLogo.png');
    //
    // Uint8List imageData = (image).buffer.asUint8List();
    _pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              // Add the logo to the PDF
              // pw.Container(
              //   height: 100,
              //   width: 100,
              //   // child:pw.Image(pw.MemoryImage(image)),
              //   child:pw.Container(
              //       width: 50.0,
              //       height: 50.0,
              //       // child: pw.Image(pw.MemoryImage(imageData))
              //       child: pw.Image(netImage)
              //   ),
              //   // child:pw.Image(image as pw.ImageProvider),
              // ),

              pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Container(
                      height: 100,
                      width: 100,
                      // child:pw.Image(pw.MemoryImage(image)),
                      child:pw.Container(
                          width: 50.0,
                          height: 50.0,
                          // child: pw.Image(pw.MemoryImage(imageData))
                          child: pw.Image(netImage)
                      ),
                      // child:pw.Image(image as pw.ImageProvider),
                    ),
                    pw.Text(Slogan,style: pw.TextStyle(fontSize: 12),),
                  ]
              ),

              pw.Divider(
                thickness: 1.15,
                // indent: 10,
                // endIndent: 90,
                // color: Colors.black45,
              ),
              pw.Column(
                  mainAxisAlignment: pw.MainAxisAlignment.center,
                  children: [
                    // pw.Container(width: 50, child: pw.Text(EntrpNom)),
                    // pw.Container(width: 50, child: pw.Text(shippingAdrss)),
                    // pw.Container(width: 50, child: pw.Text(cPostal)),
                    pw.Text(EntrpNom,style: pw.TextStyle(fontSize: 10),),
                    pw.Text(shippingAdrss,style: pw.TextStyle(fontSize: 10),),
                    pw.Text(cPostal,style: pw.TextStyle(fontSize: 10),),
                  ]
              ),


              pw.Divider(
                thickness: 1.15,
                // indent: 10,
                // endIndent: 20,
                // color: Colors.black45,
              ),
              pw.SizedBox(height: 10),

              pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.end,
                  children: [

                    pw.Container(width: 170, child:pw.Column(
                        mainAxisAlignment: pw.MainAxisAlignment.center,
                        children: [
                          // pw.Container(width: 50, child: pw.Text(EntrpNom)),
                          // pw.Container(width: 50, child: pw.Text(shippingAdrss)),
                          // pw.Container(width: 50, child: pw.Text(cPostal)),
                          pw.Text(_desigFournTextController.text,style: pw.TextStyle(fontSize: 10),),
                          pw.Text(fAdress,style: pw.TextStyle(fontSize: 10),),
                          pw.Text(fCpostal,style: pw.TextStyle(fontSize: 10),),
                        ]
                    ),),
                  ]
              ),
              pw.SizedBox(height: 10),
              pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.start,
                  children: [

                    pw.Text("Date de validité:  ",style: pw.TextStyle(fontSize: 12),),
                    pw.Text(_DateDeCommandeTextController.text=="" ? DateFormat('yyyy-MM-dd   HH:mm').format(DateTime.now()).substring(0,10) : _DateDeCommandeTextController.text.substring(0,10),style: pw.TextStyle(fontSize: 10),),
                  ]
              ),
              pw.SizedBox(height: 20),

              pw.Text("$whichDoc N° $id_commande",style: pw.TextStyle(fontSize: 16),),
              // Add the table of products to the PDF
              pw.SizedBox(height: 10),
              pw.Table.fromTextArray(
                headers: whichDoc=="Bon de Livraison"  ? _tableHeadersBL : _tableHeadersFacture,
                data: whichDoc=="Bon de Livraison"  ? _tableDataBL : _tableDataFacture,
                cellStyle: pw.TextStyle(fontSize: 8),
                headerStyle: pw.TextStyle(fontSize: 8),
                cellAlignment: pw.Alignment.center,
                headerAlignment: pw.Alignment.center,
              ),
              pw.SizedBox(height: 10),
              whichDoc=="Bon de Livraison"  ? pw.Text("") : pw.Column(
                  mainAxisAlignment: pw.MainAxisAlignment.end,
                  children: [
                    pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.end,
                        children: [



                          // pw.Container(width: 50, child: pw.Text(EntrpNom)),
                          // pw.Container(width: 50, child: pw.Text(shippingAdrss)),
                          // pw.Container(width: 50, child: pw.Text(cPostal)),
                          pw.Text('Total HT (DH):   ',style: pw.TextStyle(fontSize: 12),),
                          pw.Text(_MHT.toStringAsFixed(2),style: pw.TextStyle(fontSize: 12),),
                        ]
                    ),

                    pw.Divider(
                      thickness: 1.15,
                      indent: 40,
                      endIndent: 10,
                      // color: Colors.black45,
                    ),

                    pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.end,
                        children: [



                          // pw.Container(width: 50, child: pw.Text(EntrpNom)),
                          // pw.Container(width: 50, child: pw.Text(shippingAdrss)),
                          // pw.Container(width: 50, child: pw.Text(cPostal)),
                          pw.Text('Total TTC (DH):   ',style: pw.TextStyle(fontSize: 12),),
                          pw.Text(_TOTAL.toStringAsFixed(2),style: pw.TextStyle(fontSize: 12),),
                        ]
                    ),


                  ]),

              // Add the signature to the PDF
              pw.SizedBox(height: 20),
              pw.Row(  mainAxisAlignment: pw.MainAxisAlignment.start, children:[pw.Container(width: 400,child:  pw.Text('Réglements & Exigences: ${_cdtTextController.text}',style: pw.TextStyle(fontSize: 12),),)],),
              pw.SizedBox(height: 15),
              pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.start,
                  children: [
                    pw.Column(
                        mainAxisAlignment: pw.MainAxisAlignment.start,
                        children: [
                          // pw.Container(width: 50, child: pw.Text(EntrpNom)),
                          // pw.Container(width: 50, child: pw.Text(shippingAdrss)),
                          // pw.Container(width: 50, child: pw.Text(cPostal)),
                          pw.Text(roleEmploye,style: pw.TextStyle(fontSize: 12),),
                          pw.Text(nomEmploye,style: pw.TextStyle(fontSize: 12),),
                        ]
                    ),
                  ]),
              pw.Row(mainAxisAlignment: pw.MainAxisAlignment.end,children: [pw.Container(
                height: 50,
                width: 200,
                child: pw.Text('Signature',style: pw.TextStyle(fontSize: 12),),
              ),] ),


              pw.Column(children: [ pw.Divider(
                thickness: 1.15,
                // indent: 10,
                // endIndent: 20,
                // color: Colors.black45,
              ),
                pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [

                      pw.Text("email: $email",style: pw.TextStyle(fontSize: 12),),
                      pw.Text("tel: $tel",style: pw.TextStyle(fontSize: 12),),
                      pw.Text("fax: $fax",style: pw.TextStyle(fontSize: 12),),
                    ]
                ),]),




            ],
          );
        },
      ),
    );
  }
  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url, forceSafariVC: false, forceWebView: false);
    } else {
      throw 'Impossible de lancer le lien $url';
    }
  }

  Future<void> _savePdfToFirebaseStorage(String whichDoc) async {
    final pdfBytes = await _pdf.save();
    final fileName = '$whichDoc-${DateTime.now().toString()}.pdf';
    final ref = _storage.ref().child('invoices/$fileName');
    final uploadTask = ref.putData(pdfBytes);

    // await Printing.layoutPdf(
    //     onLayout: (PdfPageFormat format) async => pdfBytes);

    final snapshot = await uploadTask.whenComplete(() => null);
    _downloadUrl = await snapshot.ref.getDownloadURL();
    // await _firestore.collection('invoices').add({
    //   'downloadUrl': _downloadUrl,
    //   'createdAt': Timestamp.now(),
    // });


  }


  Future<void> _createBLToFirestore() async { // STOCKER DANS FACTURE AVEC LE MEME ID DE LA COMMANDE
    setState(() {
      _isLoading = true;
    });
    await _firestore
        .collection(
        "BL")
        .add({
      // 'downloadUrl': _downloadUrl,
      'id_livreur': id_livreur,
      'dateAjout':  DateFormat('yyyy-MM-dd   HH:mm').format(DateTime.now()),
      'etrpID': id_entr,
      'IDaddBy': id_user,
      'datePrevue': _DateDeCommandeTextController.text=="" ? DateFormat('yyyy-MM-dd   HH:mm').format(DateTime.now()).substring(0,10) : _DateDeCommandeTextController.text.substring(0,10),
      // 'Commande': listOfListsDesArticles,
      // 'documentPDF': _downloadUrl,
      'id_entrC':  _referenceFourTextController.text,
      'exigences': _cdtTextController.text,
      'etat':'Non payé',
      'totalHT': _MHT.toStringAsFixed(2),
      'totalTTC': _TOTAL.toStringAsFixed(2),
    }).then((myNewDoc)
    async {
      id_commande=myNewDoc.id;
      await _generateInvoice("Bon de Livraison");
      await _savePdfToFirebaseStorage("Bon de Livraison");
      await firebaseFiretore
          .collection(
          "BL")
          .doc(myNewDoc.id)
          .update({
        "id_Commande":myNewDoc.id,
        'documentPDF': _downloadUrl,
      });
      await _generateInvoice("Facture");
      await _savePdfToFirebaseStorage("Facture");
      await firebaseFiretore
          .collection(
          "BL")
          .doc(myNewDoc.id)
          .update({
        'documentPDFFacture': _downloadUrl,
      });


      ListArticleInfoToAdd.add(_nomArticleTextController.text);
      ListArticleInfoToAdd.add(_DescripTextController.text);
      ListArticleInfoToAdd.add(_QuantitTextController.text);
      ListArticleInfoToAdd.add(_PrixUnitaireTextController.text);
      ListArticleInfoToAdd.add(_TaxesTextController.text);
      ListArticleInfoToAdd.add(_SMHT.toStringAsFixed(2));
      ListArticleInfoToAdd.add(_SousTTCTextController.text);
      ListArticleInfoToAdd.add(id_article);


      // await FirebaseFirestore.instance.collection('BC').doc(widget.docId)
      //     .collection('CommandeArticles').get().then((querySnapshot) {
      //   querySnapshot.docs.forEach((doc) {
      //     doc.reference.delete();
      //   });
      // });

      for (int i = 0; i < listOfListsDesArticles.length; i++) {

        setState(() {
          qttTableAchat= (int.tryParse(listOfListsDesArticles[i][2])! + qttTableAchat)!;

        });
        _firestore
            .collection('BL')
            .doc(myNewDoc.id)
            .collection('CommandeArticles')
            .add({
          'nomArticle': listOfListsDesArticles[i][0],
          'Descrip': listOfListsDesArticles[i][1],
          'Quantit': listOfListsDesArticles[i][2],
          'PrixUnitaire': listOfListsDesArticles[i][3],
          'Taxes': listOfListsDesArticles[i][4],
          'SMHT': listOfListsDesArticles[i][5],
          'SousTTC': listOfListsDesArticles[i][6],
          'id_article': listOfListsDesArticles[i][7],
          'referenceArticle': listOfListsDesArticles[i][8],
        });
      }



      await _firestore
          .collection(
          "ventes")
          .doc(myNewDoc.id)
          .set({
        'id_article': "Via Bon de Livraison",
        'qte':qttTableAchat.toString(),
        'dateAjout':  DateFormat('yyyy-MM-dd   HH:mm').format(DateTime.now()),
        'etrpID': id_entr,
        'IDaddBy': id_user,
        'id_entrC':  _referenceFourTextController.text,
        'etat':'Non payé',
        'totalTTC': _TOTAL.toStringAsFixed(2),
        'PU': _MHT.toStringAsFixed(2),
        'taxes': '-',
        'réfArticle': myNewDoc.id,
        'id_vente': myNewDoc.id,


      });


      await _firestore
          .collection(
          "livraison")
          .doc(myNewDoc.id)
          .set({
        'id_livraison': myNewDoc.id,
        'id_livreur': id_livreur,
        'qte':qttTableAchat.toString(),
        'dateAjout':  DateFormat('yyyy-MM-dd   HH:mm').format(DateTime.now()),
        'etrpID': id_entr,
        'IDaddBy': id_user,
        'id_entrC':  _referenceFourTextController.text,
        'etat':'En attente',
        'totalTTC': _TOTAL.toStringAsFixed(2),
        'id_Facture': myNewDoc.id,
        'id_BL': myNewDoc.id,
        'fax': faxC,
        'CAdress': fAdress,
      });




    });

    setState(() {
      _isLoading = false;
    });


    _cdtTextController.text="";
    // _SousTTCTextController.text="";
    // _TaxesTextController.text="";
    // _PrixUnitaireTextController.text="";
    // _QuantitTextController.text="";
    // _DescripTextController.text="";
    // _nomArticleTextController.text="";
    _DateDeCommandeTextController.text="";
    _ListeDePrixTextController.text="";
    _referenceFourTextController.text="";
    _desigFournTextController.text="";
    _desigLivreurTextController.text="";

    setState(() {
        listOfListsDesArticles.clear();
        ListArticleInfoToAdd.clear();
      _MHT=0.00;
      _TOTAL=0.00;
    });


  }
  Future<void> _print() async {
    setState(() {
      _isLoadingPrint = true;
    });
    await _generateInvoice("Bon de Livraison");
    final pdfBytes = await _pdf.save();
    await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async => pdfBytes);
    id_commande="";
    setState(() {
      _isLoadingPrint = false;
    });
  }
/*generate dmnd PDF*/


  late ClientModel dataEtrp;
  List<ClientModel> Etrp = [];
  late String id_entrF;

  late articlesModel dataArticle;
  List<articlesModel> Articles = [];
  late String id_article;
  late String referenceArticle;


  late villeModel dataville;
  List<villeModel> ville = [];

  // final DataTableSource MyDataTable = MyData();

  late String id_roleEmploye;
  late String roleEmploye;

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
          id_roleEmploye= snapshot.data()!["id_roleEmpls"];
          await FirebaseFirestore.instance
              .collection('roleEmpls')
              .doc(id_roleEmploye)
              .get()
              .then((snapshot) async {
            if (snapshot.exists) {
              setState(() {
                roleEmploye = snapshot.data()!["désignation"];


              });
            }
          });
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
                _MyCompanyNameTextController.text=EntrpNom;
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
                        Header('Documents', 'Bon de Livraison'),
                        SizedBox(
                          height: 60,
                        ),
                        Responsive.isDesktop(context)?
                        PrimaryText(
                          text: 'AJOUTER UN BON DE LIVRAISON ',
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

                            ])
                        //Web
                            : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                SizedBox(
                                  width:150,
                                  child:  Stack(
                                    children: [
                                      firebaseUIButton(
                                          context, "ENVOYER ", () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => InvoiceGenerator(),
                                          ),
                                        );
                                        // _desigFournTextController.text="";
                                      }, AppColors.btn, AppColors.them),
                                      Positioned(
                                        bottom: 30,
                                        right: 10,
                                        child: Icon(
                                            Icons.alternate_email,
                                            color: AppColors.them),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width:20,
                                ),
                                SizedBox(
                                  width:150,
                                  child:  Stack(
                                    children: [_isLoadingPrint ? Center(
                                      child: Loading(),
                                    ):
                                      firebaseUIButton(
                                          context, "IMPRIMER ", ()async {
                                        // await _generateInvoice();
                                        await _print();

                                        // _desigFournTextController.text="";
                                      }, AppColors.btn, AppColors.them),
                                      Positioned(
                                        bottom: 30,
                                        right: 10,
                                        child: Icon(
                                            Icons.print,
                                            color: AppColors.them),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width:110,
                                ),
                              ],
                            ),
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                SizedBox(
                                  width:1000,
                                  child: Divider(
                                    thickness: 1.15,
                                    indent: 30,
                                    endIndent: 90,
                                    color: Colors.black45,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                            Row(
                              children: const [
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: const PrimaryText(
                                    text: 'Informations génerales: ',
                                    size: 18,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black,
                                  ),
                                ),
                                // Divider(
                                //     thickness: 1.15,
                                //     indent: 30,
                                //     endIndent: 90,
                                //     color: Colors.black45,
                                //   ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 0),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.center,
                                children: [
                                  Column(
                                    children: [
                                      const PrimaryText(
                                        text: 'Client: ',
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
                                                  "Choisissez Un Client",
                                                  Icons.business,
                                                  false,
                                                  _desigFournTextController,
                                                  false),
                                            ),
                                            Positioned(
                                              bottom: 5,
                                              right: 4,
                                              child: StreamBuilder(
                                                  stream: FirebaseFirestore.instance.collection("Clients").snapshots(),
                                                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                                    if (snapshot.hasError) {
                                                      return const Text('Something went wrong');
                                                    }
                                                    if (snapshot.hasData){

                                                      List<ClientModel> newList = [];
                                                      var docs=snapshot.data?.docs;
                                                      docs?.forEach(
                                                              (element){
                                                            var routeArgs = element.data() as Map;

                                                            dataEtrp = ClientModel(

                                                              cPostal: element["cPostal"],
                                                              dateAjout: element["dateAjout"],

                                                              id_ajoutPar: element["id_ajoutPar"],

                                                              id_EtrpAddBy: element["id_EtrpAddBy"],


                                                              ImagePath: element["ImagePath"],

                                                              id_Client: element["id_Client"],
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
                                                          ClientModel>(
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
                                                            _referenceFourTextController.text=id_entrF;
                                                            fCpostal=choice.CPOSTAL;
                                                            fAdress=choice.ADRESSE;
                                                            faxC=choice.FAX;


                                                          });
                                                          _desigFournTextController.text =
                                                              choice.DESIGNATION;
                                                        },
                                                        itemBuilder:
                                                            (BuildContext context) {
                                                          return Etrp.map(
                                                                  (ClientModel choice) {
                                                                return PopupMenuItem<
                                                                    ClientModel>(
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
                                        text: 'Réference du Client: ',
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
                                                  "Réference",
                                                  Icons.data_array,
                                                  false,
                                                  _referenceFourTextController,
                                                  false),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  // Column(
                                  //   children: [
                                  //     const PrimaryText(
                                  //       text: 'Liste de Prix: ',
                                  //       size: 14,
                                  //       fontWeight: FontWeight.w800,
                                  //       color: AppColors.them,
                                  //     ),
                                  //     Padding(
                                  //       padding: const EdgeInsets.only(bottom: 8, right:8),
                                  //       child: Stack(
                                  //         children: [
                                  //           Container(
                                  //             width: MediaQuery.of(context)
                                  //                 .size
                                  //                 .width/4,
                                  //             child: reusableTextFieldAdd(
                                  //                 "Choisissez Une Liste",
                                  //                 Icons.list,
                                  //                 false,
                                  //                 _ListeDePrixTextController,
                                  //                 false),
                                  //           ),
                                  //           Positioned(
                                  //             bottom: 5,
                                  //             right: 4,
                                  //             child: StreamBuilder(
                                  //                 stream: FirebaseFirestore.instance.collection("Clients").snapshots(),
                                  //                 builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                  //                   if (snapshot.hasError) {
                                  //                     return const Text('Something went wrong');
                                  //                   }
                                  //                   if (snapshot.hasData){
                                  //
                                  //                     List<ClientModel> newList = [];
                                  //                     var docs=snapshot.data?.docs;
                                  //                     docs?.forEach(
                                  //                             (element){
                                  //                           var routeArgs = element.data() as Map;
                                  //
                                  //                           dataEtrp = ClientModel(
                                  //
                                  //                             cPostal: element["cPostal"],
                                  //                             dateAjout: element["dateAjout"],
                                  //
                                  //                             id_ajoutPar: element["id_ajoutPar"],
                                  //
                                  //                             id_EtrpAddBy: element["id_EtrpAddBy"],
                                  //
                                  //
                                  //                             ImagePath: element["ImagePath"],
                                  //
                                  //                             id_Client: element["id_Client"],
                                  //                             designation: element["désignation"],
                                  //
                                  //                             fax: element["fax"],
                                  //                             email: element["email"],
                                  //                             id_ville: element["id_ville"],
                                  //
                                  //                             tel: element["tel"],
                                  //
                                  //                             adresse: element["adresse"],
                                  //                           );
                                  //
                                  //
                                  //                           if(dataEtrp.id_EtrpAddBy==id_entr){
                                  //                             newList.add(dataEtrp);
                                  //                             // print("datacategory ${id_entr},,, ${datacategory.id_Etrp}");
                                  //
                                  //                           }
                                  //
                                  //
                                  //
                                  //
                                  //                           // newList.add(dataEtrp);
                                  //                           // print("datacategory ${id_entr},,, ${datacategory.id_Etrp}");
                                  //
                                  //
                                  //                         });
                                  //                     Etrp = newList;
                                  //                     Etrp.sort((a, b) {
                                  //                       return a.DESIGNATION.toLowerCase().compareTo(b.DESIGNATION.toLowerCase());
                                  //
                                  //                     });
                                  //
                                  //
                                  //                     // return Loading();
                                  //                     return PopupMenuButton<
                                  //                         ClientModel>(
                                  //                       offset: Offset(20, 0),
                                  //                       elevation: 8.0,
                                  //                       shape: const TooltipShape(),
                                  //                       color:
                                  //                       hexSrtingToColor("AFD6D0"),
                                  //                       icon: const Icon(
                                  //                           Icons.arrow_right_outlined,
                                  //                           color: Colors.white),
                                  //                       onSelected: (choice) {
                                  //                         print(choice);
                                  //                         setState(() {
                                  //                           id_entrF = choice.ID;
                                  //
                                  //                         });
                                  //                         _desigFournTextController.text =
                                  //                             choice.DESIGNATION;
                                  //                       },
                                  //                       itemBuilder:
                                  //                           (BuildContext context) {
                                  //                         return Etrp.map(
                                  //                                 (ClientModel choice) {
                                  //                               return PopupMenuItem<
                                  //                                   ClientModel>(
                                  //                                 value: choice,
                                  //                                 child: Row(children: [
                                  //                                   const Padding(
                                  //                                     padding:
                                  //                                     EdgeInsets.only(
                                  //                                         left: 8.0,
                                  //                                         right: 10.0),
                                  //
                                  //                                     child: Icon(
                                  //                                       Icons
                                  //                                           .circle_rounded,
                                  //                                       color: Colors.white,
                                  //                                       size: 10,
                                  //                                     ),
                                  //                                   ),
                                  //                                   Text(
                                  //                                     choice.DESIGNATION,
                                  //                                     style: TextStyle(
                                  //                                       color: Colors.white,
                                  //
                                  //                                       fontSize: 14,
                                  //                                     ),
                                  //                                   ),
                                  //                                 ]),
                                  //                               );
                                  //                             }).toList();
                                  //                       },
                                  //                     );
                                  //
                                  //                   }
                                  //                   return Loading();
                                  //
                                  //                 }
                                  //             ),
                                  //           ),
                                  //         ],
                                  //       ),
                                  //
                                  //     ),
                                  //   ],
                                  // ),
                                  Column(
                                    children: [
                                      const PrimaryText(
                                        text: 'Liste de Prix: ',
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
                                                  "Choisissez Une Liste",
                                                  Icons.list,
                                                  false,
                                                  _ListeDePrixTextController,
                                                  false),
                                            ),
                                            Positioned(
                                              bottom: 5,
                                              right: 4,
                                              child: Text(""),
                                            ),
                                          ],
                                        ),

                                      ),
                                    ],
                                  ),
                                ],
                              ),

                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 0),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.center,
                                children: [

                                  Column(
                                    children: [
                                      const PrimaryText(
                                        text: 'Mon entreprise: ',
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
                                                  "Entreprise",
                                                  Icons.person_outline,
                                                  false,
                                                  _MyCompanyNameTextController,
                                                  false),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      const PrimaryText(
                                        text: 'Livreur: ',
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
                                                  "Choisissez un livreur",
                                                  Icons.business,
                                                  false,
                                                  _desigLivreurTextController,
                                                  false),
                                            ),
                                            Positioned(
                                              bottom: 5,
                                              right: 4,
                                              child: StreamBuilder(
                                                  stream: FirebaseFirestore.instance.collection("employee").snapshots(),
                                                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                                    if (snapshot.hasError) {
                                                      return const Text('Something went wrong');
                                                    }
                                                    if (snapshot.hasData){

                                                      List<LivreurModel> newList = [];
                                                      var docs=snapshot.data?.docs;
                                                      docs?.forEach(
                                                              (element){
                                                            var routeArgs = element.data() as Map;

                                                            dataLivreur = LivreurModel(

                                                              dateAjout: element["dateAjout"],
                                                              id_ajoutPar: element["Ajouté par "],
                                                              id_EtrpAddBy: element["id_Etrp"],

                                                              ImagePath: element["ImagePath"],
                                                              designation: element["nom"],


                                                              email: element["email"],
                                                              tel: element["tel"],
                                                              adresse: element["adresse"],

                                                              id_employee: element["id_employe"],
                                                              idRole: element["id_roleEmpls"],
                                                              dispo: element["availability"],
                                                              state: element["state"],

                                                            );


                                                            if(dataLivreur.id_EtrpAddBy==id_entr && dataLivreur.idRole=="02S3mJ118bXc5m3TY4ox" && dataLivreur.dispo=="Disponible" && dataLivreur.state=="activated"){

                                                              newList.add(dataLivreur);
                                                              // print("datacategory ${id_entr},,, ${datacategory.id_Etrp}");

                                                            }

                                                          });
                                                      Livreur = newList;
                                                      Livreur.sort((a, b) {
                                                        return a.DESIGNATION.toLowerCase().compareTo(b.DESIGNATION.toLowerCase());

                                                      });


                                                      // return Loading();
                                                      return PopupMenuButton<
                                                          LivreurModel>(
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
                                                            id_livreur = choice.ID_EMPLOYEE;

                                                          });
                                                          _desigLivreurTextController.text =
                                                              choice.DESIGNATION;
                                                        },
                                                        itemBuilder:
                                                            (BuildContext context) {
                                                          return Livreur.map(
                                                                  (LivreurModel choice) {
                                                                return PopupMenuItem<
                                                                    LivreurModel>(
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
                                        text: 'Date Prévue: ',
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
                                              child:


                                              reusableTextFieldDate(
                                                  DateFormat('yyyy-MM-dd   HH:mm')
                                                      .format(DateTime.now()),
                                                  Icons.calendar_today,
                                                  false,
                                                  _DateDeCommandeTextController, () async {
                                                // dateinput.text=DateFormat('yyyy-MM-dd   HH:mm:ss').format(DateTime.now());
                                                DateTime? pickedDate =
                                                await showDatePicker(
                                                    context: context,
                                                    initialDate:
                                                    DateTime.now(),
                                                    firstDate: DateTime(2000),
                                                    //DateTime.now() - not to allow to choose before today.
                                                    lastDate: DateTime(2101));

                                                TimeOfDay? pickedTime =
                                                await showTimePicker(
                                                  initialTime: TimeOfDay.now(),
                                                  context:
                                                  context, //context of current state
                                                );

                                                if (pickedDate != null &&
                                                    pickedTime != null) {
                                                  print(
                                                      pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                                                  String formattedDate =
                                                  DateFormat('yyyy-MM-dd')
                                                      .format(pickedDate);
                                                  print(
                                                      formattedDate); //formatted date output using intl package =>  2021-03-16
                                                  //you can implement different kind of Date Format here according to your requirement

                                                  DateTime parsedTime =
                                                  DateFormat.jm().parse(
                                                      pickedTime
                                                          .format(context)
                                                          .toString());
                                                  //converting to DateTime so that we can further format on different pattern.
                                                  print(
                                                      parsedTime); //output 1970-01-01 22:53:00.000
                                                  String formattedTime =
                                                  DateFormat('HH:mm')
                                                      .format(parsedTime);

                                                  setState(() {
                                                    _DateDeCommandeTextController.text = "$formattedDate  $formattedTime"; //set output date to TextField value.
                                                  });
                                                } else {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(const SnackBar(
                                                    content: Text(
                                                        "Selectionner une date!"),
                                                    backgroundColor: Colors.red,
                                                    showCloseIcon: true,
                                                  ));
                                                  print("Date is not selected ");
                                                }
                                              }),


                                            ),
                                          ],
                                        ),
                                      ),

                                    ],
                                  ),


                                ],
                              ),

                            ),

                            const SizedBox(
                              height: 40,
                            ),


                            Row(
                              children: [
                                Expanded(
                                  child: TextFieldWidget(
                                    label: 'Conditions de réglement',
                                    controller: _cdtTextController,
                                    maxLines: 5,
                                    onChanged: (about) {},
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(
                              height: 40,
                            ),
                            //Choix des articles
                            Row(
                              children: const [
                                Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: PrimaryText(
                                    text: 'Articles: ',
                                    size: 18,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black,
                                  ),
                                ),
                                // Divider(
                                //     thickness: 1.15,
                                //     indent: 30,
                                //     endIndent: 90,
                                //     color: Colors.black45,
                                //   ),
                              ],
                            ),

                            Padding(
                              padding: const EdgeInsets.only(top: 0),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.center,
                                children: [

                                  Column(
                                    children: [
                                      const PrimaryText(
                                        text: 'Article: ',
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
                                                  .width/8,
                                              child: smallTextFieldAdd(
                                                  "Choisissez Un Article",

                                                  false,
                                                  _nomArticleTextController,
                                                  false),
                                            ),
                                            Positioned(
                                              bottom: 5,
                                              right: 4,
                                              child: StreamBuilder(
                                                  stream: FirebaseFirestore.instance.collection("articles").snapshots(),
                                                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                                    if (snapshot.hasError) {
                                                      return const Text('Something went wrong');
                                                    }
                                                    if (snapshot.hasData){

                                                      List<articlesModel> newList = [];
                                                      var docs=snapshot.data?.docs;
                                                      docs?.forEach(
                                                              (element){
                                                            var routeArgs = element.data() as Map;

                                                            dataArticle = articlesModel(

                                                              id: element["id_article"],

                                                              designation: element["désignation"],

                                                              qte: element["Qte"],


                                                              capital: element["capital"],

                                                              dateAjout: element["dateAjout"],
                                                              description: element["description"],

                                                              id_EtrpC: element["id_EtrpC"],
                                                              id_EtrpF: element["id_EtrpF"],
                                                              id_cat: element["id_cat"],

                                                              id_employe: element["id_ajoutPar"],

                                                              reference: element["reference"],
                                                              prixAchat: element["prixAchat"],
                                                              prixVente: element["prixVente"],
                                                              imagePath: element["ImagePath"],
                                                              state: element["state"],
                                                            );


                                                            if(dataArticle.id_EtrpC==id_entr && dataArticle.state=="activated"){
                                                              newList.add(dataArticle);
                                                              // print("datacategory ${id_entr},,, ${datacategory.id_Etrp}");

                                                            }




                                                            // newList.add(dataEtrp);
                                                            // print("datacategory ${id_entr},,, ${datacategory.id_Etrp}");


                                                          });
                                                      Articles = newList;
                                                      Articles.sort((a, b) {
                                                        return a.DESIGNATION.toLowerCase().compareTo(b.DESIGNATION.toLowerCase());

                                                      });


                                                      // return Loading();
                                                      return PopupMenuButton<
                                                          articlesModel>(
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
                                                            id_article = choice.ID;
                                                            referenceArticle = choice.REFERENCE;
                                                            descriptionArt = choice.DESCRIPTION;
                                                            prixUnArticle = choice.PRIXACHAT;

                                                            _DescripTextController.text=descriptionArt;
                                                            _PrixUnitaireTextController.text=prixUnArticle;



                                                          });
                                                          _nomArticleTextController.text =
                                                              choice.DESIGNATION;
                                                          _updateProduct();
                                                        },
                                                        itemBuilder:
                                                            (BuildContext context) {
                                                          return Articles.map(
                                                                  (articlesModel choice) {
                                                                return PopupMenuItem<
                                                                    articlesModel>(
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
                                                                        size: 8,
                                                                      ),
                                                                    ),
                                                                    Expanded(
                                                                      child: Text(
                                                                        choice.DESIGNATION,
                                                                        style: TextStyle(
                                                                          color: Colors.white,

                                                                          fontSize: 12,
                                                                        ),
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
                                        text: 'Déscription: ',
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
                                                  8,
                                              child: smallTextFieldAdd(
                                                  "Déscription",

                                                  false,
                                                  _DescripTextController,
                                                  false),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      const PrimaryText(
                                        text: 'Quantité:',
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
                                                  .width/8,
                                              child:
                                              // smallTextFieldAdd(
                                              //     "Quantité",
                                              //     false,
                                              //     _QuantitTextController,
                                              //     true),
                                              TextField(
                                                enabled: true,
                                                controller: _QuantitTextController,
                                                obscureText: false,
                                                enableSuggestions: !false,
                                                autocorrect: !false,
                                                cursorColor: AppColors.them,
                                                style: const TextStyle(color: AppColors.them, fontSize: 14),
                                                decoration: InputDecoration(
                                                  // prefixIcon: const Icon(
                                                  //   Icons.person_outline,
                                                  //   color: Colors.white,
                                                  // ),
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
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      const PrimaryText(
                                        text: 'Prix Unitaire (DH): ',
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
                                                  8,
                                              child:
                                              // smallTextFieldAdd(
                                              //     "Prix Unitaire",
                                              //
                                              //     false,
                                              //     _PrixUnitaireTextController,
                                              //     false),
                                              TextField(

                                                enabled: false,
                                                controller: _PrixUnitaireTextController,
                                                obscureText: false,
                                                enableSuggestions: !false,
                                                autocorrect: !false,
                                                cursorColor: AppColors.them,
                                                style: const TextStyle(color: AppColors.them, fontSize: 14),
                                                decoration: InputDecoration(
                                                  // prefixIcon: const Icon(
                                                  //   Icons.person_outline,
                                                  //   color: Colors.white,
                                                  // ),
                                                  labelText: "Prix Unitaire",
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
                                    ],
                                  ),

                                  Column(
                                    children: [
                                      const PrimaryText(
                                        text: 'Taxes (%) ',
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
                                                  .width/8,
                                              child:
                                              smallTextFieldAdd(
                                                  "Choisissez Une Valeur",

                                                  false,
                                                  _TaxesTextController,
                                                  false),
                                              // TextField(
                                              //   enabled: false,
                                              //   controller: _TaxesTextController,
                                              //   obscureText: false,
                                              //   enableSuggestions: !false,
                                              //   autocorrect: !false,
                                              //   cursorColor: AppColors.them,
                                              //   style: const TextStyle(color: AppColors.them, fontSize: 14),
                                              //   decoration: InputDecoration(
                                              //     // prefixIcon: const Icon(
                                              //     //   Icons.person_outline,
                                              //     //   color: Colors.white,
                                              //     // ),
                                              //     labelText: "Choisissez Une Valeur",
                                              //     labelStyle: TextStyle(color: Colors.white.withOpacity(0.9)),
                                              //     filled: true,
                                              //     floatingLabelBehavior: FloatingLabelBehavior.never,
                                              //     fillColor: AppColors.them.withOpacity(0.3),
                                              //     border: OutlineInputBorder(
                                              //         borderRadius: BorderRadius.circular(30.0),
                                              //         borderSide: const BorderSide(width: 0, style: BorderStyle.none)),
                                              //   ),
                                              //   keyboardType: false
                                              //       ? TextInputType.visiblePassword
                                              //       : TextInputType.emailAddress,
                                              //
                                              //   onChanged: (value) {
                                              //     _updateProduct();
                                              //   },
                                              //
                                              //
                                              // ),
                                            ),
                                            Positioned(
                                              bottom: 5,
                                              right: 4,
                                              child: PopupMenuButton<
                                                  Object>(
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
                                                    // id_entrF = choice.ID;
                                                    // _updateProduct();
                                                  });
                                                  _TaxesTextController.text =
                                                      choice.toString();
                                                  _updateProduct();
                                                },
                                                itemBuilder:
                                                    (BuildContext context) {
                                                  return taxes.map(
                                                          (Object choice) {
                                                        return PopupMenuItem<
                                                            Object>(
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
                                                              choice.toString(),
                                                              style: TextStyle(
                                                                color: Colors.white,

                                                                fontSize: 14,
                                                              ),
                                                            ),
                                                          ]),
                                                        );
                                                      }).toList();
                                                },
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
                                        text: 'TTC (DH): ',
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
                                                  8,
                                              child: smallTextFieldAdd(
                                                  "TTC",
                                                  false,
                                                  _SousTTCTextController,
                                                  false),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  // IconButton(
                                  //     padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                  //     iconSize: 20,
                                  //     icon: Icon(Icons.add, color: AppColors.them),
                                  //     onPressed: () {
                                  //       setState(() {
                                  //
                                  //       });
                                  //
                                  //     }),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: MouseRegion(
                                      cursor: SystemMouseCursors.click,
                                      child: GestureDetector(
                                        child: SvgPicture.asset(
                                          'assets/add.svg',
                                          color: AppColors.them,
                                          width: 40,
                                          height: 40,
                                        ),
                                        onTap: () async {
                                          print("*************");


                                          //Ajouter à la table Temporaire:
                                          // ListArticleInfoToAdd.add(_nomArticleTextController.text);
                                          // ListArticleInfoToAdd.add(_DescripTextController.text);
                                          // ListArticleInfoToAdd.add(_QuantitTextController.text);
                                          // ListArticleInfoToAdd.add(_PrixUnitaireTextController.text);
                                          // ListArticleInfoToAdd.add(_TaxesTextController.text);
                                          // ListArticleInfoToAdd.add(_SousTTCTextController.text);
                                          // listOfListsDesArticles.add(ListArticleInfoToAdd);



                                          try {

                                            await decrementerStock(referenceArticle,_QuantitTextController.text,context);

                                            setState(() {
                                              ListArticleInfoToAdd.add(_nomArticleTextController.text);
                                              ListArticleInfoToAdd.add(_DescripTextController.text);
                                              ListArticleInfoToAdd.add(_QuantitTextController.text);
                                              ListArticleInfoToAdd.add(_PrixUnitaireTextController.text);
                                              ListArticleInfoToAdd.add(_TaxesTextController.text=="" ? "0" : _TaxesTextController.text);
                                              ListArticleInfoToAdd.add(_SMHT.toStringAsFixed(2));
                                              ListArticleInfoToAdd.add(_SousTTCTextController.text);
                                              ListArticleInfoToAdd.add(id_article);
                                              ListArticleInfoToAdd.add(referenceArticle);
                                              listOfListsDesArticles.add(ListArticleInfoToAdd);

                                              ListArticleInfoToAdd=[];

                                              _nomArticleTextController.text="";
                                              _DescripTextController.text="";
                                              _QuantitTextController.text="";
                                              _PrixUnitaireTextController.text="";
                                              _TaxesTextController.text="";
                                              _SousTTCTextController.text="";
//LOL issue au nv de la somme
                                              double valHT=0;
                                              double valTTC=0;
                                              for(var article in listOfListsDesArticles){
                                                double? ht=0;
                                                double? ttc=0;
                                                ht=double.tryParse(article[5]);
                                                valHT=(ht! +valHT)!;
                                                ttc=double.tryParse(article[6]);
                                                valTTC=(ttc! +valTTC)!;
                                              };
                                              _MHT=valHT;
                                              _TOTAL=valTTC;

                                            });

                                          // ...
                                          } catch (e) {
                                          // Gérer l'exception lancée depuis decrementerStock
                                          print("Exception : $e");
                                          }




                                        },
                                      ),
                                    ),
                                  ),
                                  // Padding(
                                  //   padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                  //   child: MouseRegion(
                                  //     cursor: SystemMouseCursors.click,
                                  //     child: GestureDetector(
                                  //       child: SvgPicture.asset(
                                  //         'assets/annuler.svg',
                                  //         color: Colors.red,
                                  //         width: 40,
                                  //         height: 40,
                                  //       ),
                                  //       onTap: (){
                                  //         print("*************");
                                  //       },
                                  //     ),
                                  //   ),
                                  // ),

                                ],
                              ),

                            ),

//Table temporaire
                            Padding(
                              padding: const EdgeInsets.only(top: 16, left: 50, right: 50),
                              child: Table(
                                border: TableBorder.all(color: Colors.black45),
                                children: [
                                  const TableRow(
                                    children: [
                                      TableCell(
                                        verticalAlignment: TableCellVerticalAlignment.middle,
                                        child: Center(
                                          child: PrimaryText(
                                            text: 'Action',
                                            size: 14,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                      TableCell(
                                        verticalAlignment: TableCellVerticalAlignment.middle,
                                        child: Center(
                                          child: PrimaryText(
                                            text: 'Reference Article',
                                            size: 14,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                      TableCell(
                                        verticalAlignment: TableCellVerticalAlignment.middle,
                                        child: Center(
                                          child: PrimaryText(
                                            text: 'Article',
                                            size: 14,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                      TableCell(
                                        verticalAlignment: TableCellVerticalAlignment.middle,
                                        child: Center(
                                          child: PrimaryText(
                                            text: 'Déscription',
                                            size: 14,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                      TableCell(
                                        verticalAlignment: TableCellVerticalAlignment.middle,
                                        child: Center(
                                          child: PrimaryText(
                                            text: 'Quantité',
                                            size: 14,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                      TableCell(
                                        verticalAlignment: TableCellVerticalAlignment.middle,
                                        child: Center(
                                          child: PrimaryText(
                                            text: 'Prix Unitaire (DH)',
                                            size: 14,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                      TableCell(
                                        verticalAlignment: TableCellVerticalAlignment.middle,
                                        child: Center(
                                          child: PrimaryText(
                                            text: 'Taxe (%)',
                                            size: 14,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                      TableCell(
                                        verticalAlignment: TableCellVerticalAlignment.middle,
                                        child: Center(
                                          child: PrimaryText(
                                            text: 'HT (DH)',
                                            size: 14,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                      TableCell(
                                        verticalAlignment: TableCellVerticalAlignment.middle,
                                        child: Center(
                                          child: PrimaryText(
                                            text: 'TTC (DH)',
                                            size: 14,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),

                                  for (var item in listOfListsDesArticles.reversed)
                                    TableRow(
                                      children: [
                                        TableCell(
                                          child: IconButton(
                                              padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                              iconSize: 20,
                                              icon: Icon(Icons.delete, color: Colors.red),
                                              onPressed: () {
                                                setState(() {
                                                  listOfListsDesArticles.remove(item);
                                                  double? ht=0;
                                                  double? ttc=0;
                                                  ht=double.tryParse(item[5]);
                                                  print("ht: $ht");
                                                  _MHT=(_MHT - ht!)!;
                                                  print("_MHT: $_MHT");
                                                  ttc=double.tryParse(item[6]);
                                                  print("ttc: $ttc");
                                                  _TOTAL=(_TOTAL - ttc!)!;
                                                  print("_TOTAL: $_TOTAL");

                                                });

                                                // FirebaseFirestore.instance.collection('articles').doc(doc.id).delete();
                                              }),
                                        ),

                                        TableCell(
                                          verticalAlignment: TableCellVerticalAlignment.middle,
                                          child: Center(
                                            child: PrimaryText(
                                              text: item[8],
                                              size: 12,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                        TableCell(
                                          verticalAlignment: TableCellVerticalAlignment.middle,
                                          child: Center(
                                            child: PrimaryText(
                                              text: item[0],
                                              size: 12,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                        TableCell(
                                          verticalAlignment: TableCellVerticalAlignment.middle,
                                          child: Center(
                                            child: PrimaryText(
                                              text: item[1],
                                              size: 12,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                        TableCell(
                                          verticalAlignment: TableCellVerticalAlignment.middle,
                                          child: Center(
                                            child: PrimaryText(
                                              text: item[2],
                                              size: 12,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                        TableCell(
                                          verticalAlignment: TableCellVerticalAlignment.middle,
                                          child: Center(
                                            child: PrimaryText(
                                              text:item[3],
                                              size: 12,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                        TableCell(
                                          verticalAlignment: TableCellVerticalAlignment.middle,
                                          child: Center(
                                            child: PrimaryText(
                                              text: item[4],
                                              size: 12,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                        TableCell(
                                          verticalAlignment: TableCellVerticalAlignment.middle,
                                          child: Center(
                                            child: PrimaryText(
                                              text: item[5],
                                              size: 12,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                        TableCell(
                                          verticalAlignment: TableCellVerticalAlignment.middle,
                                          child: Center(
                                            child: PrimaryText(
                                              text: item[6],
                                              size: 12,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),

                                      ],
                                    ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 60,
                            ),



                            Column(
                              children: [
                                Row(
                                  children:  [
                                    PrimaryText(
                                      text: 'Total HT (DH):   ',
                                      size: 16,
                                      fontWeight: FontWeight.w800,
                                      color: Colors.black,
                                    ),
                                    PrimaryText(
                                      text: _MHT.toStringAsFixed(2),
                                      size: 16,
                                      fontWeight: FontWeight.w800,
                                      color: Colors.black,
                                    ),
                                  ],
                                ),
                                Divider(
                                  thickness: 1.15,
                                  indent: 30,
                                  endIndent: 90,
                                  color: Colors.black45,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children:  [
                                    PrimaryText(
                                      text: 'Total TTC (DH):   ',
                                      size: 20,
                                      fontWeight: FontWeight.w800,
                                      color: AppColors.them,
                                    ),
                                    PrimaryText(
                                      text: _TOTAL.toStringAsFixed(2),
                                      size: 20,
                                      fontWeight: FontWeight.w800,
                                      color: AppColors.them,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 40,
                                ),


                              ],
                            ),
                            // Padding(
                            //   padding:  EdgeInsets.symmetric(horizontal: deviceWidth(context) * 0.5),
                            //   child: firebaseUIButton(
                            //       context, "ENREGISTRER", () {
                            //
                            //     // _desigFournTextController.text="";
                            //   }, AppColors.them, Colors.white),
                            // ),
                            _isLoading ? Center(
                              child: Loading(),
                            ): firebaseUIButton(
                                context, "ENREGISTRER", () async {
                              // await _generateInvoice();
                              // await _savePdfToFirebaseStorage();
                              await _createBLToFirestore();
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text("Création du BL / Facture / Vente avec succès"),backgroundColor:AppColors.them,showCloseIcon: true,)
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
                            text: 'LISTE DES BONS DE LIVRAISON DE  ${EntrpNom.toUpperCase()}', size: 18, fontWeight: FontWeight.w800, color: AppColors.them,),
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
                                  stream: FirebaseFirestore.instance.collection('BL').orderBy('dateAjout', descending: true).snapshots(),
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

                                                IconButton(
                                                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                                    iconSize: 20,
                                                    icon: Icon(Icons.edit, color: AppColors.them),
                                                    onPressed: () {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) => editBL(docId: routeArgs['id_Commande'],),
                                                        ),
                                                      );
                                                    }),
                                                IconButton(
                                                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                                    iconSize: 20,
                                                    icon: Icon(Icons.delete, color: Colors.red),
                                                    onPressed: () async {
                                                      await FirebaseFirestore.instance.collection('BL').doc(doc.id).delete();
                                                      Reference reference = FirebaseStorage.instance.refFromURL(routeArgs['documentPDF']);
                                                      await reference.delete();
                                                    }),
                                                // Icon(Icons.edit, color: AppColors.them),
                                                // Icon(Icons.delete, color: AppColors.them),

                                              ],


                                            ),),
                                            DataCell(Text(routeArgs['id_Commande'] ?? 'default value')),
                                            DataCell(StreamBuilder(
                                                stream: FirebaseFirestore.instance.collection('employee').doc(routeArgs['id_livreur']).snapshots(),
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
                                            DataCell(StreamBuilder(
                                                stream: FirebaseFirestore.instance.collection('Clients').doc(routeArgs['id_entrC']).snapshots(),
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

                                            DataCell(Text(routeArgs['datePrevue'] ?? 'default value')),
                                            // DataCell(Text((routeArgs['datePrevue'].length >= 10) ? routeArgs['datePrevue'].substring(0, 10) : routeArgs['datePrevue'])),

                                            DataCell(Text(routeArgs['exigences'] ?? 'default value')),
                                            DataCell(Text(routeArgs['totalHT'] ?? 'default value')),
                                            DataCell(Text(routeArgs['totalTTC'] ?? 'default value')),
                                            DataCell(Text(routeArgs['etat'] ?? 'default value')),

                                            DataCell(IconButton(
                                                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                                iconSize: 20,
                                                icon: Icon(Icons.document_scanner, color: AppColors.them),
                                                onPressed: () {
                                                  _launchURL(routeArgs['documentPDF']);
                                                }),),

                                            DataCell(IconButton(
                                                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                                iconSize: 20,
                                                icon: Icon(Icons.document_scanner, color: AppColors.them),
                                                onPressed: () {
                                                  _launchURL(routeArgs['documentPDFFacture']);
                                                }),),
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
                                          DataColumn(label: Center(child: Text("Id Commande"))),
                                          DataColumn(label: Center(child: Text("Livreur"))),
                                          DataColumn(label: Center(child: Text("Client"))),
                                          DataColumn(label: Center(child: Text("Date Prévue"))),

                                          DataColumn(label: Center(child: Text("Exigences"))),
                                          DataColumn(label: Center(child: Text("THT (DH)"))),
                                          DataColumn(label: Center(child: Text("TTC (DH)"))),
                                          DataColumn(label: Center(child: Text("Etat"))),

                                          DataColumn(label: Center(child: Text("BL"))),
                                          DataColumn(label: Center(child: Text("Facture"))),
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



  void _updateProduct() {
    double value1 = double.tryParse(_QuantitTextController.text) ?? 0.0;
    double value2 = double.tryParse(_PrixUnitaireTextController.text) ?? 0.0;
    double taux=double.tryParse(_TaxesTextController.text) ?? 0.0;
    double product = value1 * value2;
    _SMHT=product;
    double TVA=product*taux/100;
    double sTTC=product + TVA;
    _SousTTCTextController.text = sTTC.toStringAsFixed(2);

  }

}

