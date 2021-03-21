import 'package:beep/core/constants/assets.dart';
import 'package:beep/core/constants/colors.dart';
import 'package:beep/core/constants/dimens.dart';
import 'package:beep/shared/model/beep_inventory.dart';
import 'package:beep/shared/model/beep_inventory_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class InventoryItem extends StatelessWidget {
  final BeepInventory inventory;

  InventoryItem({this.inventory});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: getBackgroundColor(),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(mediumSmallSize)
      ),
      child: Container(
        margin: EdgeInsets.only(
          left: mediumSmallSize
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(mediumSmallSize)
        ),
        child: Padding(
          padding: EdgeInsets.all(mediumSmallSize),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  SvgPicture.asset(
                    inventoryItemIcon
                  ),
                  SizedBox(width: smallSize,),
                  Text(
                    inventory.name,
                    style: GoogleFonts.firaSans(
                      fontSize: mediumTextSize,
                      color: secondaryColor,
                      fontWeight: FontWeight.bold
                    ),
                  )
                ],
              ),
              Container(
                margin: EdgeInsets.symmetric(
                  vertical: tinySize
                ),
                child: Text(
                  inventory.description,
                  textAlign: TextAlign.start,
                  style: GoogleFonts.firaSans(
                    color: disabledText,
                    fontSize: smallTextSize
                  ),
                ),
              ),
              SizedBox(height: tinySize,),
              Text(
                '${inventory.date} às ${inventory.time}',
                textAlign: TextAlign.start,
                style: GoogleFonts.firaSans(
                  color: disabledText,
                  fontSize: smallTextSize
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Color getBackgroundColor() {
    switch(inventory.status) {
      case BeepInventoryStatus.Started: return startedInventoryBackground;
      case BeepInventoryStatus.NotStarted: return notStartedInventoryBackground;
      default: return finishedInventoryBackground;
    }
  }
}
