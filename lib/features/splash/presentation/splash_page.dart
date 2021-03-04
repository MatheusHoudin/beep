import 'package:beep/core/constants/dimens.dart';
import 'package:beep/core/constants/texts.dart';
import 'package:beep/features/splash/domain/controller/splash_screen_controller.dart';
import 'package:beep/shared/widgets/custom_outlined_button.dart';
import 'package:beep/shared/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<SplashScreenController>(
        builder: (c) => Container(
          width: Get.width,
          height: Get.height,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(c.getBackgroundImageUrl()),
                  fit: BoxFit.cover)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: mediumSize),
                child: Text(
                  c.getInfo(),
                  textAlign: TextAlign.justify,
                  style: GoogleFonts.firaSans(
                      fontSize: largeTextSize,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
              SizedBox(
                height: largeSize,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: normalSize, vertical: mediumSize),
                child: Row(
                  children: [
                    Container(
                      child: SvgPicture.asset(c.getStepImageUrl()),
                      width: 50,
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Visibility(
                            child: CustomOutlinedButton(
                                buttonText: skip,
                                onPressedCallback: () => c.skip()),
                            visible: c.shouldShowSkipButton(),
                          ),
                          Visibility(
                            child: CustomOutlinedButton(
                                buttonText: back,
                                onPressedCallback: () => c.previousPage()),
                            visible: !c.shouldShowSkipButton(),
                          ),
                          SizedBox(
                            width: normalSize,
                          ),
                          PrimaryButton(
                              buttonText: continueButton,
                              onPressedCallback: () => c.nextPage(),
                              shouldExpand: false)
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
