import 'package:beep/core/constants/colors.dart';
import 'package:beep/shared/widgets/main_text_field.dart';
import 'package:flutter/material.dart';

class CustomPasswordField extends StatelessWidget {
  final String hint;
  final bool isObscure;
  final Function togglePasswordVisibility;

  CustomPasswordField({this.hint, this.isObscure, this.togglePasswordVisibility});

  @override
  Widget build(BuildContext context) {
    return MainTextField(
      hint: hint,
      isObscure: !isObscure,
      suffixIcon: GestureDetector(
        onTap: togglePasswordVisibility,
        child: Icon(
          isObscure ? Icons.visibility : Icons.visibility_off_outlined,
          color: primaryColor,
        ),
      ),
    );
  }
}
