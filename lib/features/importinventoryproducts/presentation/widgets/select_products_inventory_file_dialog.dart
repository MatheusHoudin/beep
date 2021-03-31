import 'package:beep/core/constants/assets.dart';
import 'package:beep/core/constants/colors.dart';
import 'package:beep/core/constants/dimens.dart';
import 'package:beep/core/constants/texts.dart';
import 'package:beep/features/importinventoryproducts/domain/controller/import_inventory_products_controller.dart';
import 'package:beep/shared/model/inventory_file.dart';
import 'package:beep/shared/widgets/two_buttons_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
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
            HeaderSection(),
            Expanded(
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
      alignment: Alignment.center,
      height: 160,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          HeaderImageSection(),
          Column(
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
      onTap: () => Get.dialog(SelectInventoryFileConfirmDialog(inventoryFile)),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: smallSize),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
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
            SizedBox(height: mediumSmallSize,),
            Container(
              color: grayTextColor,
              height: 1.0
            )
          ],
        ),
      ),
    );
  }

  Widget SelectInventoryFileConfirmDialog(InventoryFile inventoryFile) {
    return TwoButtonsDialog(
      title: confirmInventoryFileDialogTitle,
      message: "$confirmInventoryFileDialogMessage${inventoryFile.name}",
      confirmText: confirmInventoryFileDialogPositiveButton,
      cancelText: confirmInventoryFileDialogNegativeButton,
      confirmFunction: () => Get.find<ImportInventoryProductsController>().importInventoryProducts(inventoryFile.id),
      cancelFunction: () => Get.back(),
    );
  }
}
