import 'package:adminsignin/Model/Models.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

class ProductProvider with ChangeNotifier {
  late villeModel dataville;
  List<villeModel> feature = [];
  Future<void> getFeatureData() async {
    List<villeModel> newList = [];
    QuerySnapshot featureSnapShot = await FirebaseFirestore.instance
        .collection("villes").get();
    featureSnapShot.docs.forEach(
          (element) {
            dataville = villeModel(
            id: element["id_ville"],
                designation: element["désignation"]);
        newList.add(dataville);
      },
    );
    feature = newList;
    notifyListeners();
  }

  List<villeModel> get getFeatureList {
    return feature;
  }
}
