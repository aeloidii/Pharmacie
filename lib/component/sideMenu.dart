import 'package:adminsignin/component/article.dart';
import 'package:adminsignin/component/categorie.dart';
import 'package:adminsignin/component/employees.dart';
import 'package:adminsignin/component/dmndPrix.dart';
import 'package:adminsignin/component/paiementRecu.dart';
import 'package:adminsignin/component/suppliers.dart';
import 'package:adminsignin/component/typeCharge.dart';
import 'package:adminsignin/component/venteRetournee.dart';
import 'package:adminsignin/component/ventes.dart';
import 'package:adminsignin/component/versementF.dart';
import 'package:adminsignin/config/size_config.dart';
import 'package:adminsignin/dashboard.dart';
import 'package:adminsignin/style/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../component/subMenu.dart';
import 'package:adminsignin/component/infoSociet.dart';
import '../colorutils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:adminsignin/reusable_widget/loading.dart';

import 'BL.dart';
import 'Clients.dart';
import 'achatRetournee.dart';
import 'achats.dart';
import 'addCharge.dart';
import 'bonCommande.dart';
import 'devis.dart';
import 'facture.dart';
import 'livraison.dart';

class SideMenu extends StatefulWidget {
  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  late String id_entr = "1";
  late String id_user;
  late String EntrpNom = "5";
  String id_role = "1";

  // Future getDataFromDatabase() async {
  //   await FirebaseFirestore.instance
  //       .collection('employee')
  //       .doc(FirebaseAuth.instance.currentUser!.uid)
  //       .get()
  //       .then((snapshot) async {
  //     if (snapshot.exists) {
  //       setState(() async {
  //         id_entr = snapshot.data()!["id_Etrp"];
  //         id_user = snapshot.data()!["id_employe"];
  //         id_role = snapshot.data()!["id_roleEmpls"];
  //
  //         await FirebaseFirestore.instance
  //             .collection('roleEmpls')
  //             .doc(id_role)
  //             .get()
  //             .then((snapshot) async {
  //           if (snapshot.exists) {
  //             setState(() {
  //               String role = snapshot.data()!["désignation"];
  //               EntrpNom = role;
  //               print(EntrpNom);
  //             });
  //           }
  //         });
  //       });
  //     }
  //   });
  // }
  Future<void> getDataFromDatabase() async {
    DocumentSnapshot employeeSnapshot = await FirebaseFirestore.instance
        .collection('employee')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

    if (employeeSnapshot.exists) {
      Map<String, dynamic>? employeeData = employeeSnapshot.data() as Map<String, dynamic>?;

      if (employeeData != null) {
        id_entr = employeeData["id_Etrp"];
        id_user = employeeData["id_employe"];
        id_role = employeeData["id_roleEmpls"];

        DocumentSnapshot roleSnapshot = await FirebaseFirestore.instance
            .collection('roleEmpls')
            .doc(id_role)
            .get();

        if (roleSnapshot.exists) {
          Map<String, dynamic>? roleData = roleSnapshot.data() as Map<String, dynamic>?;

          if (roleData != null) {
            String role = roleData["désignation"];
            setState(() {
              EntrpNom = role;
              print(EntrpNom);
            });
          }
        }
      }
    }
  }

