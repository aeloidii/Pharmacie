import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:typed_data';
import 'package:path_provider/path_provider.dart';

FirebaseFirestore firebaseFiretore = FirebaseFirestore.instance;

Future<String> getfieldNameFromDatabase(String id_doc, String collName, String fieldName) async {
  return FirebaseFirestore.instance
      .collection(collName)
      .doc(id_doc)
      .get()
      .then((snapshot) async {
    if (snapshot.exists) {
      String x = await snapshot.data()![fieldName];
      return x;
    }
    return "**";
  })
      .catchError((error) {
    // Handle the error here
    print("Error fetching data: $error");
    return "***";
  });
}

// Future<String> incrementerStock(String ref, String qtt) async {
//   return FirebaseFirestore.instance
//       .collection("articles")
//       .doc(id_doc)
//       .get()
//       .then((snapshot) async {
//     if (snapshot.exists) {
//       String x = await snapshot.data()![fieldName];
//       return x;
//     }
//     return "hhh";
//   })
//       .catchError((error) {
//     // Handle the error here
//     print("Error fetching data: $error");
//     return "nnnn";
//   });
// }



Future incrementerStock(String ref, String qtt) async {
  return FirebaseFirestore.instance
      .collection("articles")
      .where("reference", isEqualTo: ref)  // Filtrer les documents avec la référence égale à ref
      .get()
      .then((snapshot) async {
    if (snapshot.docs.isNotEmpty) {
      // Vous pouvez accéder aux documents correspondants ici
      for (var doc in snapshot.docs) {
        // Faire ce que vous souhaitez avec chaque document correspondant
        String ancienQtt = doc.data()!["Qte"];
        String prixAchat = doc.data()!["prixAchat"];
        String id_article = doc.data()!["id_article"];

        double prixAchatD=double.tryParse(prixAchat) ?? 0.0;
        double ancienQttD=double.tryParse(ancienQtt) ?? 0.0;
        double qttD=double.tryParse(qtt) ?? 0.0;
        double nvqtt = ancienQttD + qttD;

        double capitale= nvqtt * prixAchatD;

        String qttUpdated= nvqtt.toInt().toString();
        String capitaleStr= capitale.toStringAsFixed(2);



        // ...

        await firebaseFiretore
            .collection(
            "articles")
            .doc(id_article)
            .update({
          'Qte': qttUpdated,
          'capital':capitaleStr ,

      });

    } }
    else {
     print("smth went wrong");
    }
  })
      .catchError((error) {
    // Gérer l'erreur ici
    print("Erreur lors de la récupération des données : $error");
    return "Erreur";
  });
}
Future decrementerStock(String ref, String qtt,BuildContext context) async {
  return FirebaseFirestore.instance
      .collection("articles")
      .where("reference", isEqualTo: ref)  // Filtrer les documents avec la référence égale à ref
      .get()
      .then((snapshot) async {
    if (snapshot.docs.isNotEmpty) {
      // Vous pouvez accéder aux documents correspondants ici
      for (var doc in snapshot.docs) {
        // Faire ce que vous souhaitez avec chaque document correspondant
        String ancienQtt = doc.data()!["Qte"];
        String prixAchat = doc.data()!["prixAchat"];
        String id_article = doc.data()!["id_article"];

        double prixAchatD=double.tryParse(prixAchat) ?? 0.0;
        double ancienQttD=double.tryParse(ancienQtt) ?? 0.0;
        double qttD=double.tryParse(qtt) ?? 0.0;
        if (ancienQttD >= qttD) {
          double nvqtt = ancienQttD - qttD;

          double capitale = nvqtt * prixAchatD;

          String qttUpdated = nvqtt.toInt().toString();
          String capitaleStr = capitale.toStringAsFixed(2);

          // ...

          await firebaseFiretore.collection("articles").doc(id_article).update({
            'Qte': qttUpdated,
            'capital': capitaleStr,
          });
        } else{
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Vous n'avez pas suffisament de stock pour effectuer cette vente (Stock: $ancienQttD) "),backgroundColor:Colors.red,showCloseIcon: true,)
          );
          throw Exception("Stock insuffisant"); // Lancer une exception pour arrêter l'exécution de GetData
        }
      } }
    else {
     print("smth went wrong");
    }
  })
      .catchError((error) {
    // Gérer l'erreur ici
    print("Erreur lors de la récupération des données : $error");
    return "Erreur";
  });
}

