import 'package:beep/core/constants/assets.dart';
import 'package:beep/core/constants/colors.dart';
import 'package:beep/core/constants/dimens.dart';
import 'package:beep/shared/model/inventory_counting_session_allocation.dart';
import 'package:beep/shared/widgets/small_card_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class AllocationListItem extends StatelessWidget {
  final InventoryCountingSessionAllocation allocation;

  AllocationListItem({this.allocation});

  @override
  Widget build(BuildContext context) {
    return SmallCardListItem(
      child: Content(),
    );
  }

  Widget Content() {
    return Column(
      children: [
        EmployeeInfoSection(), 
        SizedBox(height: smallSize,),
        LocationInfoSection()
      ],
    );
  }

  Widget EmployeeInfoSection() {
    return Row(
      children: [
        SvgPicture.asset(
          inventoryDetailsEmployeeIcon,
        ),
        SizedBox(width: mediumSmallSize,),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              allocation.employee.name,
              style: GoogleFonts.firaSans(fontSize: mediumTextSize, fontWeight: FontWeight.bold, color: Colors.black),
            ),
            Text(
              allocation.employee.email,
              style: GoogleFonts.firaSans(color: grayColor),
            )
          ],
        )
      ],
    );
  }

  Widget LocationInfoSection() {
    return Row(
      children: [
        SvgPicture.asset(
          inventoryAddressGreen,
        ),
        SizedBox(width: mediumSmallSize,),
        Text(
          allocation.location,
          style: GoogleFonts.firaSans(fontSize: mediumTextSize, fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ],
    );
  }
}
