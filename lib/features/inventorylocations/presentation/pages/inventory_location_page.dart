import 'package:beep/features/inventorylocations/domain/controller/inventory_location_controller.dart';
import 'package:beep/features/inventorylocations/presentation/widgets/add_inventory_location_section.dart';
import 'package:beep/features/inventorylocations/presentation/widgets/list_inventory_locations_section.dart';
import 'package:beep/shared/model/beep_inventory.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/constants/assets.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/constants/dimens.dart';
import '../../../../core/constants/texts.dart';
import '../../../../shared/widgets/app_bar_details_section.dart';
import '../../../../shared/widgets/custom_app_bar.dart';

class InventoryLocationPage extends StatefulWidget {
  @override
  _InventoryLocationPageState createState() => _InventoryLocationPageState();
}

class _InventoryLocationPageState extends State<InventoryLocationPage> {
  @override
  void initState() {
    Get.find<InventoryLocationController>().initialize(Get.arguments as BeepInventory);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GetBuilder<InventoryLocationController>(
        builder: (c) => Scaffold(
        backgroundColor: secondaryColor,
        floatingActionButton: AddLocationFloatingButton(c),
        body: Column(
          children: [
            CustomAppBar(
              isWhiteStyle: true,
              hasIcon: true,
              icon: inventoryDetailsAddressesIcon,
              appBarTitle: inventoryLocationsToolbarTitle,
              onBackPressed: () => null,
            ),
            AppBarDetailsSection(
              title: c.getBeepInventoryTitle(),
              bottomSection: ImportInfoSection(),
            ),
            Expanded(
              child: ContentSection(c.isCreatingInventoryLocation()),
            )
          ],
        ),
      ),
      ),
    );
  }

  Widget ImportInfoSection() {
    return Text(
      inventoryLocationsInfo,
      textAlign: TextAlign.center,
      style: GoogleFonts.firaSans(fontSize: smallTextSize, color: grayTextColor),
    );
  }

  Widget ContentSection(bool isAddingInventoryLocation) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: smallSize, vertical: mediumSmallSize),
      child: isAddingInventoryLocation ? AddInventoryLocationSection() : ListInventoryLocationsSection()
    );
  }

  Widget AddLocationFloatingButton(InventoryLocationController controller) {
    return FloatingActionButton(
      onPressed: () => controller.toogleIsCreatingInventoryLocation(),
      backgroundColor: primaryColor,
      child: Icon(
        Icons.add,
        color: Colors.white,
      ),
    );
  }
}
