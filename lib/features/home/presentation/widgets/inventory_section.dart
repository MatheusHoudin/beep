import 'package:beep/core/constants/colors.dart';
import 'package:beep/core/constants/dimens.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class InventorySection extends StatefulWidget {
  final String title;
  final Widget inventoriesSection;

  InventorySection({this.inventoriesSection, this.title});

  @override
  _InventorySectionState createState() => _InventorySectionState();
}

class _InventorySectionState extends State<InventorySection> {
  IconData icon = Icons.keyboard_arrow_down_rounded;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.size.width,
      margin: EdgeInsets.symmetric(
        horizontal: mediumSmallSize
      ),
      child: ExpansionTile(
        title: Text(
          widget.title,
          style: GoogleFonts.firaSans(
            color: Colors.white,
            fontSize: largeTextSize,
            fontWeight: FontWeight.bold
          ),
        ),
        trailing: Icon(
          icon,
          color: primaryColor
        ),
        onExpansionChanged: (isExpanded) {
          setState(() {
            icon = isExpanded ?
            Icons.keyboard_arrow_up_rounded
                : Icons.keyboard_arrow_down_rounded;
          });
        },
        children: [widget.inventoriesSection],
      ),
    );
  }
}
