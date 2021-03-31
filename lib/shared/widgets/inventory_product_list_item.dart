import 'package:beep/core/constants/assets.dart';
import 'package:beep/core/constants/colors.dart';
import 'package:beep/core/constants/dimens.dart';
import 'package:beep/shared/model/inventory_product.dart';
import 'package:beep/shared/model/inventory_product_packaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class InventoryProductListItem extends StatelessWidget {
  final InventoryProduct inventoryProduct;

  InventoryProductListItem({this.inventoryProduct});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.all(mediumSmallSize),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProductName(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ProductBarcode(),
                ProductPackaging()
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget ProductName() {
    return Text(
      inventoryProduct.name,
      style: GoogleFonts.firaSans(
        color: primaryColor,
        fontWeight: FontWeight.bold,
        fontSize: mediumTextSize
      ),
    );
  }

  Widget ProductBarcode() {
    return Row(
      children: [
        SvgPicture.asset(
          greenBarcodeIcon
        ),
        SizedBox(width: tinySize,),
        Text(
          inventoryProduct.code,
          style: GoogleFonts.firaSans(
            fontSize: normalTextSize,
            color: grayTextColor
          ),
        )
      ],
    );
  }

  Widget ProductPackaging() {
    return SvgPicture.asset(
      _getProductPackagingIcon(),
      width: normalSize,
      height: normalSize,
    );
  }

  String _getProductPackagingIcon() {
    return inventoryProduct.inventoryProductPackaging == InventoryProductPackaging.KG
        ? productWeightIcon : inventoryDetailsProductsIcon;
  }
}
