import 'package:beep/core/constants/assets.dart';
import 'package:beep/core/constants/colors.dart';
import 'package:beep/core/constants/dimens.dart';
import 'package:beep/shared/widgets/small_card_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class InventoryEmployee extends StatelessWidget {
  final String employeeName;
  final String employeeEmail;

  InventoryEmployee({this.employeeEmail, this.employeeName});

  @override
  Widget build(BuildContext context) {
    return SmallCardListItem(
      child: Row(
          children: [
            SvgPicture.asset(inventoryDetailsEmployeeIcon),
            SizedBox(width: mediumSmallSize,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  employeeName,
                  style: GoogleFonts.firaSans(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: mediumTextSize
                  ),
                ),
                SizedBox(height: tinySize,),
                Text(
                  employeeEmail,
                  style: GoogleFonts.firaSans(
                    fontSize: normalTextSize,
                    color: grayTextColor
                  ),
                )
              ],
            )
          ],
        ),
    );
  }
}
