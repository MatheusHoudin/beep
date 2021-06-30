import 'package:beep/core/constants/dimens.dart';
import 'package:flutter/material.dart';

class CountingActionToggle extends StatelessWidget {
  final Color color;
  final Widget icon;
  final Function onClick;

  CountingActionToggle({this.color, this.icon, this.onClick});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(smallSize)),
      color: color,
      child: InkWell(
        onTap: onClick,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: smallSize, horizontal: normalSize),
          child: icon,
        ),
      ),
    );
  }
}
