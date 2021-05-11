import 'package:beep/core/constants/colors.dart';
import 'package:beep/core/constants/dimens.dart';
import 'package:beep/shared/widgets/small_card_list_item.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SimpleListItem extends StatelessWidget {
  final String title, description;
  final bool hasDescription, isExpandedVertically;

  SimpleListItem({this.description, this.title, this.hasDescription = true, this.isExpandedVertically = false});

  @override
  Widget build(BuildContext context) {
    return SmallCardListItem(
      verticalPadding: isExpandedVertically ? mediumSize : mediumSmallSize,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LocationTitle(),
          SizedBox(
            height: miniSize,
          ),
          Visibility(
            visible: hasDescription,
            child: LocationDescription(),
          )
        ],
      ),
    );
  }

  Widget LocationTitle() {
    return Text(
      title,
      style: GoogleFonts.firaSans(color: Colors.black, fontWeight: FontWeight.bold, fontSize: mediumTextSize),
    );
  }

  Widget LocationDescription() {
    return Text(
      description,
      style: GoogleFonts.firaSans(color: grayColor, fontSize: normalTextSize),
    );
  }
}
