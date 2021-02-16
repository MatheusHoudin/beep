import 'package:beep/core/constants/dimens.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomOutlinedButton extends StatelessWidget {
  final String buttonText;
  final Function onPressedCallback;

  CustomOutlinedButton({this.buttonText, this.onPressedCallback});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: hugeSize,
      alignment: Alignment.center,
      child: RawMaterialButton(
        fillColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(4)),
          side: BorderSide(color: Colors.white)
        ),
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
