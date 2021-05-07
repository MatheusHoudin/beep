import 'package:beep/core/constants/dimens.dart';
import 'package:flutter/material.dart';

class SmallCardListItem extends StatelessWidget {
  final Widget child;

  SmallCardListItem({this.child});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(mediumSmallSize)),
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: smallSize, vertical: mediumSmallSize),
        child: child,
      ),
    );
  }
}
