
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
import 'package:adminsignin/component/sideMenu.dart';
import 'package:adminsignin/config/size_config.dart';
import 'package:intl/intl.dart';
import 'package:adminsignin/component/table.dart';

class newClient extends StatefulWidget {
  newClient({super.key});

  @override
  State<newClient> createState() => newClientState();
}

class newClientState extends State<newClient> {
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

  // List<dynamic> villes = [];
  // String? villeId;
  FirebaseFirestore firebaseFiretore = FirebaseFirestore.instance;
  TextEditingController _desigFournTextController = TextEditingController();

  TextEditingController _adresseTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _faxTextController = TextEditingController();
  TextEditingController _villeTextController = TextEditingController();
  TextEditingController _telTextController = TextEditingController();

  late villeModel dataville;
  List<villeModel> ville = [];

  // final DataTableSource MyDataTable = MyData();
  String EntrpNom = "";
  // String id_ville = "";
  late String id_entr="-1";
  late String id_roleETRP="-1";
  late String id_user="-1";
  String defaultPath="https://cdn-icons-png.flaticon.com/512/1560/1560896.png";
  Future getDataFromDatabase() async {
    await FirebaseFirestore.instance
        .collection('employee')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((snapshot) async {
      if (snapshot.exists) {
        setState(() async  {
          String idEtrp="-1";
          id_entr = snapshot.data()!["id_Etrp"];
          id_user = snapshot.data()!["id_employe"];
          idEtrp = snapshot.data()!["id_Etrp"];

          await FirebaseFirestore.instance
              .collection('infoEntrp')
              .doc(idEtrp)
              .get()
              .then((snapshot) async {
            if (snapshot.exists) {
              setState(() {
                id_roleETRP =snapshot.data()!["id_roleEtrps"];
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

  Future<void> addNewClient(String cPostal,String designation,String ImagePath,String adresse,String email,String fax,String tel,String id_ville) async {
    firebaseFiretore
        .collection("Clients")
        .add({
      "cPostal":cPostal,
      "désignation":
  designation,
      "id_ajoutPar": id_user,
      "id_EtrpAddBy": id_entr,
      // "id_cat": reference.documetID,
      "dateAjout": DateFormat('yyyy-MM-dd   HH:mm').format(DateTime.now()),
      "ImagePath":ImagePath,
      "state": "activated",
      "adresse":
      adresse,
      "email":
      email,
      "fax":
      fax,
      "id_ville":
      id_ville,
      "tel":
      tel,
    }).then((myNewDoc)
    {
      firebaseFiretore
          .collection(
          "Clients")
          .doc(myNewDoc.id)
          .update({
        "id_Client":
        "${myNewDoc.id}"
      });


    });

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
                        Header('Clients', 'Trouvez des clients'),
                        SizedBox(
                          height: 60,
                        ),
                        // PrimaryText(
                        //   text: 'AJOUTER UN CLIENT ',
                        //   size: 18,
                        //   fontWeight: FontWeight.w800,
                        //   color: AppColors.them,
                        // ),
                        // SizedBox(
                        //   height: 30,
                        // ),
                        SizedBox(
                          height: 60,
                        ),
                        PrimaryText(
                          text: 'EXPLOREZ DES NOUVEAUX CLIENTS', size: 18, fontWeight: FontWeight.w800, color: AppColors.them,),
                        SizedBox(
                          height: 20,
                        ),

                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: double.infinity,
                              child: StreamBuilder<QuerySnapshot>(
                                  stream: FirebaseFirestore.instance.collection('infoEntrp').snapshots(),
                                  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                    if (!snapshot.hasData) {
                                      return const CircularProgressIndicator();
                                    }

                                    if (snapshot.hasData) {
                                        List<DataRow>? rows = snapshot.data?.docs.where((doc) {
                                          var routeArgs = doc.data() as Map<String, dynamic>;
                                          String idRoleEtrp = routeArgs['id_roleEtrps'];

                                         if(idRoleEtrp != id_roleETRP) {
                                          if (id_roleETRP ==
                                              "3RExF18oFMEYSatplJIM") {
                                            return idRoleEtrp ==
                                                "3RExF18oFMEYSatplJIM";
                                          } else if (id_roleETRP ==
                                              "00jTKhiAdfMt5LO6xet0") {
                                            return (idRoleEtrp ==
                                                    "3RExF18oFMEYSatplJIM" ||
                                                idRoleEtrp ==
                                                    "00jTKhiAdfMt5LO6xet0");
                                          } else if (id_roleETRP ==
                                              "s5VgYPc7Xu2RNL5lOe3i") {
                                            return (idRoleEtrp ==
                                                    "3RExF18oFMEYSatplJIM" ||
                                                idRoleEtrp ==
                                                    "00jTKhiAdfMt5LO6xet0" ||
                                                idRoleEtrp ==
                                                    "s5VgYPc7Xu2RNL5lOe3i");
                                          }
                                        }

                                        return false;
                                        }).map((doc){
                                            var routeArgs = doc.data() as Map;
                                        // String idCat=routeArgs['id_cat'];
                                        var photo= routeArgs['imagePath'];
                                        var cPostal= routeArgs['cPostal'];
                                        var designation= routeArgs['désignation'];
                                        var adresse= routeArgs['adresse'];
                                        var email= routeArgs['email'];
                                        var tel= routeArgs['tel'];
                                        var fax= routeArgs['fax'];
                                        var id_ville= routeArgs['id_ville'];

                                        return DataRow(
                                          cells: [
                                            DataCell(Row(mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                IconButton(
                                                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                                    iconSize: 20,
                                                    icon: Icon(Icons.add, color: AppColors.them),
                                                    onPressed: () async{
                                                      await addNewClient( cPostal, designation, photo, adresse, email, fax, tel, id_ville);
                                                      ScaffoldMessenger.of(context).showSnackBar(
                                                          SnackBar(content: Text("Client ajouté avec succès"),backgroundColor:AppColors.them,showCloseIcon: true,));
                                                      Navigator.pop(context);
                                                    }),
                                                // IconButton(
                                                //     padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                                //     iconSize: 20,
                                                //     icon: Icon(Icons.delete, color: Colors.red),
                                                //     onPressed: () {
                                                //     }
                                                // ),
                                                // Icon(Icons.edit, color: AppColors.them),
                                                // Icon(Icons.delete, color: AppColors.them),

                                              ],


                                            ),),
                                            DataCell(InkWell(
                                              child: CircleAvatar(
                                                radius: 17,
                                                backgroundImage: NetworkImage(
                                                    image=='' ?defaultPath : photo
                                                  // image==null ?defaultPath : image!
                                                  // defaultPath,

                                                ),


                                              ),
                                              onTap: () {
                                                // Navigator.push(
                                                //   context,
                                                //   MaterialPageRoute(
                                                //     builder: (context) => employees(),
                                                //   ),
                                                // );
                                                print("moving to EmployeesProfile");
                                              },
                                            )),
                                            DataCell(StreamBuilder(
                                                stream: FirebaseFirestore.instance.collection('roleEtrps').doc(routeArgs['id_roleEtrps']).snapshots(),
                                                builder: (context, snapshot) { if (snapshot.hasError) {
                                                  return Text('Something went wrong');
                                                }
                                                if (snapshot.hasData) {
                                                  String role;
                                                  role=snapshot.data!["désignation"];

                                                  return Text(role ?? 'default value');
                                                }

                                                return Loading();

                                                }
                                            ),),

                                            DataCell(Text(routeArgs['désignation'] ?? 'default value')),
                                            DataCell(Text(routeArgs['email'] ?? 'default value')),
                                            DataCell(Text(routeArgs['fax'] ?? 'default value')),
                                            DataCell(Text(routeArgs['tel'] ?? 'default value')),

                                            // DataCell(StreamBuilder(
                                            //     stream: FirebaseFirestore.instance.collection('villes').doc(routeArgs['id_ville']).snapshots(),
                                            //     builder: (context, snapshot) { if (snapshot.hasError) {
                                            //       return Text('Something went wrong');
                                            //     }
                                            //     if (snapshot.hasData) {
                                            //       String addBy;
                                            //       addBy=snapshot.data!["désignation"];
                                            //
                                            //       return Text(addBy ?? 'default value');
                                            //     }
                                            //
                                            //     return Loading();
                                            //
                                            //     }
                                            // ),),
                                            // // DataCell(Text(routeArgs['about'] ?? 'default value')),
                                            // // DataCell(Text(routeArgs['id_ajoutPar'] ?? 'default value')),
                                            // DataCell(Text(routeArgs['adresse'] ?? 'default value')),
                                            // // DataCell(Text(routeArgs['id_Etrp'] ?? 'default value')),
                                            //
                                            // DataCell(StreamBuilder(
                                            //     stream: FirebaseFirestore.instance.collection('employee').doc(routeArgs['id_ajoutPar']).snapshots(),
                                            //     builder: (context, snapshot) { if (snapshot.hasError) {
                                            //       return Text('Something went wrong');
                                            //     }
                                            //     if (snapshot.hasData) {
                                            //       String addBy;
                                            //       addBy=snapshot.data!["nom"];
                                            //
                                            //       return Text(addBy ?? 'default value');
                                            //     }
                                            //
                                            //     return Loading();
                                            //
                                            //     }
                                            // ),),
                                            // DataCell(Text(routeArgs['dateAjout'] ?? 'default value')),
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
                                          DataColumn(label: Center(child: Text("Image"))),
                                          DataColumn(label: Center(child: Text("Role"))),
                                          DataColumn(label: Center(child: Text("Désignation"))),
                                          DataColumn(label: Center(child: Text("Email"))),
                                          DataColumn(label: Center(child: Text("Fax"))),
                                          DataColumn(label: Center(child: Text("Téléphone"))),
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

//CLIENT