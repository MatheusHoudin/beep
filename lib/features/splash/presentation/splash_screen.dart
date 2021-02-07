import 'package:beep/core/constants/assets.dart';
import 'package:beep/core/constants/dimens.dart';
import 'package:beep/core/constants/texts.dart';
import 'package:beep/shared/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: Get.width,
        height: Get.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(splashFirstBackground),
            fit: BoxFit.cover
          )
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: mediumSize
              ),
              child: Text(
                splashFirstText,
                textAlign: TextAlign.justify,
                style: GoogleFonts.firaSans(
                  fontSize: largeTextSize,
                  fontWeight: FontWeight.bold,
                  color: Colors.white
                ),
              ),
            ),
            SizedBox(height: 50,),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: normalSize,
                vertical: mediumSize
              ),
              child: Row(
                children: [
                  Container(
                    child: SvgPicture.asset(stepsFirst),
                    width: 50,
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        PrimaryButton(buttonText: "PULAR", onPressedCallback: () => null,),
                        SizedBox(width: normalSize,),
                        PrimaryButton(buttonText: "AVANÇAR", onPressedCallback: () => null)
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
