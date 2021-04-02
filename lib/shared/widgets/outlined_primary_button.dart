import 'package:beep/core/constants/colors.dart';
import 'package:beep/core/constants/dimens.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OutlinedPrimaryButton extends StatelessWidget {
  final String buttonText;
  final Function onPressedCallback;

  OutlinedPrimaryButton({this.buttonText, this.onPressedCallback});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: extraHugeSize,
      child: RawMaterialButton(
        constraints: BoxConstraints.expand(),
        fillColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          side: BorderSide(color: primaryColor, width: miniSize)
        ),
        onPressed: () => onPressedCallback(),
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: normalSize,
              horizontal: smallSize
          ),
          child: Text(
            buttonText,
            style: GoogleFonts.firaSans(
                fontSize: normalSize,
                color: Colors.white,
                fontWeight: FontWeight.bold
            ),
          ),
        ),
      ),
    );
  }
}
