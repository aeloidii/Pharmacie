// import 'package:cloud_firestore/cloud_firestore.dart';
//
// import 'dart:math';
//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:responsive_table/responsive_table.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
//
// // firebase
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
//
// final Future<FirebaseApp> initialization = Firebase.initializeApp();
//
// FirebaseFirestore firebaseFiretore = FirebaseFirestore.instance;
// FirebaseAuth auth = FirebaseAuth.instance;
//
//
//
// class TablesProvider with ChangeNotifier {
//   // ANCHOR table headers
//   List<DatatableHeader> usersTableHeader = [
//     DatatableHeader(
//         text: "ID",
//         value: "id",
//         show: true,
//         sortable: true,
//         textAlign: TextAlign.left),
//     DatatableHeader(
//         text: "Name",
//         value: "name",
//         show: true,
//         flex: 2,
//         sortable: true,
//         textAlign: TextAlign.left),
//     DatatableHeader(
//         text: "Email",
//         value: "email",
//         show: true,
//         sortable: true,
//         textAlign: TextAlign.left),
//   ];
//
//
//
//
//   List<int> perPages = [5, 10, 15, 100];
//   int total = 100;
//   int currentPerPage;
//   int currentPage = 1;
//   bool isSearch = false;
//   List<Map<String, dynamic>> usersTableSource = <Map<String, dynamic>>[];
//
//   List<Map<String, dynamic>> selecteds = <Map<String, dynamic>>[];
//
//
//   String selectableKey = "id";
//
//   String sortColumn;
//   bool sortAscending = true;
//   bool isLoading = true;
//   bool showSelect = true;
//
//   UserServices _userServices = UserServices();
//   List<UserModel> _users = <UserModel>[];
//   List<UserModel> get users => _users;
//
//
//   Future _loadFromFirebase() async {
//     _users = await _userServices.getAllUsers();
//
//   }
//
//   List<Map<String, dynamic>> _getUsersData() {
//     isLoading = true;
//     notifyListeners();
//     List<Map<String, dynamic>> temps = <Map<String, dynamic>>[];
//     var i = _users.length;
//     print(i);
//     for (UserModel userData in _users) {
//       temps.add({
//         "id": userData.id,
//         "email": userData.email,
//         "name": userData.name,
//       });
//       i++;
//     }
//     isLoading = false;
//     notifyListeners();
//     return temps;
//   }
//
//
//   _initData() async {
//     isLoading = true;
//     notifyListeners();
//     await _loadFromFirebase();
//     usersTableSource.addAll(_getUsersData());
//
//
//     isLoading = false;
//     notifyListeners();
//   }
//
//   onSort(dynamic value) {
//     sortColumn = value;
//     sortAscending = !sortAscending;
//     if (sortAscending) {
//       usersTableSource
//           .sort((a, b) => b["$sortColumn"].compareTo(a["$sortColumn"]));
//     } else {
//       usersTableSource
//           .sort((a, b) => a["$sortColumn"].compareTo(b["$sortColumn"]));
//     }
//     notifyListeners();
//   }
//
//   onSelected(bool value, Map<String, dynamic> item) {
//     print("$value  $item ");
//     if (value) {
//       selecteds.add(item);
//     } else {
//       selecteds.removeAt(selecteds.indexOf(item));
//     }
//     notifyListeners();
//   }
//
//   onSelectAll(bool value) {
//     if (value) {
//       selecteds = usersTableSource.map((entry) => entry).toList().cast();
//     } else {
//       selecteds.clear();
//     }
//     notifyListeners();
//   }
//
//   onChanged(int value) {
//     currentPerPage = value;
//     notifyListeners();
//   }
//
//   previous() {
//     currentPage = currentPage >= 2 ? currentPage - 1 : 1;
//     notifyListeners();
//   }
//
//   next() {
//     currentPage++;
//     notifyListeners();
//   }
//
//   TablesProvider.init() {
//     _initData();
//   }
// }
//
//
//
//
//
//
//
// class UserServices {
//   String adminsCollection = "admins";
//   String usersCollection = "users";
//
//   void createAdmin({
//     required String id,
//     required String name,
//     required String email,
//   }) {
//     firebaseFiretore.collection(adminsCollection).doc(id).set({
//       "name": name,
//       "id": id,
//       "email": email,
//     });
//   }
//
//   void updateUserData(Map<String, dynamic> values) {
//     firebaseFiretore
//         .collection(adminsCollection)
//         .doc(values['id'])
//         .update(values);
//   }
//
//   Future<UserModel> getAdminById(String id) =>
//       firebaseFiretore.collection(adminsCollection).doc(id).get().then((doc) {
//         return UserModel.fromSnapshot(doc);
//       });
//
//   Future<List<UserModel>> getAllUsers() async =>
//       firebaseFiretore.collection(usersCollection).get().then((result) {
//         List<UserModel> users = [];
//         for (DocumentSnapshot user in result.docs) {
//           users.add(UserModel.fromSnapshot(user));
//         }
//         return users;
//       });
// }
//
//
// class UserModel {
//   static const ID = "uid";
//   static const NAME = "name";
//   static const EMAIL = "email";
//
//   String _id="";
//   String _name="";
//   String _email;
//
// //  getters
//   String get name => _name;
//   String get email => _email;
//   String get id => _id;
//
//   UserModel.fromSnapshot(DocumentSnapshot snapshot) {
//     _name = snapshot.data()![NAME];
//     _email = snapshot.data()![EMAIL];
//     _id = snapshot.data()![ID];
//   }
// }
