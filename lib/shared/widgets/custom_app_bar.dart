import 'package:beep/core/constants/colors.dart';
import 'package:beep/core/constants/dimens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomAppBar extends StatelessWidget {
  final String appBarTitle;
  final bool hasIcon, isWhiteStyle, isCountingHeader;
  final String icon;
  final Function onBackPressed;

  CustomAppBar(
      {this.appBarTitle,
      this.hasIcon,
      this.icon = "",
      this.isWhiteStyle = false,
      this.onBackPressed,
      this.isCountingHeader = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: hugeSize,
      color: isWhiteStyle ? Colors.white : secondaryColor,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: smallSize,
        ),
        child: Stack(
          alignment: Alignment.centerRight,
          children: [
            Container(
              alignment: Alignment.centerLeft,
              child: GestureDetector(
                onTap: () {
                  Get.back();
                  if (onBackPressed != null) onBackPressed();
                },
                child: Icon(
                  Icons.arrow_back_ios_outlined,
                  color: isCountingHeader ? primaryColor : (isWhiteStyle ? primaryColor : Colors.white),
                ),
              ),
            ),
            Container(
              width: Get.size.width,
              padding: EdgeInsets.symmetric(horizontal: largeSize),
              alignment: Alignment.center,
              child: Text(
                appBarTitle,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: GoogleFonts.firaSans(
                    color: isWhiteStyle ? secondaryColor : Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: isCountingHeader ? mediumTextSize : normalTextSize),
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
