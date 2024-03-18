import 'dart:math';

import 'package:adminsignin/Model/Models.dart';
import 'package:adminsignin/config/responsive.dart';
import 'package:adminsignin/provider/villeProvider.dart';
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
import 'package:provider/provider.dart';
import '../component/subMenu.dart';

class listEmployees extends StatefulWidget {
  listEmployees({super.key});

  @override
  State<listEmployees> createState() => _listEmployeesState();
}

class _listEmployeesState extends State<listEmployees> {
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

  final DataTableSource MyDataTable= MyData();
   String EntrpNom="";


  // Future getFeatureData()  async {
  //   List<roleEmpModel> newList = [];
  //   QuerySnapshot featureSnapShot = await FirebaseFirestore.instance
  //       .collection("roleEmpls").get();
  //   featureSnapShot.docs.forEach(
  //         (element) {
  //       dataville = roleEmpModel(
  //           id: element["id_roleEmpls"],
  //           designation: element["désignation"]);
  //       newList.add(dataville);
  //     },
  //   );
  //
  //   feature=newList;
  //   feature.sort((a, b) {
  //     return a.DESIGNATION.toLowerCase().compareTo(b.DESIGNATION.toLowerCase());
  //   });
  //
  // }

  Future getDataFromDatabase() async{
    await FirebaseFirestore.instance.collection('employee').doc(FirebaseAuth.instance.currentUser!.uid).get().then((snapshot) async{
      if(snapshot.exists){
        setState(() async {
          String idEntrp =snapshot.data()!["id_Etrp"];
          // id_entr=idEntrp;
          await FirebaseFirestore.instance.collection('infoEntrp').doc(idEntrp).get().then((snapshot) async{
            if(snapshot.exists){
              setState((){
                EntrpNom =snapshot.data()!["désignation"];
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

    // getFeatureData();
    getDataFromDatabase();
  }

  // Future<List<OrderModel>> getAllOrders() async =>
  //     firebaseFiretore.collection(collection).get().then((result) {
  //       List<OrderModel> orders = [];
  //       for (DocumentSnapshot order in result.docs) {
  //         orders.add(OrderModel.fromSnapshot(order));
  //       }
  //       return orders;
  //     });

  // String path="https://cdn-icons-png.flaticon.com/512/1560/1560896.png";
  // late final image = NetworkImage(path);

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
                        Header('Utilisateurs', 'Liste des employés'),
                        SizedBox(
                          height: 100,
                        ),
                        (!Responsive.isDesktop(context))
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                          children: [

                            SizedBox(
                              width: double.infinity,
                              child: PaginatedDataTable(columns: [
                                DataColumn(label: Text("ID")),
                                DataColumn(label: Text("Name")),
                                DataColumn(label: Text("Price")),


                              ], source: MyDataTable, header:  Center(child: PrimaryText(
                                text: 'LISTE DES EMPLOYES DE LA ${EntrpNom.toUpperCase()}', size: 18, fontWeight: FontWeight.w800, color: AppColors.them,)), horizontalMargin: 60,rowsPerPage: 8,),
                            )

                          ],)
                            : Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [

                                  SizedBox(
                                    width: double.infinity,
                                    child: PaginatedDataTable(columns: [
                                      DataColumn(label: Text("ID")),
                                      DataColumn(label: Text("Name")),
                                      DataColumn(label: Text("Price")),


                                    ], source: MyDataTable, header:  Center(child: PrimaryText(
                                      text: 'LISTE DES EMPLOYES DE LA ${EntrpNom.toUpperCase()}', size: 18, fontWeight: FontWeight.w800, color: AppColors.them,)), horizontalMargin: 60,rowsPerPage: 8,),
                                  )

                                ],
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

class MyData extends DataTableSource {
  //Creating our data source: (for now its just static we generate some data , then if every thing works well we well return to firebase)

  final List<Map<String, dynamic>> _data = List.generate(
      200,
      (index) => {
            "id": index,
            "title": "Item $index",
            "price": Random().nextInt(10000),
          });

  @override
  DataRow? getRow(int index) {
    return DataRow(cells: [
      DataCell(Text(_data[index]['id'].toString())),
      DataCell(Text(_data[index]['title'])),
      DataCell(Text(_data[index]['price'].toString())),
    ]);
  }

  @override
  // TODO: implement isRowCountApproximate
  bool get isRowCountApproximate => false;

  @override
  // TODO: implement rowCount
  int get rowCount => _data.length;

  @override
  // TODO: implement selectedRowCount
  int get selectedRowCount => 0;
}
