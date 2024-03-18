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



class InvoiceGenerator extends StatefulWidget {
  @override
  _InvoiceGeneratorState createState() => _InvoiceGeneratorState();
}

class _InvoiceGeneratorState extends State<InvoiceGenerator> {

  final _pdf = pw.Document();
  final _storage = FirebaseStorage.instance;
  final _firestore = FirebaseFirestore.instance;

  final _tableHeaders = ['Product', 'Price', 'Quantity', 'Total'];
  final _tableData = [
    ['Product 1', '10.00', '1', '10.00'],
    ['Product 2', '20.00', '2', '40.00'],
    ['Product 3', '15.00', '3', '45.00'],
  ];
  late String _downloadUrl;
  late String link;
  String defaultPath="https://cdn-icons-png.flaticon.com/512/1560/1560896.png";
  FirebaseFirestore firebaseFiretore = FirebaseFirestore.instance;
  // Future getDataFromDatabase() async {
  //   await FirebaseFirestore.instance
  //       .collection('employee')
  //       .doc(FirebaseAuth.instance.currentUser!.uid)
  //       .get()
  //       .then((snapshot) async {
  //     if (snapshot.exists) {
  //       setState(() async {
  //         link = snapshot.data()!["logo"];
  //         // final response = await http.get(Uri.parse(link));
  //         // final file = File('ImageTest/my_image.jpg');
  //         // await file.writeAsBytes(response.bodyBytes);
  //
  //         //
  //         // try {
  //         //
  //         //   final response = await http.get(Uri.parse(link));
  //         //   final file = File('C:/Users/ACER/Downloads/my_image.jpg');
  //         //   await file.writeAsBytes(response.bodyBytes);
  //         //
  //         //
  //         //
  //         // } catch (e) {
  //         //   // Handle the error when http.get fails
  //         //   print('Errorrrrrrrrrrrrrrr: $e');
  //         // }
  //
  //
  //         //
  //         // final response = await http.get(Uri.parse(link));
  //         //
  //         // // Get the image name
  //         // final imageName = path.basename(link);
  //         // // Get the document directory path
  //         // final appDir = await getApplicationDocumentsDirectory();
  //         //
  //         // // This is the saved image path
  //         // // You can use it to display the saved image later
  //         // final localPath = path.join(appDir.path, imageName);
  //         // print("localPath $localPath");
  //         // // Downloading
  //         // final imageFile = File(localPath);
  //         // await imageFile.writeAsBytes(response.bodyBytes);
  //
  //
  //
  //       });
  //     }
  //   });
  // }

  late String id_entr;

  // String? userEmail = FirebaseAuth.instance.currentUser!.email;
  // final smtpServer = gmail('s.chafii2135@uca.ac.ma', 'ensaschool147');
  //
  // final message = Message()
  //   ..from = Address('chafiisafaa9@gmail.com', 'Safaa')
  //   ..recipients.add("chafiisafaa9@gmail.com")
  //   ..subject = 'Test Email'
  //   ..text = 'This is a test email sent from Flutter.';



  // void _launchEmailApp() async {
  //   try {
  //     final sendReport = await send(message, smtpServer);
  //     print('Message sent: ' + sendReport.toString());
  //   } on MailerException catch (e) {
  //     print('Message not sent.');
  //     for (var p in e.problems) {
  //       print('Problem: ${p.code}: ${p.msg}');
  //     }
  //   }
  //
  // }




  Future<void> _launchEmailApp(String recipientEmail) async {
    final smtpServer = gmail('s.chafii2135@uca.ac.ma', 'ensaschool147');

    // Create a new message
    final message = Message()
      ..from = Address('s.chafii2135@uca.ac.ma')
      ..recipients.add(recipientEmail)
      ..subject = 'Test Email'
      ..html = '<h1>Hello, this is a test email!</h1>';

    try {
      // Send the email
      final sendReport = await send(message, smtpServer);

      print('Message sent: ' + sendReport.toString());
    } on MailerException catch (e) {
      print('Message not sent. \n' + e.toString());
    }
  }






