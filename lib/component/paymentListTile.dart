import 'package:adminsignin/style/colors.dart';
import 'package:adminsignin/style/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class PaymentListTile extends StatelessWidget {
  final String icon;
  final String label;
  final String amount;

  const PaymentListTile({
    required this.icon, required this.label, required this.amount
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.only(left: 0, right: 20),
      visualDensity: VisualDensity.standard,
      leading: Container(
          width: 50,
          padding: EdgeInsets.symmetric(
              vertical: 15, horizontal: 10),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: SvgPicture.asset(
            color: AppColors.them,
            icon,
            width: 20,
          )),
      title: PrimaryText(
          text: label,
          size: 14,
          fontWeight: FontWeight.w500),
      subtitle: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          PrimaryText(
            text: 'Non payé',
            size: 12,
            fontWeight: FontWeight.w400,
            color: Colors.red,
          ),
          PrimaryText(
          text: amount,
          size: 16,
          fontWeight: FontWeight.w600),
        ],
      ),
      onTap: () {
        print('tap');
      },
      selected: true,
    );
  }
}
