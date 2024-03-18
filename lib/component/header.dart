import 'package:adminsignin/config/responsive.dart';
import 'package:adminsignin/style/colors.dart';
import 'package:adminsignin/style/style.dart';
import 'package:flutter/material.dart';

class Header extends StatelessWidget {
   String title="";
   String subtitle="";

  Header(String title,String subtitle){
    this.title=title;
    this.subtitle=subtitle;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
      SizedBox(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PrimaryText(
                  color: AppColors.them,
                  text: title,
                  size: 30,
                  fontWeight: FontWeight.w800),
              PrimaryText(
                text: subtitle,
                size: 16,
                fontWeight: FontWeight.w400,
                color: AppColors.secondary,
              )
            ]),
      ),
      Spacer(
        flex: 1,
      ),
      Expanded(
        flex: Responsive.isDesktop(context) ? 1 : 3,
        child: TextField(
          decoration: InputDecoration(
            filled: true,
            fillColor: AppColors.white,
            contentPadding:
                EdgeInsets.only(left: 40.0, right: 5),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(color: AppColors.them),
            ),
             focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(color: AppColors.them),
            ),
            prefixIcon: const Icon(Icons.search, color: AppColors.them),
            hintText: 'Search',
            hintStyle: const TextStyle(color: AppColors.them, fontSize: 14)
          ),
        ),
      ),
    ]);
  }
}