  // String userEmail = user.email!;


  Future getDataFromDatabase() async {
    await FirebaseFirestore.instance
        .collection('employee')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((snapshot) async {
      if (snapshot.exists) {
        setState(() async {
          id_entr = snapshot.data()!["id_Etrp"];

          await FirebaseFirestore.instance
              .collection('infoEntrp')
              .doc(id_entr)
              .get()
              .then((snapshot) async {
            if (snapshot.exists) {
              setState(() {
                link = snapshot.data()!["logo"] ?? defaultPath;
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


  // void _launchEmailApp(String pdfUrl) async {
  //   final Uri emailUri = Uri(
  //     scheme: 'mailto',
  //     path: '',
  //     queryParameters: {
  //       'subject': 'PDF File',
  //       'body': 'Please find attached the PDF file',
  //       'attachment': pdfUrl,
  //     },
  //   );
  //
  //   if (await canLaunch(emailUri.toString())) {
  //     await launch(emailUri.toString());
  //   } else {
  //     throw 'Could not launch email app';
  //   }
  // }

  Future<void> _generateInvoice() async {

    final netImage = await networkImage(link);

    // final ByteData image = await rootBundle.load('ImageTest/appLogo.png');
    //
    // Uint8List imageData = (image).buffer.asUint8List();
    _pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            children: [
              // Add the logo to the PDF
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
              // Add the table of products to the PDF
              pw.Table.fromTextArray(
                headers: _tableHeaders,
                data: _tableData,
              ),
              // Add the signature to the PDF
              pw.SizedBox(height: 20),
              pw.Container(
                height: 50,
                width: 200,
                child: pw.Text('Signature'),
              ),
            ],
          );
        },
      ),
    );
  }

  Future<void> _savePdfToFirebaseStorage() async {
    final pdfBytes = await _pdf.save();
    final fileName = 'invoice-${DateTime.now().toString()}.pdf';
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

    // await Navigator.of(context).push(
    //   MaterialPageRoute(
    //     builder: (BuildContext context) {
    //       return Scaffold(
    //         appBar: AppBar(
    //           title: Text('Aperçu PDF'),
    //         ),
    //         body: PdfPreview(
    //           build: (PdfPreviewController controller) {
    //             return PdfPreviewPage(
    //               controller: controller,
    //               build: (BuildContext context) {
    //                 return PdfView(
    //                   controller: controller,
    //                   document: PdfDocument.openData(pdfBytes),
    //                 );
    //               },
    //             );
    //           },
    //         ),
    //       );
    //     },
    //   ),
    // );
  }

//   rules_version = '2';
//   service firebase.storage {
//   match /b/{bucket}/o {
//   match /{allPaths=**} {
//   allow read, write: if false;
//   }
// }
// }

  Future<void> _saveDownloadUrlToFirestore() async {
    await _firestore.collection('invoices').add({
      'downloadUrl': _downloadUrl,
      'createdAt': Timestamp.now(),
    });
  }


  Future<void> _print() async {
    final pdfBytes = await _pdf.save();
    await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async => pdfBytes);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Invoice Generator'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                await _generateInvoice();
                await _savePdfToFirebaseStorage();
                await _saveDownloadUrlToFirestore();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('PDF saved to Firebase Storage')),
                );
              },
              child: Text('Generate Invoice'),
            ),
            ElevatedButton(
              onPressed: () async {
                await _generateInvoice();
                await _print();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('PDF printed')),
                );
              },
              child: Text('pdf Invoice'),
            ),
            ElevatedButton(
              onPressed: () async {
                _launchEmailApp("chafiisafaa9@gmail.com");
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('PDF printed')),
                );
              },
              child: Text('email Invoice'),
            ),
          ],
        ),
      ),
    );
  }
}
