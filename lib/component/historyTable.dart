//
//
//
// import 'package:adminsignin/config/responsive.dart';
// import 'package:adminsignin/config/size_config.dart';
// import 'package:adminsignin/data.dart';
// import 'package:adminsignin/style/colors.dart';
// import 'package:adminsignin/style/style.dart';
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
//
// class HistoryTable extends StatefulWidget {
//   @override
//   _HistoryTableState createState() => _HistoryTableState();
// }
//
// class _HistoryTableState extends State<HistoryTable> {
//   List<Map<String, dynamic>> transactionHistory = [];
//
//   @override
//   void initState() {
//     super.initState();
//     fetchData();
//   }
//
//
//   // void sortTransactionHistory() {
//   //   transactionHistory.sort((a, b) => a["dateAjout"].compareTo(b["dateAjout"]));
//   // }
//   void sortTransactionHistory() {
//     transactionHistory.sort((a, b) => b["dateAjout"].compareTo(a["dateAjout"]));
//   }
//
//
//
//   Future<void> fetchData() async {
//     try {
//       QuerySnapshot querySnapshot = await FirebaseFirestore.instance
//           .collection("historique")
//           .get();
//
//       setState(() {
//         transactionHistory = querySnapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
//       });
//       sortTransactionHistory();
//     } catch (error) {
//       print("Une erreur s'est produite lors de la récupération des données : $error");
//     }
//   }
//
//   Future<String> getEmployeeName(String employeeId, String Field) async {
//     try {
//       DocumentSnapshot docSnapshot = await FirebaseFirestore.instance
//           .collection("employee")
//           .doc(employeeId)
//           .get();
//
//       if (docSnapshot.exists) {
//         return (docSnapshot.data() as Map<String, dynamic>)[Field] ?? "";
//       } else {
//         return "";
//       }
//     } catch (error) {
//       print("Une erreur s'est produite lors de la récupération des données de l'employé : $error");
//       return "";
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       scrollDirection: Responsive.isDesktop(context) ? Axis.vertical : Axis.horizontal,
//       child: SizedBox(
//         width: Responsive.isDesktop(context) ? double.infinity : SizeConfig.screenWidth,
//         child: Table(
//           defaultVerticalAlignment: TableCellVerticalAlignment.middle,
//           children: List.generate(
//             transactionHistory.length,
//                 (index) => TableRow(
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               children: [
//                 FutureBuilder<String>(
//                   future: getEmployeeName(transactionHistory[index]["id_employe"],"ImagePath"),
//                   builder: (context, snapshot) {
//                     if (snapshot.connectionState == ConnectionState.waiting) {
//                       return CircularProgressIndicator();
//                     } else if (snapshot.hasError) {
//                       return Text('Erreur : ${snapshot.error}');
//                     } else {
//                       String ImagePath = snapshot.data ?? "";
//                       return Container(
//                         alignment: Alignment.centerLeft,
//                         padding: const EdgeInsets.only(top: 10.0, bottom: 10.0, left: 20.0),
//                         child: CircleAvatar(
//                           radius: 17,
//                           backgroundImage: NetworkImage(ImagePath),
//                         ),
//                       );
//                     }
//                   },
//                 ),
//                 FutureBuilder<String>(
//                   future: getEmployeeName(transactionHistory[index]["id_employe"],"nom"),
//                   builder: (context, snapshot) {
//                     if (snapshot.connectionState == ConnectionState.waiting) {
//                       return CircularProgressIndicator();
//                     } else if (snapshot.hasError) {
//                       return Text('Erreur : ${snapshot.error}');
//                     } else {
//                       String employeeName = snapshot.data ?? "";
//                       return PrimaryText(
//                         text: employeeName,
//                         size: 16,
//                         fontWeight: FontWeight.w400,
//                         color: AppColors.secondary,
//                       );
//                     }
//                   },
//                 ),
//                 PrimaryText(
//                   text: transactionHistory[index]["dateAjout"],
//                   size: 16,
//                   fontWeight: FontWeight.w400,
//                   color: AppColors.secondary,
//                 ),
//                 Center(
//                   child: PrimaryText(
//                     text: transactionHistory[index]["action"],
//                     size: 16,
//                     fontWeight: FontWeight.w400,
//                     color: AppColors.secondary,
//                   ),
//                 ),
//
//
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }



import 'package:adminsignin/config/responsive.dart';
import 'package:adminsignin/config/size_config.dart';
import 'package:adminsignin/data.dart';
import 'package:adminsignin/style/colors.dart';
import 'package:adminsignin/style/style.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

enum DateFilter {
  Day,
  Month,
  Year,
  All,
}

class HistoryTable extends StatefulWidget {
  @override
  _HistoryTableState createState() => _HistoryTableState();
}

class _HistoryTableState extends State<HistoryTable> {
  List<Map<String, dynamic>> transactionHistory = [];
  DateFilter selectedFilter = DateFilter.All;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void sortTransactionHistory() {
    transactionHistory.sort((a, b) => b["dateAjout"].compareTo(a["dateAjout"]));
  }

