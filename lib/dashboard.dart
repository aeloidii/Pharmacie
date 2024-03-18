import 'package:adminsignin/colorutils.dart';
import 'package:adminsignin/component/appBarActionItems.dart';
import 'package:adminsignin/component/barChart.dart';
import 'package:adminsignin/component/categorie.dart';
import 'package:adminsignin/component/header.dart';
import 'package:adminsignin/component/historyTable.dart';
import 'package:adminsignin/component/infoCard.dart';
import 'package:adminsignin/component/paymentDetailList.dart';
import 'package:adminsignin/component/sideMenu.dart';
import 'package:adminsignin/config/responsive.dart';
import 'package:adminsignin/config/size_config.dart';
import 'package:adminsignin/style/colors.dart';
import 'package:adminsignin/style/style.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:adminsignin/functions/functions.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'component/Clients.dart';
import 'component/article.dart';
import 'component/suppliers.dart';

class Dashboard extends StatefulWidget {
  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
String id_Role="-1";

// Future getDataFromDatabase() async {
//     await FirebaseFirestore.instance
//         .collection('employee')
//         .doc(FirebaseAuth.instance.currentUser!.uid)
//         .get()
//         .then((snapshot) async {
//       if (snapshot.exists) {
//         setState(() async {
//           id_Role = snapshot.data()!["id_roleEmpls"];
//           print("Role: $id_Role");
//         });
//       }
//       print("Role: $id_Role");
//     });
//   }








  int suppliersCount = -1;

  int clientsCount = -1;

  int articlesCount = -1;

  int categoriesCount = -1;

  Future<void> fetchData() async {

    suppliersCount = await getNumberOfDocuments("Fournisseurs","id_EtrpAddBy");
    clientsCount = await getNumberOfDocuments("Clients","id_EtrpAddBy");
    articlesCount = await getNumberOfDocuments("articles","id_EtrpC");
    categoriesCount = await getNumberOfDocuments("catégories","id_Etrp");
    print("work");
    await FirebaseFirestore.instance
        .collection('employee')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((snapshot) async {
      if (snapshot.exists) {
        setState(()  {
          id_Role = snapshot.data()!["id_roleEmpls"];
          print("Role: $id_Role");
        });
      }
      print("Role: $id_Role");
    });

    setState(() {});
  }
  @override
  void initState() {
    super.initState();
    fetchData();

  }
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      key: _drawerKey,
      drawer: SizedBox(width: 110, child: SideMenu()),
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
                width: 108,
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
                        Header('Dashboard','Mises à jour des paiements'),
                        SizedBox(
                          height: SizeConfig.blockSizeVertical * 4,
                        ),
                        id_Role=="EG1yYKPG9xIVV7esfKx0" ? SizedBox(
                          width: SizeConfig.screenWidth,
                          child: Wrap(
                            spacing: 20,
                            runSpacing: 20,
                            alignment: WrapAlignment.spaceBetween,
                            children: [
                              InfoCard(
                                  icon: 'assets/supp.svg',
                                  label: 'Fournisseurs',
                              amount: suppliersCount==-1 ? "En cours..." : suppliersCount.toString()
,
                              createPage: () => fournisseur(),
                              ),
                              InfoCard(
                                  icon: 'assets/fourn.svg',
                                  label: 'Clients',
                                amount: clientsCount==-1 ? "En cours..." : clientsCount.toString()

                                ,
                                createPage: () => client(),

                              ),
                              InfoCard(
                                  icon: 'assets/bcf.svg',
                                  label: 'Articles',
                                  amount: articlesCount==-1 ? "En cours..." : articlesCount.toString()
                                ,
                                createPage: () => ArticlesPage(),

                              ),
                              InfoCard(
                                  icon: 'assets/catg.svg',
                                  label: 'Categories',
                                amount: categoriesCount==-1 ? "En cours..." : categoriesCount.toString()

                                ,
                                createPage: () => CategoriePage(),
                              ),
                            ],
                          ),
                        ) : Text(""),
                        SizedBox(
                          height: SizeConfig.blockSizeVertical * 4,
                        ),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //   crossAxisAlignment: CrossAxisAlignment.center,
                        //   children: [
                        //     Column(
                        //       crossAxisAlignment: CrossAxisAlignment.start,
                        //       children: const [
                        //         PrimaryText(
                        //           text: 'Average',
                        //           size: 16,
                        //           fontWeight: FontWeight.w400,
                        //           color: AppColors.secondary,
                        //         ),
                        //         PrimaryText(
                        //           color: AppColors.them,
                        //             text: '\$X',
                        //             size: 30,
                        //             fontWeight: FontWeight.w800),
                        //       ],
                        //     ),
                        //     const PrimaryText(
                        //       text: 'Sales',
                        //       size: 16,
                        //       fontWeight: FontWeight.w400,
                        //       color: AppColors.secondary,
                        //     ),
                        //   ],
                        // ),
                        SizedBox(
                          height: SizeConfig.blockSizeVertical * 3,
                        ),
                        // Container(
                        //   height: 180,
                        //   child: BarChartCopmponent(),
                        // ),
                        SizedBox(
                          height: SizeConfig.blockSizeVertical * 5,
                        ),
                        id_Role=="EG1yYKPG9xIVV7esfKx0" ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            PrimaryText(
                                text: 'Historique',
                                color: AppColors.them,
                                size: 30,
                                fontWeight: FontWeight.w800),
                            PrimaryText(
                              text: 'Recent',
                              size: 16,
                              fontWeight: FontWeight.w400,
                              color: AppColors.secondary,
                            ),
                          ],
                        ) : Text(""),
                        SizedBox(
                          height: SizeConfig.blockSizeVertical * 3,
                        ),
                        id_Role=="EG1yYKPG9xIVV7esfKx0" ? HistoryTable() : Text(""),
                        if (!Responsive.isDesktop(context)) PaymentDetailList()
                      ],
                    ),
                  ),
                )),
            if (Responsive.isDesktop(context))
              Expanded(
                flex: 4,
                child: SafeArea(
                  child: Container(
                    width: double.infinity,
                    height: SizeConfig.screenHeight,
                    decoration: BoxDecoration(color: AppColors.secondaryBg),
                    child: SingleChildScrollView(
                      padding:
                          EdgeInsets.symmetric(vertical: 30, horizontal: 30),
                      child: Column(
                        children: [
                          AppBarActionItems(),
                          id_Role=="EG1yYKPG9xIVV7esfKx0" ? PaymentDetailList() : Text(""),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
