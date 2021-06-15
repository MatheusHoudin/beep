import 'package:beep/core/constants/colors.dart';
import 'package:beep/core/constants/dimens.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class AppBarDetailsSection extends StatelessWidget {
  final String title;
  final Color backgroundColor;
  final Widget bottomSection;

  AppBarDetailsSection({this.title, this.bottomSection, this.backgroundColor = Colors.white});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.size.width,
      margin: EdgeInsets.only(bottom: mediumSmallSize),
      padding: EdgeInsets.symmetric(horizontal: smallSize, vertical: mediumSmallSize),
      color: backgroundColor,
      child: Column(
        children: [
          Text(
            title,
            style: GoogleFonts.firaSans(fontSize: normalTextSize, color: grayColor),
          ),
          SizedBox(
            height: mediumSmallSize,
          ),
          bottomSection
        ],
      ),
    );
  }
}
