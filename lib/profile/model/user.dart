import 'package:cloud_firestore/cloud_firestore.dart';

class UserAd {
  final String id;
  final String imagePath;
  final String name;
  final String email;
  final String about;
  final String phone;
  final String passwd;
  // final bool isDarkMode;

  const UserAd({
    required this.id,
    required this.imagePath,
    required this.name,
    required this.email,
    required this.about,
    required this.phone,
    required this.passwd,
    // required this.isDarkMode,
  });


  String get _name => name;
  String get _email => email;
  String get _phone => phone;



  //
  // toJson(){
  //   return {"FullName": name,"Email": email,"Phone": phone,"Password": passwd,"About": about,"ImagePath": imagePath};
  // }
  //
  //
  // factory UserAd.fromSnapshot(DocumentSnapshot<Map<String,dynamic>> document){
  //   final data= document.data();
  //   return UserAd(
  //     id: document.id,
  //     email: data!["Email"],
  //     name: data["FullName"],
  //     phone: data["Phone"],
  //     passwd: data["Password"],
  //     about: data["About"],
  //     imagePath: data["ImagePath"],
  //   );
  // }

}
