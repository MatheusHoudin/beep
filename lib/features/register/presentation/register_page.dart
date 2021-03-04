import 'package:beep/core/constants/assets.dart';
import 'package:beep/core/constants/dimens.dart';
import 'package:beep/core/constants/texts.dart';
import 'package:beep/core/constants/colors.dart';
import 'package:beep/features/register/domain/controller/register_controller.dart';
import 'package:beep/shared/widgets/custom_app_bar.dart';
import 'package:beep/shared/widgets/custom_password_field.dart';
import 'package:beep/shared/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:beep/shared/widgets/main_text_field.dart';
import 'package:get/get.dart';

class RegisterPage extends StatelessWidget {

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

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
    return GetBuilder<RegisterController>(
      builder: (c) => Padding(
        padding: EdgeInsets.symmetric(
            horizontal: mediumSize
        ),
        child: Column(
          children: [
            NameField(),
            SizedBox(height: normalSize),
            EmailField(),
            SizedBox(height: normalSize),
            PasswordField(c),
            SizedBox(height: mediumSize),
            RegisterButton(c)
          ],
        ),
      ),
    );
  }

  Widget NameField() {
    return MainTextField(
      hint: registerPageNameFieldHint,
      controller: nameController,
    );
  }

  Widget EmailField() {
    return MainTextField(
      hint: registerPageEmailFieldHint,
      controller: emailController,
    );
  }

  Widget PasswordField(RegisterController c) {
    return CustomPasswordField(
      isObscure: c.isPasswordObscure(),
      hint: passwordFieldHint,
      togglePasswordVisibility: () => c.togglePasswordVisibility(),
      controller: passwordController,
    );
  }

  Widget RegisterButton(RegisterController controller) {
    return PrimaryButton(
      buttonText: registerPageRegisterButton,
      shouldExpand: true,
      onPressedCallback: () => controller.registerUser(
        nameController.value.text,
        emailController.value.text,
        passwordController.value.text
      ),
    );
  }
}
