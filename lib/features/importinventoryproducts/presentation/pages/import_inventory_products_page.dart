import 'package:beep/core/constants/assets.dart';
import 'package:beep/core/constants/colors.dart';
import 'package:beep/core/constants/dimens.dart';
import 'package:beep/core/constants/texts.dart';
import 'package:beep/features/importinventoryproducts/domain/controller/import_inventory_products_controller.dart';
import 'package:beep/shared/model/imported_inventory_product.dart';
import 'package:beep/shared/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ImportInventoryProductsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: ImportProductsFab(),
        body: Column(
          children: [
            CustomAppBar(
              isWhiteStyle: true,
              hasIcon: true,
              icon: inventoryDetailsProductsFabIcon,
              appBarTitle: importInventoryProductsToolbarTitle,
            ),
            ImportInfoSection(),
            Expanded(
              child: Container(
                color: secondaryColor,
                child: GetX<ImportInventoryProductsController>(
                  builder: (c) {
                    final importedProducts = c.getImportedInventoryProducts();

                    return importedProducts.isEmpty ?
                    NoImportedInventoryProducts() :
                    ProductsImportSection(importedProducts);
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget NoImportedInventoryProducts() {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: mediumSize
        ),
        child: Text(
          'Não há produtos disponíveis para importação neste momento, clique em + para importar.',
          textAlign: TextAlign.center,
          style: GoogleFonts.firaSans(
            color: Colors.white,
            fontSize: mediumTextSize
          ),
        ),
      ),
    );
  }

  Widget ProductsImportSection(List<ImportedInventoryProduct> importedProducts) {
    return ListView.builder(
      itemCount: importedProducts.length,
      scrollDirection: Axis.vertical,
      itemBuilder: (context, index) {
        return Text(importedProducts[index].name, style: TextStyle(color: Colors.white),);
      },
    );
  }

  Widget ImportProductsFab() {
    return FloatingActionButton(
      backgroundColor: primaryColor,
      onPressed: () => Get.find<ImportInventoryProductsController>().fetchAvailableFilesToImport(),
      child: Icon(
        Icons.add,
        color: Colors.white,
      ),
    );
  }

  Widget ImportInfoSection() {
    return Container(
      width: Get.size.width,
      margin: EdgeInsets.only(
        bottom: mediumSmallSize
      ),
      padding: EdgeInsets.symmetric(
        horizontal: smallSize
      ),
      color: Colors.white,
      child: Column(
        children: [
          Text(
            'Frios e Congelados',
            style: GoogleFonts.firaSans(
              fontSize: normalTextSize,
              color: grayTextColor
            ),
          ),
          SizedBox(height: mediumSmallSize,),
          Text(
            importInventoryProductsInfo,
            textAlign: TextAlign.center,
            style: GoogleFonts.firaSans(
              fontSize: smallTextSize,
              color: grayTextColor
            ),
          ),
          Text(
            importInventoryProductsFieldsName,
            style: GoogleFonts.firaSans(
              fontSize: smallTextSize,
              color: grayTextColor,
              fontWeight: FontWeight.bold
            ),
          )
        ],
      ),
    );
  }
}
