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
import 'package:adminsignin/functions/functions.dart';
import 'package:adminsignin/component/PDF.dart';
import 'package:adminsignin/component/header.dart';
import 'package:adminsignin/component/sideMenu.dart';
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

class editInvoice extends StatefulWidget {
  String docId;
  editInvoice({super.key, required this.docId});

  @override
  State<editInvoice> createState() => editInvoiceState();
}

class editInvoiceState extends State<editInvoice> {
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

  // List<dynamic> villes = [];
  // String? villeId;
  FirebaseFirestore firebaseFiretore = FirebaseFirestore.instance;
  double deviceHieght(BuildContext context) => MediaQuery.of(context).size.height;

  int qttTableAchat= 0;

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
  bool _isLoading2 = false;
  bool _isLoadingP = false;
  bool _isLoadingPrint = false;

  late String descriptionArt;
  late String prixUnArticle;
  late List<Object> taxes=[];

  late List<String> ListArticleInfoToAdd=[];
  late  List<List<String>> listOfListsDesArticles=[];

/*generate dmnd PDF*/
  // final _pdf = pw.Document();
  final _storage = FirebaseStorage.instance;
  final _firestore = FirebaseFirestore.instance;

  final _tableHeadersBC = ['Réference', 'Article','Date Prévue','Quantité','PU(DH)','Taxe(%)','HT(DH)','TTC(DH)'];
  List<List<String>> _tableDataBC = [
    ['réf', 'Product 1', '10.00', '1', '10.00','','',''],
    ['réf', 'Product 2', '20.00', '2', '40.00','','',''],
    ['réf', 'Product 3', '15.00', '3', '45.00','','',''],
  ];

  final _tableHeaders = ['Réference', 'Article', 'Déscription', 'Date prévue', 'Quantité'];
  List<List<String>> _tableData = [
    ['réf', 'Product 1', '10.00', '1', '10.00'],
    ['réf', 'Product 2', '20.00', '2', '40.00'],
    ['réf', 'Product 3', '15.00', '3', '45.00'],
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


    _tableData=[];
    for (var item in listOfListsDesArticles.reversed){
      List<String> _list=[item[8],item[0],item[1],_DateDeCommandeTextController.text.substring(0,10),item[2]];
      _tableData.add(_list);
    }


    _tableDataBC=[];
    for (var item in listOfListsDesArticles.reversed){
      List<String> _list=[item[8],item[0],_DateDeCommandeTextController.text.substring(0,10),item[2],item[3],item[4],item[5],item[6]];
      _tableDataBC.add(_list);
    }


    final netImage = await networkImage(link);
    final ByteData image = await rootBundle.load("images/paid.png");
    Uint8List imageData = (image).buffer.asUint8List();

    // pw.MemoryImage imagepaid = pw.MemoryImage(
    //   File("images/paid.png").readAsBytesSync(),
    // );

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

                stateBC=="Payée" ? pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.end,
                  children: [
                    pw.Container(
                      height: 100,
                      width: 100,
                      // child:pw.Image(pw.MemoryImage(image)),
                      child:pw.Container(
                          width: 100.0,
                          height: 100.0,
                          // child: pw.Image(pw.MemoryImage(imageData))
                          child:pw.Image(pw.MemoryImage(imageData)),
                      ),
                      // child:pw.Image(image as pw.ImageProvider),
                    ),
                    // pw.Text(Slogan,style: pw.TextStyle(fontSize: 12),),
                  ]
              ) : pw.Text(""),
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

              pw.SizedBox(height: 20),