Future verifierStock(String ref, String qtt,BuildContext context) async {
  return FirebaseFirestore.instance
      .collection("articles")
      .where("reference", isEqualTo: ref)  // Filtrer les documents avec la référence égale à ref
      .get()
      .then((snapshot) async {
    if (snapshot.docs.isNotEmpty) {
      // Vous pouvez accéder aux documents correspondants ici
      for (var doc in snapshot.docs) {
        // Faire ce que vous souhaitez avec chaque document correspondant
        String ancienQtt = doc.data()!["Qte"];
        String prixAchat = doc.data()!["prixAchat"];
        String id_article = doc.data()!["id_article"];

        double prixAchatD=double.tryParse(prixAchat) ?? 0.0;
        double ancienQttD=double.tryParse(ancienQtt) ?? 0.0;
        double qttD=double.tryParse(qtt) ?? 0.0;
        if (ancienQttD >= qttD) {
          print("Stock suffisant");
        } else{
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Vous n'avez pas suffisament de stock pour effectuer cette vente (Stock: $ancienQttD) "),backgroundColor:Colors.red,showCloseIcon: true,)
          );
          throw Exception("Stock insuffisant"); // Lancer une exception pour arrêter l'exécution de GetData
        }
      } }
    else {
      print("smth went wrong");
    }
  })
      .catchError((error) {
    // Gérer l'erreur ici
    print("Erreur lors de la récupération des données : $error");
    return "Erreur";
  });
}

// Future<void> decrementerStock2(String ref, String qtt, BuildContext context) async {
//   try {
//     QuerySnapshot snapshot = await FirebaseFirestore.instance
//         .collection("articles")
//         .where("reference", isEqualTo: ref)
//         .get();
//
//     if (snapshot.docs.isNotEmpty) {
//       for (var doc in snapshot.docs) {
//         String ancienQtt = doc.data()?["Qte"];
//         double ancienQttD = double.tryParse(ancienQtt) ?? 0.0;
//         double qttD = double.tryParse(qtt) ?? 0.0;
//
//         if (ancienQttD > qttD) {
//           double nvqtt = ancienQttD - qttD;
//           String qttUpdated = nvqtt.toInt().toString();
//
//           await FirebaseFirestore.instance
//               .collection("articles")
//               .doc(doc.id)
//               .update({
//             'Qte': qttUpdated,
//           });
//
//           showDialog(
//             context: context,
//             builder: (BuildContext context) {
//               return AlertDialog(
//                 title: Text('Quantité déduite'),
//                 content: Text('La quantité a été déduite avec succès.'),
//                 actions: [
//                   TextButton(
//                     child: Text('OK'),
//                     onPressed: () {
//                       Navigator.of(context).pop();
//                     },
//                   ),
//                 ],
//               );
//             },
//           );
//         } else {
//           showDialog(
//             context: context,
//             builder: (BuildContext context) {
//               return AlertDialog(
//                 title: Text('Quantité insuffisante'),
//                 content: Text('La quantité disponible est insuffisante pour la déduction.'),
//                 actions: [
//                   TextButton(
//                     child: Text('OK'),
//                     onPressed: () {
//                       Navigator.of(context).pop();
//                     },
//                   ),
//                 ],
//               );
//             },
//           );
//         }
//       }
//     } else {
//       print("Aucun document trouvé");
//     }
//   } catch (error) {
//     print("Erreur lors de la récupération des données : $error");
//   }
// }


Future<int> getNumberOfDocuments(String nomCollection,String idAttribute) async {
String id_entr="1";

  await FirebaseFirestore.instance
      .collection('employee')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .get()
      .then((snapshot) async {
    if (snapshot.exists) {
        id_entr = snapshot.data()!["id_Etrp"];
    }
  });

  int numberOfDocuments = 0;

  CollectionReference collectionRef = FirebaseFirestore.instance.collection(nomCollection);

  // Obtenir la liste des documents de la collection
  // QuerySnapshot querySnapshot = await collectionRef.get();
  QuerySnapshot querySnapshot = await collectionRef.where(idAttribute, isEqualTo: id_entr).get();

  // Parcourir les documents et incrémenter le compteur
  for (QueryDocumentSnapshot documentSnapshot in querySnapshot.docs) {
    numberOfDocuments++;
  }

  return numberOfDocuments;
}


