import 'package:cloud_firestore/cloud_firestore.dart';

class villeModel {
  // static const ID = "id_ville";
  // static const DESIGNATION = "désignation";

  late String id;
  late String designation;

  villeModel({required this.id, required this.designation});

//  getters
  String get ID => id;

  String get DESIGNATION => designation;

// public variable

// villeModel.fromSnapshot(DocumentSnapshot snapshot) {
//   _id = snapshot.data["nom"];
//   _designation = snapshot.data()![DESIGNATION];
// }
}

class roleEmpModel {
  // static const ID = "id_ville";
  // static const DESIGNATION = "désignation";

  late String id;
  late String designation;

  roleEmpModel({required this.id, required this.designation});

//  getters
  String get ID => id;

  String get DESIGNATION => designation;

// public variable

// villeModel.fromSnapshot(DocumentSnapshot snapshot) {
//   _id = snapshot.data["nom"];
//   _designation = snapshot.data()![DESIGNATION];
// }
}


class categoriesModel {
  late String id_cat;
  late String designation;
  late String about;
  late String dateAjout;
  late String ImagePath;
  late String id_Etrp;
  late String id_ajoutPar;
  late String state;


  categoriesModel(
      {required this.id_cat,
        required this.designation,
        required this.about,
        required this.id_Etrp,
        required this.dateAjout,
        required this.id_ajoutPar,
        required this.ImagePath,
        required this.state});

//  getters
  String get ID => id_cat;
  String get DESIGNATION => designation;
  String get DATEAJOUT => dateAjout;
  String get DESCRIPTION => about;
  String get ID_ETRP => id_Etrp;
  String get ID_AJOUTPAR => id_ajoutPar;
  String get IMAGEPATH => ImagePath;
  String get STATE => state;
}
class entrpInfoModel {
  late String id_Etrp;
  late String designation;
  late String about;

  late String ImagePath;
  late String fax;
  late String email;

  late String id_roleEtrps;
  late String id_ville;
  late String infoBc;

  late String localisation;
  late String tel;
  late String adresse;


  entrpInfoModel(
      {required this.id_Etrp,
        required this.designation,
        required this.about,

        required this.fax,
        required this.email,
        required this.id_roleEtrps,

        required this.ImagePath,
        required this.id_ville,
        required this.infoBc,

        required this.tel,
        required this.localisation,
        required this.adresse,


      });

//  getters
  String get ID => id_Etrp;
  String get DESIGNATION => designation;
  String get FAX => fax;

  String get DESCRIPTION => about;
  String get ID_ETRP => id_Etrp;
  String get EMAIL => email;

  String get IMAGEPATH => ImagePath;
  String get TEL => tel;
  String get ADRESSE => adresse;

  String get ID_ROLETRPS => id_roleEtrps;
  String get INFOBC => infoBc;
  String get ID_VILLE => id_ville;


}

class articlesModel {
  late String id;
  late String designation;
  late String qte;
  late String capital;
  late String dateAjout;
  late String description;
  late String id_EtrpC;
  late String id_EtrpF;
  late String id_cat;
  late String id_employe;
  late String reference;
  late String prixAchat;
  late String prixVente;
  late String imagePath;
  late String state;

  articlesModel(
      {required this.id,
      required this.designation,
      required this.qte,
      required this.capital,
      required this.dateAjout,
      required this.description,
      required this.id_EtrpC,
      required this.id_EtrpF,
      required this.id_cat,
      required this.id_employe,
      required this.reference,
      required this.prixAchat,
      required this.imagePath,
      required this.state,
      required this.prixVente});

//  getters
  String get ID => id;
  String get DESIGNATION => designation;
  String get QTE => qte;
  String get CAPITAL => capital;
  String get DATEAJOUT => dateAjout;
  String get DESCRIPTION => description;
  String get ID_ETRPF => id_EtrpF;
  String get ID_ETRPC => id_EtrpC;
  String get ID_CAT => id_cat;
  String get ID_EMPLOYE => id_employe;
  String get REFERENCE => reference;
  String get PRIXACHAT => prixAchat;
  String get PRIXVENTE => prixVente;
  String get IMAGEPATH => imagePath;
  String get STATE => state;
}

