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
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
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
    );
  }
}
