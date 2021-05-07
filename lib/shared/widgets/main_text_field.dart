import 'package:beep/core/constants/colors.dart';
import 'package:beep/core/constants/dimens.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MainTextField extends StatelessWidget {
  final String hint;
  final bool isObscure;
  final bool isMultiline;
  final bool isFilled;
  final TextInputType textInputType;
  final TextEditingController controller;

  final Widget suffixIcon;

  MainTextField({
    this.hint,
    this.isObscure = false,
    this.isMultiline = false,
    this.suffixIcon,
    this.controller,
    this.textInputType,
    this.isFilled = false
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: textInputType,
      minLines: isMultiline ? 5 : 1,
      maxLines: isMultiline ? null : 1,
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        fillColor: Colors.white,
        contentPadding: EdgeInsets.symmetric(
          horizontal: smallSize,
          vertical: tinySize
        ),
        enabledBorder: BorderStyle(Colors.white),
        focusedBorder: BorderStyle(primaryColor),
        hintText: hint,
        hintStyle: GoogleFonts.firaSans(
          color: hintColor,
        )
      ),
      style: GoogleFonts.firaSans(
        color: Colors.white
      ),
      obscureText: isObscure,
    );
  }
  
  OutlineInputBorder BorderStyle(Color color) {
    return OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(4.0)),
        borderSide: BorderSide(
            color: color,
            width: 1.0
        )
    );
  }
}
