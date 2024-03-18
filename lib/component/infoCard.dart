import 'package:adminsignin/config/responsive.dart';
import 'package:adminsignin/config/size_config.dart';
import 'package:adminsignin/style/colors.dart';
import 'package:adminsignin/style/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class InfoCard extends StatelessWidget {
  final String icon;
  final String label;
  final String amount;
  final  Widget Function() createPage; //This code creates a function that returns a Widget. This function does not have a name, as it is not assigned to a variable. It is used to create a page, which can be called later when needed.

  InfoCard({required this.icon, required this.label, required this.amount, required this.createPage});

  @override
  Widget build(BuildContext context) {
    return InkWell(
     borderRadius: BorderRadius.circular(20),
      hoverColor: AppColors.them,
      child: Container(

        constraints: BoxConstraints(minWidth: Responsive.isDesktop(context) ? 200 : SizeConfig.screenWidth/2 - 40),
          padding: EdgeInsets.only(
              top: 20, bottom: 20, left: 20, right: Responsive.isMobile(context) ? 20 : 40),

        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),

            color: AppColors.white,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SvgPicture.asset(icon, color: AppColors.them,
                  width: 35),
              SizedBox(
                height: SizeConfig.blockSizeVertical * 2,
              ),
              PrimaryText(
                  text: label,
                  color: AppColors.secondary,
                  size: 16),
              SizedBox(
                height: SizeConfig.blockSizeVertical * 2,
              ),
              PrimaryText(
                text: amount,
                size: 18,
                color: AppColors.them,
                fontWeight: FontWeight.w700,
              )
            ],
          ),),
      onTap: () {
        print("moving to "+createPage().toString());
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => createPage(),
          ),
        );
      },
    );
  }
}