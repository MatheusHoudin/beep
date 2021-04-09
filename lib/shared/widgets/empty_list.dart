import 'package:beep/core/constants/dimens.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EmptyList extends StatelessWidget {
  final String message;

  EmptyList({this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: mediumSize
        ),
        child: Text(
          message,
          textAlign: TextAlign.center,
          style: GoogleFonts.firaSans(
              color: Colors.white,
              fontSize: mediumTextSize
          ),
        ),
      ),
    );
  }
}
