import 'package:beep/core/constants/colors.dart';
import 'package:beep/core/constants/texts.dart';
import 'package:beep/core/constants/dimens.dart';
import 'package:beep/features/registercounting/domain/controller/register_counting_controller.dart';
import 'package:beep/shared/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class NotFoundProductSection extends StatelessWidget {
  final String productCode;

  NotFoundProductSection({this.productCode});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.size.width,
      child: Column(
        children: [
          InfoSection(),
          SizedBox(
            height: mediumSize,
          ),
          TryAgainButton()
        ],
      ),
    );
  }

  Widget InfoSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          registerCountingPageNotFoundProductMessageFirst,
          textAlign: TextAlign.center,
          style: GoogleFonts.firaSans(color: Colors.white, fontWeight: FontWeight.bold, fontSize: mediumTextSize),
        ),
        SizedBox(
          height: mediumSmallSize,
        ),
        Text(
          "$registerCountingPageNotFoundProductMessageFirst$productCode$registerCountingPageNotFoundProductMessageSecond",
          textAlign: TextAlign.center,
          style: GoogleFonts.firaSans(color: countingGray, fontSize: normalTextSize),
        )
      ],
    );
  }

  Widget TryAgainButton() {
    return PrimaryButton(
      buttonText: registerCountingPageTryAgain,
      shouldExpand: true,
      buttonColor: primaryColor,
      onPressedCallback: () => Get.find<RegisterCountingController>().resetNotFoundProduct(),
    );
  }
}
