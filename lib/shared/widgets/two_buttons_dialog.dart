import 'package:beep/core/constants/colors.dart';
import 'package:beep/core/constants/dimens.dart';
import 'package:beep/shared/widgets/base_dialog.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TwoButtonsDialog extends StatelessWidget {
  final String title, message, cancelText, confirmText;
  final Function confirmFunction, cancelFunction;

  TwoButtonsDialog(
      {this.title, this.message, this.cancelText, this.confirmText, this.confirmFunction, this.cancelFunction});

  @override
  Widget build(BuildContext context) {
    return BaseDialog(
      content: Content(),
    );
  }

  Widget Content() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          title,
          textAlign: TextAlign.center,
          style: GoogleFonts.firaSans(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          message,
          textAlign: TextAlign.justify,
          style: GoogleFonts.firaSans(fontSize: 16),
        ),
        SizedBox(
          height: 16,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            DialogButton(cancelText, negativeColor, cancelFunction),
            SizedBox(
              width: hugeSize,
            ),
            DialogButton(confirmText, positiveColor, confirmFunction)
          ],
        )
      ],
    );
  }

  Widget DialogButton(String text, Color color, Function onPressed) {
    return InkWell(
      child: Text(
        text,
        style: GoogleFonts.firaSans(fontSize: 18, fontWeight: FontWeight.bold, color: color),
      ),
      onTap: onPressed,
    );
  }
}
