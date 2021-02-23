import 'package:beep/core/constants/dimens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomAppBar extends StatelessWidget {
  final String appBarTitle;
  final bool hasIcon;
  final String icon;

  CustomAppBar({this.appBarTitle, this.hasIcon, this.icon = ""});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: hugeSize,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: smallSize,
          vertical: mediumSmallSize
        ),
        child: Stack(
          alignment: Alignment.centerRight,
          children: [
            Container(
              alignment: Alignment.centerLeft,
              child: GestureDetector(
                onTap: () => Get.back(),
                child: Icon(
                  Icons.arrow_back_ios_outlined,
                  color: Colors.white,
                ),
              ),
            ),
            Container(
              width: Get.size.width,
              alignment: Alignment.center,
              child: Text(
                appBarTitle,
                textAlign: TextAlign.center,
                style: GoogleFonts.firaSans(
                  color: Colors.white,
                  fontWeight: FontWeight.bold
                ),
              ),
            ),
            Visibility(
              visible: hasIcon,
              child: Container(
                width: normalSize,
                height: normalSize,
                child: SvgPicture.asset(icon),
              ),
            )
          ],
        ),
      ),
    );
  }
}
