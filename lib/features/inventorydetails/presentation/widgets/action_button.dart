import 'package:beep/core/constants/colors.dart';
import 'package:beep/core/constants/dimens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

@immutable
class ActionButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String icon;
  final String text;
  final bool isVisible;

  const ActionButton({
    this.onPressed,
    this.icon,
    this.isVisible,
    this.text
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        margin: EdgeInsets.only(left: hugeSize),
        decoration: BoxDecoration(
          //color: isVisible ? primaryColor.withOpacity(0.9) : Colors.transparent,
          borderRadius: BorderRadius.circular(mediumSmallSize)
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Visibility(
              visible: isVisible,
              child: Padding(
                padding: EdgeInsets.only(
                  right: smallSize
                ),
                child: Text(
                  text,
                  style: GoogleFonts.firaSans(
                    color: Colors.white,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
            ),
            Container(
              width: 56,
              height: 56,
              child: Material(
                shape: CircleBorder(),
                clipBehavior: Clip.antiAlias,
                color: primaryColor,
                elevation: 4.0,
                child: IconButton(
                  onPressed: onPressed,
                  icon: SvgPicture.asset(icon),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
