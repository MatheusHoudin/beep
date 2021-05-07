import 'package:beep/core/constants/colors.dart';
import 'package:beep/core/constants/dimens.dart';
import 'package:beep/shared/model/inventory_location.dart';
import 'package:beep/shared/widgets/small_card_list_item.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InventoryLocationItem extends StatelessWidget {
  final InventoryLocation inventoryLocation;

  InventoryLocationItem({this.inventoryLocation});

  @override
  Widget build(BuildContext context) {
    return SmallCardListItem(
      child: Column(
        children: [
          LocationTitle(),
          SizedBox(height: tinySize,),
          LocationDescription()
        ],
      ),
    );
  }

  Widget LocationTitle() {
    return Text(
      inventoryLocation.name,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: GoogleFonts.firaSans(color: Colors.black, fontWeight: FontWeight.bold, fontSize: mediumTextSize),
    );
  }

  Widget LocationDescription() {
    return Text(
      inventoryLocation.description,
      maxLines: 3,
      overflow: TextOverflow.ellipsis,
      style: GoogleFonts.firaSans(
        color: grayTextColor,
        fontSize: normalTextSize
      ),
    );
  }
}
