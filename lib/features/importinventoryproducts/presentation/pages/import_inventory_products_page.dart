import 'package:beep/core/constants/assets.dart';
import 'package:beep/core/constants/colors.dart';
import 'package:beep/core/constants/dimens.dart';
import 'package:beep/core/constants/texts.dart';
import 'package:beep/features/importinventoryproducts/domain/controller/import_inventory_products_controller.dart';
import 'package:beep/features/inventorydetails/domain/controller/inventory_details_controller.dart';
import 'package:beep/shared/model/beep_inventory.dart';
import 'package:beep/shared/model/inventory_product.dart';
import 'package:beep/shared/widgets/app_bar_details_section.dart';
import 'package:beep/shared/widgets/custom_app_bar.dart';
import 'package:beep/shared/widgets/empty_list.dart';
import 'package:beep/shared/widgets/inventory_product_list_item.dart';
import 'package:beep/shared/widgets/inventory_products_list.dart';
import 'package:beep/shared/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ImportInventoryProductsPage extends StatefulWidget {
  @override
  _ImportInventoryProductsPageState createState() => _ImportInventoryProductsPageState();
}

class _ImportInventoryProductsPageState extends State<ImportInventoryProductsPage> {

  @override
  void initState() {
    BeepInventory beepInventory = Get.arguments;

    Get.find<ImportInventoryProductsController>().initialize(
        beepInventory,
        () => Get.find<InventoryDetailsController>().fetchInventoryDetails()
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.find<InventoryDetailsController>().fetchInventoryDetails();
        return true;
      },
      child: SafeArea(
        child: Scaffold(
          floatingActionButton: ImportProductsFab(),
          body: Column(
            children: [
              CustomAppBar(
                isWhiteStyle: true,
                hasIcon: true,
                icon: inventoryDetailsProductsIcon,
                appBarTitle: importInventoryProductsToolbarTitle,
                onBackPressed: () => Get.find<InventoryDetailsController>().fetchInventoryDetails(),
              ),
              AppBarDetailsSection(
                title: Get.find<InventoryDetailsController>().getBeepInventoryDetails().name,
                bottomSection: ImportInfoSection(),
              ),
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
      ),
    );
  }

  Widget NoImportedInventoryProducts() {
    return EmptyList(
      message: emptyListMessage,
    );
  }

  Widget ProductsImportSection(List<InventoryProduct> importedProducts) {
    return Column(
      children: [
        ConfirmProductsImport(),
        Expanded(
          child: ProductsToImportListView(importedProducts),
        )
      ],
    );
  }

  Widget ConfirmProductsImport() {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: largeSize,
        vertical: normalSize
      ),
      child: PrimaryButton(
        buttonText: confirmProductsImport,
        onPressedCallback: () => Get.find<ImportInventoryProductsController>().registerInventoryProducts(),
        shouldExpand: true
      ),
    );
  }

  Widget ProductsToImportListView(List<InventoryProduct> importedProducts) {
    return InventoryProductsList(inventoryProducts: importedProducts,);
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
    return Column(
      children: [
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
    );
  }
}
