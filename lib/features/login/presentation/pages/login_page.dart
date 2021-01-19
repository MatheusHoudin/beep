import 'package:beep/core/constants/colors.dart';
import 'package:beep/core/constants/dimens.dart';
import 'package:beep/shared/widgets/main_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:beep/core/constants/assets.dart';

class LoginPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: secondaryColor,
        body: SingleChildScrollView(
          child: Column(
            children: [
              BeepLogo(),
              SizedBox(height: largeSize,),
              LoginForm()
            ],
          ),
        ),
      ),
    );
  }

  Widget BeepLogo() {
    return SvgPicture.asset(
      beepLogo,
      width: 130,
      height: 180,
    );
  }

  Widget EmailField() {
    return MainTextField(hint: "Digite seu email");
  }

  Widget PasswordField() {
    return MainTextField(
      hint: "Digite sua senha",
      isObscure: true,
      suffixIcon: Icon(
        Icons.visibility_off_outlined,
        color: primaryColor,
      ),
    );
  }

  Widget LoginForm() {
    return Container(
      margin: EdgeInsets.only(
        left: mediumSize,
        right: mediumSize
      ),
      child: Column(
        children: [
          EmailField(),
          SizedBox(height: normalSize),
          PasswordField()
        ],
      ),
    );
  }
}
