import 'package:beep/core/constants/dimens.dart';
import 'package:flutter/material.dart';

class SmallCardListItem extends StatelessWidget {
  final Widget child;
  final double verticalPadding;

  SmallCardListItem({this.child, this.verticalPadding = mediumSmallSize});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(mediumSmallSize)),
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: smallSize, vertical: verticalPadding),
        child: child,
      ),
    );
  }
}