Future<void> createHistory(String Entrp, String who, String when, String what) async {
  await FirebaseFirestore.instance
      .collection(
      "historique")
      .add({
    'dateAjout':when,
    'action':what,
    'id_employe':  who,
    'id_Entrp':  Entrp,


  }).then((myNewDoc) async{
    firebaseFiretore
        .collection(
        "historique")
        .doc(myNewDoc.id)
        .update({
      'id_hstr': myNewDoc,
    });
  });
}



// Upload Image
//
// File? _imageFile;
// final picker = ImagePicker();
//
// Future getImageFromCamera() async {
//   final pickedFile = await picker.getImage(source: ImageSource.camera);
//
//
//     _imageFile = File(pickedFile!.path);
//
//
//
//   // Call uploadImageToFirestore here
//   await uploadImageToFirestore(_imageFile!);
// }
//
// Future getImageFromGallery() async {
//   final pickedFile = await picker.getImage(source: ImageSource.gallery);
//
//
//     _imageFile = File(pickedFile!.path);
//
//
//
//   // Call uploadImageToFirestore here
//   await uploadImageToFirestore(_imageFile!);
// }
// Future getImageFromWeb() async {
//   final result = await FilePicker.platform.pickFiles(type: FileType.image);
//   if (result != null) {
//     final bytes = result.files.single.bytes!;
//     final directory = await getApplicationDocumentsDirectory();
//     final imageFile = File('${directory.path}/${result.files.single.name}.jpg');
//     await imageFile.writeAsBytes(bytes);
//
//       _imageFile = imageFile;
//
//     await uploadImageToFirestore(_imageFile!);
//   }
// }






Future uploadImageToFirestore(File imageFile) async {
  // Upload the image to Firebase Storage
  final storageReference = FirebaseStorage.instance.ref().child('images/${DateTime.now().toString()}');
  final uploadTask = storageReference.putFile(imageFile);
  final downloadUrl = await (await uploadTask).ref.getDownloadURL();

  // Save the image URL to Firebase Firestore
  final documentReference = FirebaseFirestore.instance.collection('images').doc();
  await documentReference.set({'imageUrl': downloadUrl});
}




Future<List<Map<String, dynamic>>> getUnpaidCharges() async {
  String id_entr="1";
  await FirebaseFirestore.instance
      .collection('employee')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .get()
      .then((snapshot) async {
    if (snapshot.exists) {
      id_entr = snapshot.data()!["id_Etrp"];

    }
  });



  List<Map<String, dynamic>> unpaidChargesList = [];

  QuerySnapshot querySnapshot = await FirebaseFirestore.instance
      .collection('charges')
      .where('etat', isEqualTo: 'Non payée')
      .get();

  querySnapshot.docs.forEach((doc) async {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>; // Cast to Map<String, dynamic>
    if(data['etrpID'] ==  id_entr)

        {
      DocumentSnapshot typeChargesSnapshot = await FirebaseFirestore.instance
          .collection('typeCharges')
          .doc(data['id_type'])
          .get();

      Map<String, dynamic> typeChargesData = typeChargesSnapshot.data()
          as Map<String, dynamic>; // Cast to Map<String, dynamic>
      String designation = typeChargesData['désignation'];
      String icon = typeChargesData['icon'];

      Map<String, dynamic> charge = {
        'icon': icon,
        'amount': data['totalTTC'],
        'label': designation,
      };

      unpaidChargesList.add(charge);
    }
  });

  return unpaidChargesList;
}




// Future getDataFromDatabase() async {
//   // String id_entr="1";
//   await FirebaseFirestore.instance
//       .collection('employee')
//       .doc(FirebaseAuth.instance.currentUser!.uid)
//       .get()
//       .then((snapshot) async {
//     if (snapshot.exists) {
//       String id_entr = snapshot.data()!["id_Etrp"];
//
//         await FirebaseFirestore.instance
//             .collection('infoEntrp')
//             .doc(id_entr)
//             .get()
//             .then((snapshot) async {
//           if (snapshot.exists) {
//
//             String minStock = snapshot.data()!["qttMinStock"];
//
//           }
//         });
//
//     }
//   });
// }



