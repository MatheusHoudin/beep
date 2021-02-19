import 'package:beep/core/constants/colors.dart';
import 'package:beep/core/constants/dimens.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PrimaryButton extends StatelessWidget {
  final String buttonText;
  final bool shouldExpand;
  final Function onPressedCallback;

  PrimaryButton({this.buttonText, this.onPressedCallback, this.shouldExpand});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: hugeSize,
      alignment: Alignment.center,
      child: shouldExpand
          ? ExpandableRawMaterialButton()
          : NormalRawMaterialButton(),
    );
  }

  Widget ExpandableRawMaterialButton() {
    return RawMaterialButton(
      constraints: BoxConstraints.expand(),
      fillColor: primaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      onPressed: () => onPressedCallback(),
      child: ButtonText(),
    );
  }

  Widget NormalRawMaterialButton() {
    return RawMaterialButton(
      fillColor: primaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      onPressed: () => onPressedCallback(),
      child: ButtonText(),
    );
  }

  Widget ButtonText() {
    return Text(
      buttonText,
      style: GoogleFonts.firaSans(
          fontSize: normalSize,
          color: Colors.white,
          fontWeight: FontWeight.bold),
    );
  }
}
