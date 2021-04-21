import 'package:beep/core/constants/dimens.dart';
import 'package:beep/core/constants/texts.dart';
import 'package:beep/shared/widgets/base_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class OneButtonDialog extends StatelessWidget {
  final String title, message, okText;
  Function okFunction = () => Get.back();

  OneButtonDialog({
    this.title,
    this.message,
    this.okText = genericErrorButton,
    this.okFunction
  });

  @override
  Widget build(BuildContext context) {
    return BaseDialog(content: Content());
  }

  Widget Content() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          title,
          style: GoogleFonts.firaSans(
              fontSize: 20,
              fontWeight: FontWeight.bold
          ),
        ),
        SizedBox(height: 10,),
        Text(
          message,
          textAlign: TextAlign.justify,
          style: GoogleFonts.firaSans(
              fontSize: 16
          ),
        ),
        SizedBox(height: 16,),
        InkWell(
          child: Container(
            width: extraHugeSize,
            height: extraLargeSize,
            alignment: Alignment.center,
            child: Text(
              okText,
              style: GoogleFonts.firaSans(
                  fontSize: 18,
                  fontWeight: FontWeight.bold
              ),
            ),
          ),
          onTap: () => okFunction(),
        )
      ],
    );
  }
}
