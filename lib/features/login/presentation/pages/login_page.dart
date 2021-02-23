import 'package:beep/core/constants/colors.dart';
import 'package:beep/core/constants/dimens.dart';
import 'package:beep/core/constants/texts.dart';
import 'package:beep/features/login/domain/controller/login_page_controller.dart';
import 'package:beep/shared/widgets/custom_password_field.dart';
import 'package:beep/shared/widgets/main_text_field.dart';
import 'package:beep/shared/widgets/outlined_primary_button.dart';
import 'package:beep/shared/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:beep/core/constants/assets.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: secondaryColor,
        body: GetBuilder<LoginPageController>(
          builder: (c) => SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                BeepLogo(),
                SizedBox(height: largeSize,),
                LoginForm(c),
                NoAccountDivider(),
                CreateAccountButton(c),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget BeepLogo() {
    return SvgPicture.asset(
      beepLogo,
      width: beepLogoWidth,
      height: beepLogoHeight,
    );
  }

  Widget EmailField() {
    return MainTextField(hint: emailFieldHint);
  }

  Widget PasswordField(LoginPageController c) {
    return CustomPasswordField(
      isObscure: c.isPasswordVisible(),
      hint: passwordFieldHint,
      togglePasswordVisibility: c.togglePasswordVisibility,
    );
  }

  Widget LoginButton() {
    return PrimaryButton(
      buttonText: login,
      shouldExpand: true,
    );
  }

  Widget CreateAccountButton(LoginPageController c) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: normalSize,
        horizontal: mediumSize
      ),
      child: OutlinedPrimaryButton(
        buttonText: createAccount,
        onPressedCallback: c.continueToRegisterPage,
      ),
    );
  }

  Widget LoginForm(LoginPageController c) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: mediumSize),
      child: Column(
        children: [
          EmailField(),
          SizedBox(height: normalSize),
          PasswordField(c),
          SizedBox(height: mediumSize),
          LoginButton()
        ],
      ),
    );
  }

  Widget NoAccountDivider() {
    return Container(
      margin: EdgeInsets.only(top: normalSize),
      child: Row(
        children: [
          Expanded(
            child: Container(
              color: primaryColor,
              height: miniSize
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: mediumSmallSize),
            child: Text(
              noAccount,
              style: GoogleFonts.firaSans(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: normalTextSize
              ),
            ),
          ),
          Expanded(
            child: Container(
              color: primaryColor,
              height: miniSize,
            ),
          )
        ],
      ),
    );
  }
}
