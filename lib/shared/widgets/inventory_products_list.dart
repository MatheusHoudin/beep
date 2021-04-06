import 'package:beep/core/constants/dimens.dart';
import 'package:beep/shared/model/inventory_product.dart';
import 'package:beep/shared/widgets/inventory_product_list_item.dart';
import 'package:flutter/material.dart';

class InventoryProductsList extends StatelessWidget {
  final List<InventoryProduct> inventoryProducts;

  InventoryProductsList({this.inventoryProducts});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: inventoryProducts.length,
      scrollDirection: Axis.vertical,
      padding: EdgeInsets.symmetric(
          horizontal: tinySize
      ),
      itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.only(
              bottom: mediumSmallSize
          ),
          child: InventoryProductListItem(inventoryProduct: inventoryProducts[index],),
        );
      },
    );
  }
}