              pw.Text("$whichDoc N° $id_commande",style: pw.TextStyle(fontSize: 16),),
              // Add the table of products to the PDF
              pw.SizedBox(height: 10),
              pw.Table.fromTextArray(
                headers: whichDoc=="Demande de Prix"  ? _tableHeaders: _tableHeadersBC,
                data: whichDoc=="Demande de Prix"  ? _tableData: _tableDataBC,
                cellStyle: pw.TextStyle(fontSize: 8),
                headerStyle: pw.TextStyle(fontSize: 8),
                cellAlignment: pw.Alignment.center,
                headerAlignment: pw.Alignment.center,
              ),
              pw.SizedBox(height: 10),
              pw.Column(
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
              // pw.SizedBox(height: 20),
              // pw.Row(  mainAxisAlignment: pw.MainAxisAlignment.start, children:[pw.Container(width: 400,child:  pw.Text('Réglements & Exigences: ${_cdtTextController.text}',style: pw.TextStyle(fontSize: 12),),)],),
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
  // _launchURL(String url) async {
  //   if (await canLaunch(url)) {
  //     await launch(url, forceSafariVC: false, forceWebView: false);
  //   } else {
  //     throw 'Impossible de lancer le lien $url';
  //   }
  // }
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

  // String state= 'Non validée';
  String stateBC= 'Non payée';

  Future<void> _saveDownloadUrlToFirestore() async {
    setState(() {
      _isLoading2 = true;
    });
    await _firestore
        .collection(
        "facture")
        .doc(widget.docId)
        .update({
      // 'downloadUrl': _downloadUrl,
      'dateAjout':  DateFormat('yyyy-MM-dd   HH:mm').format(DateTime.now()),
      'etrpID': id_entr,
      'IDaddBy': id_user,
      'datePrevue': _DateDeCommandeTextController.text,
      // 'Commande': listOfListsDesArticles,
      // 'documentPDF': _downloadUrl,
      'id_entrF':  _referenceFourTextController.text,
      'exigences': _cdtTextController.text,
      'etat':stateBC,
      'totalHT': _MHT.toStringAsFixed(2),
      'totalTTC': _TOTAL.toStringAsFixed(2),
    }).then((myNewDoc)
    async {
      id_commande=widget.docId;
      await _generateInvoice("Facture");
      await _savePdfToFirebaseStorage("Facture");
      firebaseFiretore
          .collection(
          "facture")
          .doc(widget.docId)
          .update({
        'documentPDF': _downloadUrl,
      });


      ListArticleInfoToAdd.add(_nomArticleTextController.text);
      ListArticleInfoToAdd.add(_DescripTextController.text);
      ListArticleInfoToAdd.add(_QuantitTextController.text);
      ListArticleInfoToAdd.add(_PrixUnitaireTextController.text);
      ListArticleInfoToAdd.add(_TaxesTextController.text);
      ListArticleInfoToAdd.add(_SMHT.toStringAsFixed(2));
      ListArticleInfoToAdd.add(_SousTTCTextController.text);
      ListArticleInfoToAdd.add(id_article);


      await FirebaseFirestore.instance.collection('facture').doc(widget.docId)
          .collection('CommandeArticles').get().then((querySnapshot) {
        querySnapshot.docs.forEach((doc) {
          doc.reference.delete();
        });
      });

      for (int i = 0; i < listOfListsDesArticles.length; i++) {
        setState(() {
          qttTableAchat= (int.tryParse(listOfListsDesArticles[i][2])! + qttTableAchat)!;

        });
        _firestore
            .collection('facture')
            .doc(widget.docId)
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
          // 'id_article': listOfListsDesArticles[i][7],
          'referenceArticle': listOfListsDesArticles[i][8],
        });
      }

      await _firestore
          .collection(
          "achats")
          .doc(widget.docId)
          .set({


        'id_article': "Via Bon de Commande",
        'qte':qttTableAchat.toString(),
        'dateAjout':  DateFormat('yyyy-MM-dd   HH:mm').format(DateTime.now()),
        'etrpID': id_entr,
        'IDaddBy': id_user,
        'id_entrF':  _referenceFourTextController.text,
        'etat':stateBC,
        'totalTTC': _TOTAL.toStringAsFixed(2),
        'PU': _MHT.toStringAsFixed(2),
        'taxes': _calculateTaxe(_TOTAL.toStringAsFixed(2),_MHT.toStringAsFixed(2)),
        'réfArticle': widget.docId,
        'id_achat': widget.docId,

      });

      // _desigFournTextController.text="";
      // _emailTextController.text="";
      // _villeTextController.text="";
      // _faxTextController.text="";
      // _telTextController.text="";
      // _adresseTextController.text="";

    });
    setState(() {
      _isLoading2 = false;
    });
  }
  Future<void> _addVersementFournisseurToFirestore() async { // STOCKER DANS FACTURE AVEC LE MEME ID DE LA COMMANDE

    setState(() {
      _isLoadingP = true;
      stateBC="Payée";
    });


    await _firestore
        .collection(
        "VersementFournisseur")
        .doc(widget.docId)
        .set({
      // 'downloadUrl': _downloadUrl,
      'dateAjout':  DateFormat('yyyy-MM-dd   HH:mm').format(DateTime.now()),
      'etrpID': id_entr,
      'IDaddBy': id_user,
      'id_entrF':  _referenceFourTextController.text,
      'totalTTC': _TOTAL.toStringAsFixed(2),
    }).then((myNewDoc)
    async {
      firebaseFiretore
          .collection(
          "VersementFournisseur")
          .doc(widget.docId)
          .update({
        "id_facture":widget.docId,

      });

//mettre à jour l'achat: issue au nv du changement d'etat de paiement (résolu)
      await _firestore
          .collection(
          "achats")
          .doc(widget.docId)
          .set({


        'id_article': "Via Bon de Commande",
        'qte':qttTableAchat.toString(),
        'dateAjout':  DateFormat('yyyy-MM-dd   HH:mm').format(DateTime.now()),
        'etrpID': id_entr,
        'IDaddBy': id_user,
        'id_entrF':  _referenceFourTextController.text,
        'etat':"Payée",
        'totalTTC': _TOTAL.toStringAsFixed(2),
        'PU': _MHT.toStringAsFixed(2),
        'taxes': _calculateTaxe(_TOTAL.toStringAsFixed(2),_MHT.toStringAsFixed(2)),
        'réfArticle': widget.docId,
        'id_achat': widget.docId,

      });

    });
    setState(() {
      _isLoadingP = false;
    });
  }
  Future<void> _print() async {
    setState(() {
      _isLoadingPrint = true;
    });
    await _generateInvoice("Facture");
    final pdfBytes = await _pdf.save();
    await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async => pdfBytes);
    id_commande="";
    setState(() {
      _isLoadingPrint = false;
    });
  }
