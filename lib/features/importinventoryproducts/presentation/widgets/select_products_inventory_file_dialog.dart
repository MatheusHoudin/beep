import 'package:beep/core/constants/assets.dart';
import 'package:beep/core/constants/colors.dart';
import 'package:beep/core/constants/dimens.dart';
import 'package:beep/core/constants/texts.dart';
import 'package:beep/shared/model/inventory_file.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class SelectProductsInventoryFileDialog extends StatelessWidget {
  final List<InventoryFile> inventoryFiles;

  SelectProductsInventoryFileDialog({this.inventoryFiles});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.symmetric(
        horizontal: normalSize
      ),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: smallSize
        ),
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: HeaderSection()
            ),
            Expanded(
              flex: 7,
              child: ListView(
                children: inventoryFiles.map((inventoryFile) => InventoryFileItem(inventoryFile)).toList(),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget HeaderSection() {
    return Container(
      child: Column(
        children: [
          HeaderImageSection(),
          Expanded(
            child: Column(
              children: [
                Text(
                  selectInventoryProductsFileGoogleDriveTitle,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.firaSans(
                    fontSize: mediumTextSize,
                    fontWeight: FontWeight.bold,
                    color: Colors.black
                  ),
                ),
                SizedBox(height: mediumSmallSize,),
                Text(
                  selectInventoryProductsFileGoogleDriveInfo,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.firaSans(
                    color: grayTextColor,
                    fontSize: smallTextSize
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget HeaderImageSection() {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: smallSize
      ),
      child: SvgPicture.asset(
        googleDriveIcon,
        height: extraLargeSize,
        width: extraLargeSize,
      ),
    );
  }

  Widget InventoryFileItem(InventoryFile inventoryFile) {
    return InkWell(
      onTap: () => null,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: smallSize),
        child: Row(
          children: [
            Container(
              margin: EdgeInsets.symmetric(
                vertical: mediumSmallSize
              ),
              child: Image.asset(
                spreadsheetIcon,
                height: largeSize,
                width: largeSize,
              ),
            ),
            SizedBox(width: smallSize,),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    inventoryFile.name,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.firaSans(
                      color: primaryColor,
                      fontSize: mediumTextSize
                    ),
                  ),
                  SizedBox(height: tinySize,),
                  Text(
                    inventoryFile.createdAt,
                    style: GoogleFonts.firaSans(
                      color: grayTextColor,
                      fontSize: normalTextSize
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