class FournisseurModel {
  late String id_EtrpAddBy;
  late String id_ajoutPar;
  late String dateAjout;
  late String cPostal;
  late String state;

  late String ImagePath;
  late String designation;
  late String id_Fourn;

  late String fax;
  late String email;
  late String id_ville;

  late String adresse;
  late String tel;



  FournisseurModel(
      {required this.id_EtrpAddBy,
        required this.id_ajoutPar,
        required this.dateAjout,

        required this.fax,
        required this.email,
        required this.ImagePath,

        required this.designation,
        required this.id_ville,
        required this.id_Fourn,

        required this.tel,
        required this.adresse,
        required this.cPostal,
        required this.state,


      });

//  getters
  String get ID => id_Fourn;
  String get DESIGNATION => designation;
  String get FAX => fax;

  String get DATEAJOUT => dateAjout;
  String get ID_ETRPADDBYE => id_EtrpAddBy;
  String get EMAIL => email;

  String get IMAGEPATH => ImagePath;
  String get TEL => tel;
  String get ADRESSE => adresse;

  String get ID_ADDBYE => id_ajoutPar;
  String get ID_VILLE => id_ville;
  String get CPOSTAL => cPostal;
  String get STATE => state;


}


class ClientModel {
  late String id_EtrpAddBy;
  late String id_ajoutPar;
  late String dateAjout;
  late String cPostal;

  late String ImagePath;
  late String designation;
  late String id_Client;

  late String fax;
  late String email;
  late String id_ville;

  late String adresse;
  late String tel;
  late String state;



  ClientModel(
      {required this.id_EtrpAddBy,
        required this.id_ajoutPar,
        required this.dateAjout,

        required this.fax,
        required this.email,
        required this.ImagePath,

        required this.designation,
        required this.id_ville,
        required this.id_Client,

        required this.tel,
        required this.adresse,
        required this.cPostal,
        required this.state,


      });

//  getters
  String get ID => id_Client;
  String get DESIGNATION => designation;
  String get FAX => fax;

  String get DATEAJOUT => dateAjout;
  String get ID_ETRPADDBYE => id_EtrpAddBy;
  String get EMAIL => email;

  String get IMAGEPATH => ImagePath;
  String get TEL => tel;
  String get ADRESSE => adresse;

  String get ID_ADDBYE => id_ajoutPar;
  String get ID_VILLE => id_ville;
  String get CPOSTAL => cPostal;
  String get STATE => state;


}


class LivreurModel {
  late String id_EtrpAddBy;
  late String id_ajoutPar;
  late String dateAjout;

  late String dispo;
  late String state;
  late String ImagePath;
  late String designation;

  late String id_employee;
  late String email;

  late String adresse;
  late String tel;
  late String idRole;



  LivreurModel(
      {required this.id_EtrpAddBy,
        required this.id_ajoutPar,
        required this.dateAjout,

        required this.dispo,
        required this.state,
        required this.email,

        required this.ImagePath,
        required this.designation,
        required this.tel,

        required this.adresse,
        required this.idRole,
        required this.id_employee,



      });

//  getters
  String get DESIGNATION => designation;
  String get DATEAJOUT => dateAjout;

  String get ID_ETRPADDBYE => id_EtrpAddBy;
  String get EMAIL => email;
  String get IMAGEPATH => ImagePath;

  String get TEL => tel;
  String get ADRESSE => adresse;
  String get ID_ADDBYE => id_ajoutPar;

  String get ID_ROLE => idRole;
  String get DISPO => dispo;
  String get STATE => state;
  String get ID_EMPLOYEE => id_employee;



}


class TypeChargeModel {
  late String id_EtrpAddBy;
  late String id_ajoutPar;
  late String dateAjout;
  late String designation;
  late String id_type;
  late String state;





  TypeChargeModel(
      {required this.id_EtrpAddBy,
        required this.id_ajoutPar,
        required this.dateAjout,
        required this.designation,
        required this.id_type,
        required this.state,

      });

//  getters

  String get DESIGNATION => designation;
  String get DATEAJOUT => dateAjout;
  String get ID_ETRPADDBYE => id_EtrpAddBy;
  String get ID_ADDBYE => id_ajoutPar;
  String get ID => id_type;
  String get STATE => state;



}