  Future<void> fetchData() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection("historique")
          .get();

      setState(() {
        transactionHistory = querySnapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
      });
      sortTransactionHistory();
    } catch (error) {
      print("Une erreur s'est produite lors de la récupération des données : $error");
    }
  }

  Future<String> getEmployeeName(String employeeId, String Field) async {
    try {
      DocumentSnapshot docSnapshot = await FirebaseFirestore.instance
          .collection("employee")
          .doc(employeeId)
          .get();

      if (docSnapshot.exists) {
        return (docSnapshot.data() as Map<String, dynamic>)[Field] ?? "";
      } else {
        return "";
      }
    } catch (error) {
      print("Une erreur s'est produite lors de la récupération des données de l'employé : $error");
      return "";
    }
  }

  void filterTransactions() {
    List<Map<String, dynamic>> filteredList = [];

    // Filtrer les transactions en fonction du filtre sélectionné
    if (selectedFilter == DateFilter.Day) {
      DateTime currentDate = DateTime.now();
      filteredList = transactionHistory.where((transaction) {
        DateTime dateAjout = DateTime.parse(transaction["dateAjout"].substring(0, 10));
        return dateAjout.year == currentDate.year && dateAjout.month == currentDate.month && dateAjout.day == currentDate.day;
      }).toList();
    } else if (selectedFilter == DateFilter.Month) {
      DateTime currentDate = DateTime.now();
      filteredList = transactionHistory.where((transaction) {
        DateTime dateAjout = DateTime.parse(transaction["dateAjout"].substring(0, 10));
        return dateAjout.year == currentDate.year && dateAjout.month == currentDate.month;
      }).toList();
    } else if (selectedFilter == DateFilter.Year) {
      DateTime currentDate = DateTime.now();
      filteredList = transactionHistory.where((transaction) {
        DateTime dateAjout = DateTime.parse(transaction["dateAjout"].substring(0, 10));
        return dateAjout.year == currentDate.year;
      }).toList();
    } else {
      filteredList = transactionHistory;
    }

    setState(() {
      transactionHistory = filteredList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Radio(
              value: DateFilter.Day,
              groupValue: selectedFilter,
              onChanged: (value) {
                setState(() {
                  selectedFilter = value as DateFilter;
                });
                filterTransactions();
              },
            ),
            Text("Aujourd'hui"),
            Radio(
              value: DateFilter.Month,
              groupValue: selectedFilter,
              onChanged: (value) {
                setState(() {
                  selectedFilter = value as DateFilter;
                });
                filterTransactions();
              },
            ),
            Text("Ce mois"),
            Radio(
              value: DateFilter.Year,
              groupValue: selectedFilter,
              onChanged: (value) {
                setState(() {
                  selectedFilter = value as DateFilter;
                });
                filterTransactions();
              },
            ),
            Text("Cette année"),
            Radio(
              value: DateFilter.All,
              groupValue: selectedFilter,
              onChanged: (value) {
                setState(() {
                  selectedFilter = value as DateFilter;
                });
                filterTransactions();
              },
            ),
            Text("Tous"),
          ],
        ),
        SizedBox(height: 20),
        SingleChildScrollView(
          scrollDirection: Responsive.isDesktop(context) ? Axis.vertical : Axis.horizontal,
          child: SizedBox(
            width: Responsive.isDesktop(context) ? double.infinity : SizeConfig.screenWidth,
            child: Table(
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              children: List.generate(
                transactionHistory.length,
                    (index) => TableRow(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  children: [
                    FutureBuilder<String>(
                      future: getEmployeeName(transactionHistory[index]["id_employe"], "ImagePath"),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        } else if (snapshot.hasError) {
                          return Text('Erreur : ${snapshot.error}');
                        } else {
                          String ImagePath = snapshot.data ?? "";
                          return Container(
                            alignment: Alignment.centerLeft,
                            padding: const EdgeInsets.only(top: 10.0, bottom: 10.0, left: 20.0),
                            child: CircleAvatar(
                              radius: 17,
                              backgroundImage: NetworkImage(ImagePath),
                            ),
                          );
                        }
                      },
                    ),
                    FutureBuilder<String>(
                      future: getEmployeeName(transactionHistory[index]["id_employe"], "nom"),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        } else if (snapshot.hasError) {
                          return Text('Erreur : ${snapshot.error}');
                        } else {
                          String employeeName = snapshot.data ?? "";
                          return PrimaryText(
                            text: employeeName,
                            size: 16,
                            fontWeight: FontWeight.w400,
                            color: AppColors.secondary,
                          );
                        }
                      },
                    ),
                    PrimaryText(
                      text: transactionHistory[index]["dateAjout"],
                      size: 16,
                      fontWeight: FontWeight.w400,
                      color: AppColors.secondary,
                    ),
                    Center(
                      child: PrimaryText(
                        text: transactionHistory[index]["action"],
                        size: 16,
                        fontWeight: FontWeight.w400,
                        color: AppColors.secondary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