/*generate dmnd PDF*/


  late FournisseurModel dataEtrp;
  List<FournisseurModel> Etrp = [];
  late String id_entrF="1";

  late articlesModel dataArticle;
  List<articlesModel> Articles = [];
  late String id_article="1";
  late String referenceArticle="1";


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
  Future getDmndPrixFromDatabase() async {
    await FirebaseFirestore.instance
        .collection(
        "BC")
        .doc(widget.docId)
        .get()
        .then((snapshot) async {
      if (snapshot.exists) {
        setState(() async {
          stateBC=snapshot.data()!["etat"];
          _cdtTextController.text=snapshot.data()!["exigences"];
          _MHT=double.tryParse(snapshot.data()!["totalHT"])!;
          _TOTAL=double.tryParse(snapshot.data()!["totalTTC"])!;

          _MyCompanyNameTextController.text=EntrpNom;
          _DateDeCommandeTextController.text=snapshot.data()!["datePrevue"];
          // _desigFournTextController.text= await getfieldNameFromDatabase(snapshot.data()!["id_Fourn"],"Fournisseurs","désignation");
          // _desigFournTextController.text= await getfieldNameFromDatabase(snapshot.data()!["id_Fourn"],"Fournisseurs","désignation");
          _referenceFourTextController.text=snapshot.data()!["id_entrF"];
          String IDF=snapshot.data()!["id_entrF"];
          await FirebaseFirestore.instance
              .collection("Fournisseurs")
              .doc(IDF)
              .get()
              .then((snapshot) async {
            if (snapshot.exists) {
              _desigFournTextController.text = await snapshot.data()!["désignation"];

            }

          });





          await FirebaseFirestore.instance.collection('BC').doc(widget.docId)
              .collection('CommandeArticles').get().then((querySnapshot) {
            querySnapshot.docs.forEach((doc) {
              List<String> listTemporaire=[];
              listTemporaire.addAll(
                  [
                    doc.data()["nomArticle"],
                    doc.data()["Descrip"],
                    doc.data()["Quantit"],
                    doc.data()["PrixUnitaire"],
                    doc.data()["Taxes"],
                    doc.data()["SMHT"],
                    doc.data()["SousTTC"],
                    doc.data()["id_article"],
                    doc.data()["referenceArticle"],]
              );
              setState(() {
                listOfListsDesArticles.add(listTemporaire);
              });

            });
          });


        });
      }
    });
  }
  @override
  void initState() {
    super.initState();
    getDataFromDatabase();
    getDmndPrixFromDatabase();
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
                        Header('Documents', 'Facture'),
                        SizedBox(
                          height: 60,
                        ),
                        Responsive.isDesktop(context)?
                        PrimaryText(
                          text: 'EDITER UNE FACTURE ',
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
                                    children: [_isLoadingPrint ? Center(
                                      child: Loading(),
                                    ):
                                      firebaseUIButton(
                                          context, "IMPRIMER ", () async {
                                        await _print();

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
                                  width:20,
                                ),
                                SizedBox(
                                  width:150,
                                  child:  Stack(
                                    children: [_isLoadingP ? Center(
                                      child: Loading(),
                                    ):
                                      firebaseUIButton(
                                          context, "PAYER ", ()async {
                                        // await _generateInvoice();
                                        // await _print();
                                        await _addVersementFournisseurToFirestore();


                                        ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(content: Text("Enregistrement du versement avec succès"),backgroundColor:AppColors.them,showCloseIcon: true,));                          // _desigFournTextController.text="";
                                      }, AppColors.btn, AppColors.them),
                                      Positioned(
                                        bottom: 30,
                                        right: 10,
                                        child: Icon(
                                            Icons.attach_money,
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
                                                  _desigFournTextController.text,
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
                                                            _referenceFourTextController.text=id_entrF;
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
                                        text: 'Réference du Fournisseur: ',
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
                                        text: '',
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
                                                child: Text("")
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
                                        onTap: (){
                                          print("*************");


                                          //Ajouter à la table Temporaire:
                                          // ListArticleInfoToAdd.add(_nomArticleTextController.text);
                                          // ListArticleInfoToAdd.add(_DescripTextController.text);
                                          // ListArticleInfoToAdd.add(_QuantitTextController.text);
                                          // ListArticleInfoToAdd.add(_PrixUnitaireTextController.text);
                                          // ListArticleInfoToAdd.add(_TaxesTextController.text);
                                          // ListArticleInfoToAdd.add(_SousTTCTextController.text);
                                          // listOfListsDesArticles.add(ListArticleInfoToAdd);

                                          setState(() {
                                            ListArticleInfoToAdd.add(_nomArticleTextController.text);
                                            ListArticleInfoToAdd.add(_DescripTextController.text);
                                            ListArticleInfoToAdd.add(_QuantitTextController.text);
                                            ListArticleInfoToAdd.add(_PrixUnitaireTextController.text);
                                            ListArticleInfoToAdd.add(_TaxesTextController.text);
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
//
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

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(20),
                                    child: firebaseUIButton(
                                        context, "ANNULER", () {

                                      Navigator.pop(context);

                                    }, Colors.grey, Colors.white),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(20),
                                    child: _isLoading2 ? Center(
                                      child: Loading(),
                                    ):firebaseUIButton(
                                        context, "ENREGISTRER", () async {
                                      await _saveDownloadUrlToFirestore();
                                      ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(content: Text("Document enregistré avec succès"),backgroundColor:AppColors.them,showCloseIcon: true,));
                                      Navigator.pop(context);

                                    }, AppColors.them, Colors.white),
                                  ),
                                ),

                                // firebaseUIButton(
                                //     context, "ENREGISTRER", () {
                                //   arr.add(_taxesTextController.text);
                                //   firebaseFiretore
                                //       .collection(
                                //       "infoEntrp")
                                //       .doc(widget.docId)
                                //       .update({
                                //     "Taxes":
                                //     arr
                                //   });
                                //
                                //   // _desigFournTextController.text="";
                                // }, AppColors.them, Colors.white),
                              ],
                            ),


                            // firebaseUIButton(
                            //     context, "ENREGISTRER", () async {
                            //   // await _generateInvoice();
                            //   // await _savePdfToFirebaseStorage();
                            //   await _saveDownloadUrlToFirestore();
                            //   ScaffoldMessenger.of(context).showSnackBar(
                            //       SnackBar(content: Text("Document enregistré avec succès"),backgroundColor:AppColors.them,showCloseIcon: true,)
                            //   );
                            //   // Navigator.push(
                            //   //   context,
                            //   //   MaterialPageRoute(
                            //   //     builder: (context) => InvoiceGenerator(),
                            //   //   ),
                            //   // );
                            //   // _desigFournTextController.text="";
                            // }, AppColors.them, Colors.white),

                          ],
                        ),
                        SizedBox(
                          height: 60,
                        ),




                        //Tableau d'affichage



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


  String _calculateTaxe(String ATTC, String AHT) {
    double ttc = double.tryParse(ATTC) ?? 0.0;
    double ht = double.tryParse(AHT) ?? 0.0;
    double Atva = ((ttc/ht)-1)*100;
    return Atva.toStringAsFixed(2);
  }

}