Future<List<Map<String, dynamic>>> getstockLeft() async {

  String minStock="1";
  String id_entr="1";
  await FirebaseFirestore.instance
      .collection('employee')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .get()
      .then((snapshot) async {
    if (snapshot.exists) {
       id_entr = snapshot.data()!["id_Etrp"];

      await FirebaseFirestore.instance
          .collection('infoEntrp')
          .doc(id_entr)
          .get()
          .then((snapshot) async {
        if (snapshot.exists) {

           minStock = snapshot.data()!["qttMinStock"];

        }
      });

    }
  });


  List<Map<String, dynamic>> stockLeftList = [];

  QuerySnapshot querySnapshot = await FirebaseFirestore.instance
      .collection('articles')
      .get();

  querySnapshot.docs.forEach((doc) async {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>; // Cast to Map<String, dynamic>
if(int.parse(data['Qte']) <= int.parse(minStock)  && data['id_EtrpC'] ==  id_entr) {

      Map<String, dynamic> charge = {
        'label': data['désignation'],
        'qtt': data['Qte'],
        'sousLabel': " Il ne reste que  ${data['Qte']} articles",
      };

      stockLeftList.add(charge);
    }
  });

  return stockLeftList;
}


Future<List<Map<String, dynamic>>> getUnpaidVente() async {

  String id_entr="1";
  await FirebaseFirestore.instance
      .collection('employee')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .get()
      .then((snapshot) async {
    if (snapshot.exists) {
       id_entr = snapshot.data()!["id_Etrp"];

    }
  });




  List<Map<String, dynamic>> UnpaidVenteList = [];

  QuerySnapshot querySnapshot = await FirebaseFirestore.instance
      .collection('ventes')
      .where('etat', isEqualTo: 'Non payé')
      .get();



  querySnapshot.docs.forEach((doc) async {
    Map<String, dynamic> data =
    doc.data() as Map<String, dynamic>;


    if(data['etrpID'] ==  id_entr){
     // Cast to Map<String, dynamic>
      DocumentSnapshot typeChargesSnapshot = await FirebaseFirestore.instance
          .collection('Clients')
          .doc(data['id_entrC'])
          .get();

      Map<String, dynamic> typeChargesData = typeChargesSnapshot.data()
          as Map<String, dynamic>; // Cast to Map<String, dynamic>
      String designation = typeChargesData['désignation'];

      Map<String, dynamic> charge = {
        'icon': 'assets/get.svg',
        'label': designation,
        'amount': "${data['totalTTC']} DH",
        'descr': "${data['dateAjout'].substring(0,10)}",
      };

      UnpaidVenteList.add(charge);


    }
  });

  return UnpaidVenteList;
}

Future<List<Map<String, dynamic>>> getUnpaidAchat() async {

  String id_entr="1";
  await FirebaseFirestore.instance
      .collection('employee')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .get()
      .then((snapshot) async {
    if (snapshot.exists) {
      id_entr = snapshot.data()!["id_Etrp"];

    }
  });




  List<Map<String, dynamic>> UnpaidVenteList = [];

  QuerySnapshot querySnapshot = await FirebaseFirestore.instance
      .collection('achats')
      .where('etat', isEqualTo: 'Non payé')
      .get();



  querySnapshot.docs.forEach((doc) async {
    Map<String, dynamic> data =
    doc.data() as Map<String, dynamic>;


    if(data['etrpID'] ==  id_entr){
      // Cast to Map<String, dynamic>
      DocumentSnapshot typeChargesSnapshot = await FirebaseFirestore.instance
          .collection('Fournisseurs')
          .doc(data['id_entrF'])
          .get();

      Map<String, dynamic> typeChargesData = typeChargesSnapshot.data()
      as Map<String, dynamic>; // Cast to Map<String, dynamic>
      String designation = typeChargesData['désignation'];

      Map<String, dynamic> charge = {
        'icon': 'assets/give.svg',
        'label': designation,
        'amount': "${data['totalTTC']} DH",
        'descr': "${data['dateAjout'].substring(0,10)}",
      };

      UnpaidVenteList.add(charge);
      UnpaidVenteList.forEach((element) {
        print("icon: ${element["icon"]}");
        print("label: ${element["label"]}");
        print("amount: ${element["amount"]}");
        print("descr: ${element["descr"]}");
      });

    }
  });

  return UnpaidVenteList;
}

