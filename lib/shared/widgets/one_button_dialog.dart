import 'package:beep/core/constants/texts.dart';
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
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: Content(),
    );
  }

  Widget Content() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: Consts.padding),
      decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.all(Radius.circular(8))
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 10,),
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
          FlatButton(
            child: Text(
              okText,
              style: GoogleFonts.firaSans(
                  fontSize: 18,
                  fontWeight: FontWeight.bold
              ),
            ),
            onPressed: () => okFunction(),
          )
        ],
      ),
    );
  }
}

class Consts {
  static const double padding = 16.0;
}
