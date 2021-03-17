import 'package:beep/core/constants/assets.dart';
import 'package:beep/core/constants/dimens.dart';
import 'package:beep/core/constants/texts.dart';
import 'package:beep/core/router/app_router.dart';
import 'package:beep/shared/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeHeader extends StatelessWidget {
  final bool isCompany;
  final String companyName;

  HomeHeader({this.isCompany, this.companyName});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.size.width,
      padding: EdgeInsets.all(smallSize),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(extraHugeSize),
          bottomRight: Radius.circular(extraHugeSize)
        )
      ),
      child: Column(
        children: [
          Row(
            children: [
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100)
                ),
                margin: EdgeInsets.only(
                  right: smallSize
                ),
                child: Image.asset(
                  beepLogo,
                  width: hugeSize,
                  height: hugeSize,
                ),
              ),
              Expanded(
                child: Text(
                  '$companyHi$companyName$companyWelcome',
                  style: GoogleFonts.firaSans(
                    color: Colors.black,
                    fontSize: mediumTextSize
                  ),
                )
              ),
              SvgPicture.asset(
                logout,
                width: normalSize,
                height: normalSize,
              )
            ],
          ),
          _createInventorySection()
        ],
      ),
    );
  }

  Widget _createInventorySection() {
    return Container(
      margin: EdgeInsets.only(
        top: smallSize
      ),
      child: Column(
        children: [
          Text(
            companyStart,
            style: GoogleFonts.firaSans(
              color: Colors.black,
              fontSize: normalTextSize
            ),
          ),
          SizedBox(height: tinySize,),
          PrimaryButton(
            paddingHorizontal: largeSize,
            paddingVertical: tinySize,
            buttonText: companyCreateInventory,
            onPressedCallback: () => Get.find<AppRouter>().routeHomePageToRegisterInventoryPage(),
            shouldExpand: false,
          )
        ],
      ),
    );
  }
}
