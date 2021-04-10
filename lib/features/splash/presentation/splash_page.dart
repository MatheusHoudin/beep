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

  final PageController pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<SplashScreenController>(
        builder: (c) => Stack(
          fit: StackFit.expand,
          children: [
            OnboardingViewPager(c),
            Positioned(
              bottom: 0,
              child: BottomSection(c),
            )
          ],
        )
      ),
    );
  }

  Widget OnboardingViewPager(SplashScreenController c) {
    return PageView(
      scrollDirection: Axis.horizontal,
      onPageChanged: (page) => c.updatePage(page),
      controller: pageController,
      children: [
        OnboardingPage(c.getBackgroundImageUrl(0), c.getInfo(0)),
        OnboardingPage(c.getBackgroundImageUrl(1), c.getInfo(1)),
        OnboardingPage(c.getBackgroundImageUrl(2), c.getInfo(2))
      ],
    );
  }

  Widget OnboardingPage(String backgroundImageUrl, String text) {
    return Container(
      width: Get.size.width,
      height: Get.size.height,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(backgroundImageUrl),
          fit: BoxFit.cover
        )
      ),
      alignment: Alignment.bottomCenter,
      child: Container(
        margin: EdgeInsets.only(
          bottom: Get.size.height * 0.15
        ),
        padding: EdgeInsets.symmetric(horizontal: mediumSize),
        child: Text(
          text,
          textAlign: TextAlign.justify,
          style: GoogleFonts.firaSans(
              fontSize: largeTextSize,
              fontWeight: FontWeight.bold,
              color: Colors.white),
        ),
      ),
    );
  }

  Widget BottomSection(SplashScreenController c) {
    return Container(
      height: Get.size.height * 0.15,
      width: Get.size.width,
      padding: EdgeInsets.symmetric(
        horizontal: normalSize,
        vertical: mediumSize
      ),
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
                    onPressedCallback: () => c.skip()
                  ),
                  visible: c.shouldShowSkipButton(),
                ),
                Visibility(
                  child: CustomOutlinedButton(
                    buttonText: back,
                    onPressedCallback: () {
                      c.previousPage();
                      _updatePage(c.getCurrentPage());
                    }
                  ),
                  visible: !c.shouldShowSkipButton(),
                ),
                SizedBox(
                  width: normalSize,
                ),
                PrimaryButton(
                  buttonText: continueButton,
                  onPressedCallback: () {
                    c.nextPage();
                    _updatePage(c.getCurrentPage());
                  },
                  shouldExpand: false
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  void _updatePage(int currentPage) {
    pageController.animateToPage(
      currentPage,
      duration: Duration(milliseconds: 200),
      curve: Curves.ease
    );
  }
}