  @override
  void initState() {
    super.initState();
    // this.villes.add({"id":1,"label":"Casablanca"});
    // this.villes.add({"id":2,"label":"Safi"});
    // getFeatureData();
    getDataFromDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 0,
      child: Container(
        width: double.infinity,
        height: SizeConfig.screenHeight,
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          hexSrtingToColor("20B2AA"),
          hexSrtingToColor("00816D"),
          hexSrtingToColor("BCF0AC")
        ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 100,
                alignment: Alignment.topCenter,
                width: double.infinity,
                padding: EdgeInsets.only(top: 20),
                child: SizedBox(
                  width: 100,
                  height: 100,
                  child: Image.asset(
                    'assets/appLogo.png',
                    fit: BoxFit.fitWidth,
                    width: 240,
                    height: 240,
                    color: Colors.white,
                  ),
                ),
              ),

              // Container(
              //
              //   child:IconButton(
              //     iconSize: 20,
              //     padding: EdgeInsets.symmetric(vertical: 20.0),
              //     icon: SvgPicture.asset(
              //       'assets/home.svg',
              //       color: AppColors.white,
              //     ),
              //     onPressed: () {}),),

              // Visibility(
              //   visible: (id_role == 'EG1yYKPG9xIVV7esfKx0'),
              //   child: Column(
              //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //     children: [
              //       IconButton(
              //           padding: const EdgeInsets.symmetric(horizontal: 20.0),
              //           iconSize: 20,
              //           icon: SvgPicture.asset(
              //             'assets/pie-chart.svg',
              //             color: AppColors.white,
              //           ),
              //           onPressed: () {
              //             Navigator.push(
              //               context,
              //               MaterialPageRoute(
              //                 builder: (context) => Dashboard(),
              //               ),
              //             );
              //           }),
              //       const Text(
              //         'Dashboard',
              //         style: TextStyle(
              //           color: Colors.white,
              //           fontWeight: FontWeight.w400,
              //           fontFamily: 'Poppins',
              //           fontSize: 12,
              //         ),
              //       ),
              //     ],
              //   ),
              // ),

              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      iconSize: 20,
                      icon: SvgPicture.asset(
                        'assets/pie-chart.svg',
                        color: AppColors.white,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Dashboard(),
                          ),
                        );
                      }),
                  const Text(
                    'Dashboard',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Poppins',
                      fontSize: 12,
                    ),
                  ),
                ],
              ),

              //Stock
              Visibility(
                visible: (id_role != '02S3mJ118bXc5m3TY4ox' && id_role != 'xOQOsiAUNsq6r1Qd5aH1'),
                child: Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          // IconButton(
                          //     iconSize: 20,
                          //     padding: EdgeInsets.symmetric(vertical: 20.0),
                          //     icon: SvgPicture.asset(
                          //       'assets/stock.svg',
                          //       color: AppColors.white,
                          //     ),
                          //     onPressed: () {}),
                          Padding(
                            padding: const EdgeInsets.only(left: 40.0),
                            child: SvgPicture.asset(
                              'assets/stock.svg',
                              color: AppColors.white,
                              width: 20,
                              height: 20,
                            ),
                          ),
                          PopupMenuButton<String>(
                            offset: Offset(20, 0),
                            elevation: 8.0,
                            shape: const TooltipShape(),
                            color: hexSrtingToColor("00816D"),
                            icon: const Icon(Icons.arrow_right_outlined,
                                color: Colors.white),
                            onSelected: (choice) {
                              if (choice == stock.Item1) {
                                print('I Categories');
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CategoriePage(),
                                  ),
                                );
                              } else if (choice == stock.Item2) {
                                print('I Articles');
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ArticlesPage(),
                                  ),
                                );
                              } else if (choice == stock.Item3) {
                                print('I Purchases');
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => achats(),
                                  ),
                                );
                              } else if (choice == stock.Item4) {
                                print('I Sales');
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ventes(),
                                  ),
                                );
                              } else if (choice == stock.Item5) {
                                print('I Returned purchases');
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => achatRetournee(),
                                  ),
                                );
                              } else if (choice == stock.Item6) {
                                print('I Returned sales');
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => venteRetournee(),
                                  ),
                                );
                              }
                            },
                            itemBuilder: (BuildContext context) {
                              return stock.choices.where((String choice) {
                                if (choice == "Categories" && (id_role != "EG1yYKPG9xIVV7esfKx0" && id_role != "r4GZTIH48qUXdEB698X6" && id_role != "PwGN49ZCMmobauCYxOJ9")) {
                                  return false; // Ne pas afficher l'élément "categorie" si id_role n'est pas "respo vente"
                                }
                                if (choice == "Articles" && (id_role != "EG1yYKPG9xIVV7esfKx0" && id_role != "r4GZTIH48qUXdEB698X6" && id_role != "PwGN49ZCMmobauCYxOJ9")) {

                                  return false; // Ne pas afficher l'élément "achat" si id_role n'est pas "respo achat"
                                }
                                if (choice == "Ventes" && (id_role != "EG1yYKPG9xIVV7esfKx0" && id_role != "r4GZTIH48qUXdEB698X6" )) {

                                  return false; // Ne pas afficher l'élément "achat" si id_role n'est pas "respo achat"
                                }
                                if (choice == "Achats" && (id_role != "EG1yYKPG9xIVV7esfKx0" && id_role != "PwGN49ZCMmobauCYxOJ9" )) {

                                  return false; // Ne pas afficher l'élément "achat" si id_role n'est pas "respo achat"
                                }
                                if (choice == "Ventes retournées" && (id_role != "EG1yYKPG9xIVV7esfKx0" && id_role != "r4GZTIH48qUXdEB698X6" )) {

                                  return false; // Ne pas afficher l'élément "achat" si id_role n'est pas "respo achat"
                                }
                                if (choice == "Achats retournés" && (id_role != "EG1yYKPG9xIVV7esfKx0" && id_role != "PwGN49ZCMmobauCYxOJ9" )) {

                                  return false; // Ne pas afficher l'élément "achat" si id_role n'est pas "respo achat"
                                }
                                return true; // Afficher tous les autres éléments
                              }).map((String choice) {
                                return PopupMenuItem<String>(
                                  value: choice,
                                  child: Row(
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.only(left: 8.0, right: 10.0),
                                        child: Icon(
                                          Icons.circle_rounded,
                                          color: Colors.white,
                                          size: 10,
                                        ),
                                      ),
                                      Text(
                                        choice,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w400,
                                          fontFamily: 'Poppins',
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }).toList();
                            },

                          ),
                        ],
                      ),
                      const Text(
                        'Stock',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Poppins',
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // StreamBuilder(
              //     stream: FirebaseFirestore.instance.collection('roleEmpls').doc(id_role).snapshots(),
              //     builder: (context, snapshot) { if (snapshot.hasError) {
              //       return Text('Something went wrong');
              //     }
              //     if (snapshot.hasData) {
              //       String role;
              //       role=snapshot.data!["désignation"];
              //
              //       return Visibility(
              //         visible: role=='Admin',
              //         child: Padding(
              //           padding: const EdgeInsets.only(top:20.0),
              //           child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //             children: [
              //               Row(
              //                 mainAxisAlignment: MainAxisAlignment.start,
              //                 children: [
              //                   // IconButton(
              //                   //     iconSize: 20,
              //                   //     padding: EdgeInsets.symmetric(vertical: 20.0),
              //                   //     icon: SvgPicture.asset(
              //                   //       'assets/stock.svg',
              //                   //       color: AppColors.white,
              //                   //     ),
              //                   //     onPressed: () {}),
              //                   Padding(
              //
              //                     padding: const EdgeInsets.only(left: 40.0),
              //                     child: SvgPicture.asset(
              //                       'assets/supp.svg',
              //                       color: AppColors.white,width: 20,height: 20,
              //                     ),
              //                   ),
              //                   PopupMenuButton<String>(
              //                     offset: Offset(20, 0),
              //                     elevation: 8.0,
              //                     shape: const TooltipShape(),
              //                     color: hexSrtingToColor("00816D"),
              //                     icon: const Icon(Icons.arrow_right_outlined, color: Colors.white),
              //                     onSelected: (choice){
              //                       if (choice == suppliers.Item1) {
              //                         print('I Suppliers');
              //                         Navigator.push(
              //                           context,
              //                           MaterialPageRoute(
              //                             builder: (context) => CategoriePage(),
              //                           ),
              //                         );
              //                       } else if (choice == suppliers.Item2) {
              //                         print('I Credits');
              //                         Navigator.push(
              //                           context,
              //                           MaterialPageRoute(
              //                             builder: (context) => ArticlesPage(),
              //                           ),
              //                         );
              //                       } else if (choice == suppliers.Item3) {
              //                         print('I Verses');
              //                       }
              //                     },
              //                     itemBuilder: (BuildContext context) {
              //                       return suppliers.choices.map((String choice) {
              //                         return PopupMenuItem<String>(
              //                           value: choice,
              //                           child:
              //                           Row(
              //
              //                               children: [
              //                                 const Padding(
              //                                   padding: EdgeInsets.only(left:8.0,right: 10.0),
              //                                   // child: SvgPicture.asset(
              //                                   //   'assets/pie-chart.svg',
              //                                   //   color: AppColors.white,width: 20,height: 20,
              //                                   // ),
              //                                   child: Icon(Icons.circle_rounded, color: Colors.white,size: 10,),
              //
              //                                 ),
              //                                 Text(choice,style: TextStyle(
              //                                   color: Colors.white,
              //                                   fontWeight: FontWeight.w400,
              //                                   fontFamily: 'Poppins',
              //                                   fontSize: 12,
              //
              //                                 ),),
              //
              //                               ]
              //                           ),);
              //
              //                       }).toList();
              //                     },
              //                   ),
              //                 ],
              //               ),
              //               const Text(
              //                 'Suppliers',
              //                 style: TextStyle(
              //                   color: Colors.white,
              //                   fontWeight: FontWeight.w400,
              //                   fontFamily: 'Poppins',
              //                   fontSize: 12,
              //
              //                 ),
              //               ),
              //             ],
              //
              //
              //           ),
              //         ),
              //       );
              //     }
              //
              //     return Loading();
              //
              //     }
              // ),

              //Fournisseur


              //Fournisseurs
              Visibility(
                visible: (id_role != '02S3mJ118bXc5m3TY4ox' && id_role != 'r4GZTIH48qUXdEB698X6'),
                child: Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          // IconButton(
                          //     iconSize: 20,
                          //     padding: EdgeInsets.symmetric(vertical: 20.0),
                          //     icon: SvgPicture.asset(
                          //       'assets/stock.svg',
                          //       color: AppColors.white,
                          //     ),
                          //     onPressed: () {}),
                          Padding(
                            padding: const EdgeInsets.only(left: 40.0),
                            child: SvgPicture.asset(
                              'assets/supp.svg',
                              color: AppColors.white,
                              width: 20,
                              height: 20,
                            ),
                          ),
                          PopupMenuButton<String>(
                            offset: Offset(20, 0),
                            elevation: 8.0,
                            shape: const TooltipShape(),
                            color: hexSrtingToColor("00816D"),
                            icon: const Icon(Icons.arrow_right_outlined,
                                color: Colors.white),
                            onSelected: (choice) {
                              if (choice == suppliers.Item1) {
                                print('I Suppliers');
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => fournisseur(),
                                  ),
                                );
                              } else if (choice == suppliers.Item3) {
                                print('I Verses');
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => versF(),
                                  ),
                                );
                              }
                            },
                            itemBuilder: (BuildContext context) {
                              return  suppliers.choices.where((String choice) {
                                if (choice == "Fournisseurs" && (id_role != "EG1yYKPG9xIVV7esfKx0" && id_role != "PwGN49ZCMmobauCYxOJ9" )) {
                                  return false; // Ne pas afficher l'élément "categorie" si id_role n'est pas "respo vente"
                                }
                                if (choice == "Versements" && (id_role != "EG1yYKPG9xIVV7esfKx0" && id_role != "xOQOsiAUNsq6r1Qd5aH1" )) {

                                  return false; // Ne pas afficher l'élément "achat" si id_role n'est pas "respo achat"
                                }


                                return true; // Afficher tous les autres éléments
                              }).map((String choice) {
                                return PopupMenuItem<String>(
                                  value: choice,
                                  child: Row(children: [
                                    const Padding(
                                      padding: EdgeInsets.only(
                                          left: 8.0, right: 10.0),
                                      // child: SvgPicture.asset(
                                      //   'assets/pie-chart.svg',
                                      //   color: AppColors.white,width: 20,height: 20,
                                      // ),
                                      child: Icon(
                                        Icons.circle_rounded,
                                        color: Colors.white,
                                        size: 10,
                                      ),
                                    ),
                                    Text(
                                      choice,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w400,
                                        fontFamily: 'Poppins',
                                        fontSize: 12,
                                      ),
                                    ),
                                  ]),
                                );
                              }).toList();
                            },
                          ),
                        ],
                      ),
                      const Text(
                        'Fournisseurs',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Poppins',
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              //Clients
              Visibility(
                visible: (id_role != '02S3mJ118bXc5m3TY4ox' && id_role != 'r4GZTIH48qUXdEB698X6'),
                child: Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          // IconButton(
                          //     iconSize: 20,
                          //     padding: EdgeInsets.symmetric(vertical: 20.0),
                          //     icon: SvgPicture.asset(
                          //       'assets/stock.svg',
                          //       color: AppColors.white,
                          //     ),
                          //     onPressed: () {}),
                          Padding(
                            padding: const EdgeInsets.only(left: 40.0),
                            child: SvgPicture.asset(
                              'assets/fourn.svg',
                              color: AppColors.white,
                              width: 20,
                              height: 20,
                            ),
                          ),
                          PopupMenuButton<String>(
                            offset: Offset(20, 0),
                            elevation: 8.0,
                            shape: const TooltipShape(),
                            color: hexSrtingToColor("00816D"),
                            icon: const Icon(Icons.arrow_right_outlined,
                                color: Colors.white),
                            onSelected: (choice) {
                              if (choice == clients.Item1) {
                                print('I Client');
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => client(),
                                  ),
                                );
                              } else if (choice == clients.Item2) {
                                print('I paiementRecu');
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => paiementRecu(),
                                  ),
                                );
                              }
                              // else if (choice == clients.Item4) {
                              //   print('I Credits');
                              //   Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //       builder: (context) => ArticlesPage(),
                              //     ),
                              //   );
                              // }
                            },
                            itemBuilder: (BuildContext context) {
                              return clients.choices.where((String choice) {
                                if (choice == "Clients" && (id_role != "EG1yYKPG9xIVV7esfKx0" && id_role != "r4GZTIH48qUXdEB698X6" )) {
                                  return false; // Ne pas afficher l'élément "categorie" si id_role n'est pas "respo vente"
                                }
                                if (choice == "Paiement reçu" && (id_role != "EG1yYKPG9xIVV7esfKx0" && id_role != "xOQOsiAUNsq6r1Qd5aH1" )) {

                                  return false; // Ne pas afficher l'élément "achat" si id_role n'est pas "respo achat"
                                }


                                return true; // Afficher tous les autres éléments
                              }).map((String choice) {
                                return PopupMenuItem<String>(
                                  value: choice,
                                  child: Row(children: [
                                    const Padding(
                                      padding:
                                      EdgeInsets.only(left: 8.0, right: 10.0),
                                      // child: SvgPicture.asset(
                                      //   'assets/pie-chart.svg',
                                      //   color: AppColors.white,width: 20,height: 20,
                                      // ),
                                      child: Icon(
                                        Icons.circle_rounded,
                                        color: Colors.white,
                                        size: 10,
                                      ),
                                    ),
                                    Text(
                                      choice,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w400,
                                        fontFamily: 'Poppins',
                                        fontSize: 12,
                                      ),
                                    ),
                                  ]),
                                );
                              }).toList();
                            },
                          ),
                        ],
                      ),
                      const Text(
                        'Clients',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Poppins',
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              //Docs
              Visibility(
                visible: (id_role != '02S3mJ118bXc5m3TY4ox' && id_role != 'xOQOsiAUNsq6r1Qd5aH1'),

                child: Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          // IconButton(
                          //     iconSize: 20,
                          //     padding: EdgeInsets.symmetric(vertical: 20.0),
                          //     icon: SvgPicture.asset(
                          //       'assets/stock.svg',
                          //       color: AppColors.white,
                          //     ),
                          //     onPressed: () {}),
                          Padding(
                            padding: const EdgeInsets.only(left: 40.0),
                            child: SvgPicture.asset(
                              'assets/bcf.svg',
                              color: AppColors.white,
                              width: 20,
                              height: 20,
                            ),
                          ),
                          PopupMenuButton<String>(
                            offset: Offset(20, 0),
                            elevation: 8.0,
                            shape: const TooltipShape(),
                            color: hexSrtingToColor("00816D"),
                            icon: const Icon(Icons.arrow_right_outlined,
                                color: Colors.white),
                            onSelected: (choice) {
                              if (choice == POS.Item1) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => dmndPrix(),
                                  ),
                                );
                              } else if (choice == POS.Item2) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => bCommande(),
                                  ),
                                );
                              } else if (choice == POS.Item3) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => devis(),
                                  ),
                                );
                              } else if (choice == POS.Item4) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => BL(),
                                  ),
                                );
                              } else if (choice == POS.Item5) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => invoice(),
                                  ),
                                );
                              }
                            },
                            itemBuilder: (BuildContext context) {
                              return POS.choices.where((String choice) {
                                if (choice == "Demande de Prix" && (id_role != "EG1yYKPG9xIVV7esfKx0" && id_role != "PwGN49ZCMmobauCYxOJ9" )) {
                                  return false; // Ne pas afficher l'élément "categorie" si id_role n'est pas "respo vente"
                                }
                                if (choice == "Bon de Commande" && (id_role != "EG1yYKPG9xIVV7esfKx0" && id_role != "PwGN49ZCMmobauCYxOJ9" )) {

                                  return false; // Ne pas afficher l'élément "achat" si id_role n'est pas "respo achat"
                                }
                                if (choice == "Devis" && (id_role != "EG1yYKPG9xIVV7esfKx0" && id_role != "r4GZTIH48qUXdEB698X6" )) {

                                  return false; // Ne pas afficher l'élément "achat" si id_role n'est pas "respo achat"
                                }
                                if (choice == "Bon de Livraison" && (id_role != "EG1yYKPG9xIVV7esfKx0" && id_role != "r4GZTIH48qUXdEB698X6" )) {

                                  return false; // Ne pas afficher l'élément "achat" si id_role n'est pas "respo achat"
                                }
                                if (choice == "Facture" && (id_role != "EG1yYKPG9xIVV7esfKx0" && id_role != "PwGN49ZCMmobauCYxOJ9" )) {

                                  return false; // Ne pas afficher l'élément "achat" si id_role n'est pas "respo achat"
                                }


                                return true; // Afficher tous les autres éléments
                              }).map((String choice) {
                                return PopupMenuItem<String>(
                                  value: choice,
                                  child: Row(children: [
                                    const Padding(
                                      padding:
                                          EdgeInsets.only(left: 8.0, right: 10.0),
                                      // child: SvgPicture.asset(
                                      //   'assets/pie-chart.svg',
                                      //   color: AppColors.white,width: 20,height: 20,
                                      // ),
                                      child: Icon(
                                        Icons.circle_rounded,
                                        color: Colors.white,
                                        size: 10,
                                      ),
                                    ),
                                    Text(
                                      choice,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w400,
                                        fontFamily: 'Poppins',
                                        fontSize: 12,
                                      ),
                                    ),
                                  ]),
                                );
                              }).toList();
                            },
                          ),
                        ],
                      ),
                      const Text(
                        'Documents',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Poppins',
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ),


              //Livraison

              Visibility(
                visible: (id_role != 'xOQOsiAUNsq6r1Qd5aH1' && id_role != 'PwGN49ZCMmobauCYxOJ9'),

                child: Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          iconSize: 20,
                          icon: SvgPicture.asset(
                            'assets/return.svg',
                            color: AppColors.white,
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => livraison(),
                              ),
                            );
                          }),
                      const Text(
                        'Livraison',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Poppins',
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ),




              //Charges
              Visibility(
                visible: ( id_role == 'EG1yYKPG9xIVV7esfKx0' || id_role == 'xOQOsiAUNsq6r1Qd5aH1'),

                child: Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          // IconButton(
                          //     iconSize: 20,
                          //     padding: EdgeInsets.symmetric(vertical: 20.0),
                          //     icon: SvgPicture.asset(
                          //       'assets/stock.svg',
                          //       color: AppColors.white,
                          //     ),
                          //     onPressed: () {}),
                          Padding(
                            padding: const EdgeInsets.only(left: 40.0),
                            child: SvgPicture.asset(
                              'assets/charges.svg',
                              color: AppColors.white,
                              width: 20,
                              height: 20,
                            ),
                          ),
                          PopupMenuButton<String>(
                            offset: Offset(20, 0),
                            elevation: 8.0,
                            shape: const TooltipShape(),
                            color: hexSrtingToColor("00816D"),
                            icon: const Icon(Icons.arrow_right_outlined,
                                color: Colors.white),
                            onSelected: (choice) {
                              if (choice == charges.Item1) {
                                print('I typeCharges');
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => typeCharges(),
                                  ),
                                );
                              } else if (choice == charges.Item2) {
                                print('I addCharge');
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => addCharge(),
                                  ),
                                );
                              }
                            },
                            itemBuilder: (BuildContext context) {
                              return charges.choices.map((String choice) {
                                return PopupMenuItem<String>(
                                  value: choice,
                                  child: Row(children: [
                                    const Padding(
                                      padding:
                                          EdgeInsets.only(left: 8.0, right: 10.0),
                                      // child: SvgPicture.asset(
                                      //   'assets/pie-chart.svg',
                                      //   color: AppColors.white,width: 20,height: 20,
                                      // ),
                                      child: Icon(
                                        Icons.circle_rounded,
                                        color: Colors.white,
                                        size: 10,
                                      ),
                                    ),
                                    Text(
                                      choice,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w400,
                                        fontFamily: 'Poppins',
                                        fontSize: 12,
                                      ),
                                    ),
                                  ]),
                                );
                              }).toList();
                            },
                          ),
                        ],
                      ),
                      const Text(
                        'Charges',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Poppins',
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              //mvmt
              Visibility(
                visible: ( id_role == 'EG1yYKPG9xIVV7esfKx0' || id_role == 'xOQOsiAUNsq6r1Qd5aH1'),
                child: Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          iconSize: 20,
                          icon: SvgPicture.asset(
                            'assets/sumup.svg',
                            color: AppColors.white,
                          ),
                          onPressed: () {}),
                      const Text(
                        'Mouvements',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Poppins',
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              //users
              Visibility(
                visible: (id_role == 'EG1yYKPG9xIVV7esfKx0'),
                child: Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          iconSize: 20,
                          icon: SvgPicture.asset(
                            'assets/users.svg',
                            color: AppColors.white,
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => employees(),
                              ),
                            );
                          }),
                      const Text(
                        'Employés',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Poppins',
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.only(top:20.0),
              //   child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //     children: [
              //       Row(
              //         mainAxisAlignment: MainAxisAlignment.start,
              //         children: [
              //           // IconButton(
              //           //     iconSize: 20,
              //           //     padding: EdgeInsets.symmetric(vertical: 20.0),
              //           //     icon: SvgPicture.asset(
              //           //       'assets/stock.svg',
              //           //       color: AppColors.white,
              //           //     ),
              //           //     onPressed: () {}),
              //           Padding(
              //
              //             padding: const EdgeInsets.only(left: 40.0),
              //             child: SvgPicture.asset(
              //               'assets/users.svg',
              //               color: AppColors.white,width: 20,height: 20,
              //             ),
              //           ),
              //           PopupMenuButton<String>(
              //             offset: Offset(20, 0),
              //             elevation: 8.0,
              //             shape: const TooltipShape(),
              //             color: hexSrtingToColor("00816D"),
              //             icon: const Icon(Icons.arrow_right_outlined, color: Colors.white),
              //             onSelected: (choice){
              //               if (choice == users.Item1) {
              //                 print('Ajouter un employé');
              //                 Navigator.push(
              //                   context,
              //                   MaterialPageRoute(
              //                     builder: (context) => employees(),
              //                   ),
              //                 );
              //               } else if (choice == users.Item2) {
              //                 print('Afficher la liste des employes');
              //                 Navigator.push(
              //                   context,
              //                   MaterialPageRoute(
              //                     builder: (context) => listEmployees(),
              //                   ),
              //                 );
              //               }
              //             },
              //             itemBuilder: (BuildContext context) {
              //               return users.choices.map((String choice) {
              //                 return PopupMenuItem<String>(
              //                   value: choice,
              //                   child:
              //                   Row(
              //
              //                       children: [
              //                         const Padding(
              //                           padding: EdgeInsets.only(left:8.0,right: 10.0),
              //                           // child: SvgPicture.asset(
              //                           //   'assets/pie-chart.svg',
              //                           //   color: AppColors.white,width: 20,height: 20,
              //                           // ),
              //                           child: Icon(Icons.circle_rounded, color: Colors.white,size: 10,),
              //
              //                         ),
              //                         Text(choice,style: TextStyle(
              //                           color: Colors.white,
              //                           fontWeight: FontWeight.w400,
              //                           fontFamily: 'Poppins',
              //                           fontSize: 12,
              //
              //                         ),),
              //
              //                       ]
              //                   ),);
              //
              //               }).toList();
              //             },
              //           ),
              //         ],
              //       ),
              //       const Text(
              //         'Users',
              //         style: TextStyle(
              //           color: Colors.white,
              //           fontWeight: FontWeight.w400,
              //           fontFamily: 'Poppins',
              //           fontSize: 12,
              //
              //         ),
              //       ),
              //     ],
              //
              //
              //   ),
              // ),


// / reviews

              Visibility(
                visible: ( id_role == 'EG1yYKPG9xIVV7esfKx0'),
                child: Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          iconSize: 20,
                          icon: SvgPicture.asset(
                            'assets/avis.svg',
                            color: AppColors.white,
                          ),
                          onPressed: () {}),
                      const Text(
                        'Customer reviews',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Poppins',
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              //Infos
              Visibility(
                visible: ( id_role == 'EG1yYKPG9xIVV7esfKx0'),
                child: Padding(
                  padding: const EdgeInsets.only(top: 20.0, bottom: 200),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          iconSize: 20,
                          icon: SvgPicture.asset(
                            'assets/info.svg',
                            color: AppColors.white,
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BusinessCardUI(),
                              ),
                            );
                          }),
                      const Text(
                        'Informations',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Poppins',
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //   children: [
              //     IconButton(
              //         iconSize: 20,
              //         padding: EdgeInsets.symmetric(vertical: 20.0),
              //         icon: SvgPicture.asset(
              //           'assets/fourn.svg',
              //           color: AppColors.white,
              //         ),
              //         onPressed: () {}),
              //     const Text(
              //       'Suppliers',
              //       style: TextStyle(
              //         color: Colors.white,
              //         fontWeight: FontWeight.w400,
              //         fontFamily: 'Poppins',
              //         fontSize: 12,
              //
              //       ),
              //     ),
              //   ],
              //
              //
              // ),
              //
              //
              // IconButton(
              //     iconSize: 20,
              //     padding: EdgeInsets.symmetric(vertical: 20.0),
              //     icon: SvgPicture.asset(
              //       'assets/clipboard.svg',
              //       color: AppColors.white,
              //     ),
              //     onPressed: () {}),
            ],
          ),
        ),
      ),
    );
  }
}

