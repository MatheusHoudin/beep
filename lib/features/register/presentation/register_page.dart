import 'package:beep/core/constants/assets.dart';
import 'package:beep/core/constants/dimens.dart';
import 'package:beep/core/constants/texts.dart';
import 'package:beep/core/constants/colors.dart';
import 'package:beep/shared/widgets/custom_app_bar.dart';
import 'package:beep/shared/widgets/custom_password_field.dart';
import 'package:beep/shared/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:beep/shared/widgets/main_text_field.dart';

class RegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: secondaryColor,
        body: SingleChildScrollView(
          child: Column(
            children: [
              CustomAppBar(
                appBarTitle: registerPageAppBarTitle,
                hasIcon: false,
                icon: stepsThird,
              ),
              SizedBox(
                height: largeSize,
              ),
              CreateAccountForm()
            ],
          ),
        ),
      ),
    );
  }

  Widget CreateAccountForm() {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: mediumSize
      ),
      child: Column(
        children: [
          NameField(),
          SizedBox(height: normalSize),
          CpfField(),
          SizedBox(height: normalSize),
          EmailField(),
          SizedBox(height: normalSize),
          PasswordField(),
          SizedBox(height: mediumSize),
          LoginButton()
        ],
      ),
    );
  }

  Widget NameField() {
    return MainTextField(hint: registerPageNameFieldHint);
  }

  Widget CpfField() {
    return MainTextField(hint: registerPageCpfFieldHint);
  }

  Widget EmailField() {
    return MainTextField(hint: registerPageEmailFieldHint);
  }

  Widget PasswordField() {
    return CustomPasswordField(
      isObscure: true,
      hint: passwordFieldHint,
      togglePasswordVisibility: () => null,
    );
  }

  Widget RegisterButton() {
    return PrimaryButton(
      buttonText: registerPageRegisterButton,
      shouldExpand: true,
    );
  }
}
