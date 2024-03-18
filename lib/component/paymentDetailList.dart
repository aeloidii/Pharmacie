import 'package:adminsignin/component/paymentListTile.dart';
import 'package:adminsignin/component/paymentListstock.dart';
import 'package:adminsignin/component/paylistilecredit.dart';
import 'package:adminsignin/config/size_config.dart';
import 'package:adminsignin/data.dart';
import 'package:adminsignin/style/colors.dart';
import 'package:adminsignin/style/style.dart';
import 'package:flutter/material.dart';
import 'package:adminsignin/functions/functions.dart';

class PaymentDetailList extends StatefulWidget {


  @override
  State<PaymentDetailList> createState() => _PaymentDetailListState();
}

class _PaymentDetailListState extends State<PaymentDetailList> {
  List<Map<String, dynamic>> unpaidChargesList = [];
  List<Map<String, dynamic>> getstockLeftList = [];
  List<Map<String, dynamic>> getUnpaidVenteListe = [];
  List<Map<String, dynamic>> getUnpaidAchatListe = [];
String done="no";

  Future<void> fetchData() async {
    unpaidChargesList= await getUnpaidCharges();
    getstockLeftList= await getstockLeft();
    getUnpaidVenteListe= await getUnpaidVente();
    getUnpaidAchatListe= await getUnpaidAchat();




    setState(() {
      done="yes";
    });
  }

  void initState() {
    super.initState();
    fetchData();
  }


  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      SizedBox(
        height: SizeConfig.blockSizeVertical * 5,
      ),
      // Container(
      //   decoration:
      //       BoxDecoration(borderRadius: BorderRadius.circular(30), boxShadow: [
      //     BoxShadow(
      //       color: Colors.grey[400]!,
      //       blurRadius: 15.0,
      //       offset: const Offset(
      //         10.0,
      //         15.0,
      //       ),
      //     )
      //   ]),
      //   child: Image.asset('assets/card.png'),
      // ),
      SizedBox(
        height: SizeConfig.blockSizeVertical * 5,
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PrimaryText(
              text: 'Paiements à venir', size: 18, fontWeight: FontWeight.w800, color: AppColors.them,),
          PrimaryText(
            text: 'Charges',
            size: 14,
            fontWeight: FontWeight.w400,
            color: AppColors.secondary,
          ),
        ],
      ),
      SizedBox(
        height: SizeConfig.blockSizeVertical * 2,
      ),
      done == "no" ? Text("En cours .. ") : Column(
        children: List.generate(
          unpaidChargesList.length,
          (index) => PaymentListTile(
              icon: unpaidChargesList[index]["icon"]!,
              label: unpaidChargesList[index]["label"]!,
              amount: "${unpaidChargesList[index]["amount"]!} DH"),
        ),
      ),


      SizedBox(
        height: SizeConfig.blockSizeVertical * 5,
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PrimaryText(
            text: 'Stock', size: 18, fontWeight: FontWeight.w800, color: AppColors.them,),
          PrimaryText(
            text: 'Articles',
            size: 14,
            fontWeight: FontWeight.w400,
            color: AppColors.secondary,
          ),

        ],
      ),
      SizedBox(
        height: SizeConfig.blockSizeVertical * 2,
      ),
      done == "no" ? Text("En cours .. ") : Column(
        children: List.generate(
          getstockLeftList.length,
              (index) => PaymentListTilestock(
            icon: 'assets/empty.svg',
            label: getstockLeftList[index]["label"]!,
            amount: getstockLeftList[index]["qtt"]!,
            descr: getstockLeftList[index]["sousLabel"]!,
          ),
        ),
      ),


      SizedBox(
        height: SizeConfig.blockSizeVertical * 5,
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PrimaryText(
              text: 'Paiement non reçu', size: 18, fontWeight: FontWeight.w800, color: AppColors.them,),
          PrimaryText(
            text: 'Clients',
            size: 14,
            fontWeight: FontWeight.w400,
            color: AppColors.secondary,
          ),

        ],
      ),
      SizedBox(
        height: SizeConfig.blockSizeVertical * 2,
      ),
      done == "no" ? Text("En cours .. ") : Column(
        children: List.generate(
          getUnpaidVenteListe.length,
          (index) => PaymentListTileCred(
              icon: getUnpaidVenteListe[index]["icon"]!,
              label: getUnpaidVenteListe[index]["label"]!,
              amount: getUnpaidVenteListe[index]["amount"]!,
            descr: getUnpaidVenteListe[index]["descr"]!,
          ),
        ),
      ),

      SizedBox(
        height: SizeConfig.blockSizeVertical * 5,
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PrimaryText(
            text: 'Crédits', size: 18, fontWeight: FontWeight.w800, color: AppColors.them,),
          PrimaryText(
            text: 'Fournisseur',
            size: 14,
            fontWeight: FontWeight.w400,
            color: AppColors.secondary,
          ),

        ],
      ),
      SizedBox(
        height: SizeConfig.blockSizeVertical * 2,
      ),
      done == "no" ? Text("En cours .. ") : Column(
        children: List.generate(
          getUnpaidAchatListe.length,
              (index) => PaymentListTileCred(
            icon: getUnpaidAchatListe[index]["icon"]!,
            label: getUnpaidAchatListe[index]["label"]!,
            amount: getUnpaidAchatListe[index]["amount"]!,
            descr: getUnpaidAchatListe[index]["descr"]!,
          ),
        ),
      ),






    ]);
  }
}
