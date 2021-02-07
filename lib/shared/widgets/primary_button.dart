import 'package:beep/core/constants/colors.dart';
import 'package:beep/core/constants/dimens.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PrimaryButton extends StatelessWidget {
  final String buttonText;
  final Function onPressedCallback;

  PrimaryButton({this.buttonText, this.onPressedCallback});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: hugeSize,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),

      ),
      child: RawMaterialButton(
        fillColor: primaryColor,
        onPressed: () => onPressedCallback(),
        child: Text(
          buttonText,
          style: GoogleFonts.firaSans(
            fontSize: normalSize,
            color: Colors.white,
            fontWeight: FontWeight.bold
          ),
        ),
      ),
    );
  }
}