class TooltipShape extends ShapeBorder {
  const TooltipShape();

  final BorderSide _side = BorderSide.none;
  final BorderRadiusGeometry _borderRadius = BorderRadius.zero;

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.all(_side.width);

  @override
  ShapeBorder scale(double t) => RoundedRectangleBorder(
      // side: _side.scale(t),
      // borderRadius: _borderRadius * t,
      );

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {
    // TODO: implement paint
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    final Path path = Path();
    final RRect rrect = _borderRadius.resolve(textDirection).toRRect(rect);

    // path.moveTo(20, 20);
    // path.lineTo(20, 60);
    // path.lineTo(-10, 40);
    // path.lineTo(20, 20);
    double x = 10;
    double y = 0;

    path.moveTo(x, y);
    path.lineTo(x, 40);
    path.lineTo(-10, (40 - y) / 2);
    path.lineTo(x, y);

    path.moveTo(0, 10);
    path.quadraticBezierTo(0, 0, 10, 0);

    path.lineTo(rrect.width - 10, 0);
    path.quadraticBezierTo(rrect.width, 0, rrect.width, 10);
    path.lineTo(rrect.width, rrect.height - 10);
    path.quadraticBezierTo(
        rrect.width, rrect.height, rrect.width - 10, rrect.height);
    path.lineTo(10, rrect.height);
    path.quadraticBezierTo(0, rrect.height, 0, rrect.height - 10);

    return path;
  }

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    final Path path = Path();

    path.addRRect(
      _borderRadius.resolve(textDirection).toRRect(rect).deflate(_side.width),
    );

    return path;
  }
}
