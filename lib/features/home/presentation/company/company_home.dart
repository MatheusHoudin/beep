import 'package:beep/core/constants/colors.dart';
import 'package:beep/core/constants/dimens.dart';
import 'package:beep/features/home/domain/controller/company_controller.dart';
import 'package:beep/features/home/presentation/widgets/home_header.dart';
import 'package:beep/features/home/presentation/widgets/inventory_item.dart';
import 'package:beep/features/home/presentation/widgets/inventory_section.dart';
import 'package:beep/shared/model/beep_inventory.dart';
import 'package:beep/shared/widgets/fullscreen_loading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:beep/core/constants/texts.dart';

class CompanyHome extends StatefulWidget {
  @override
  _CompanyHomeState createState() => _CompanyHomeState();
}

class _CompanyHomeState extends State<CompanyHome> {

  @override
  void initState() {
    Get.find<CompanyController>().fetchCompanyInventories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CompanyController>(
      builder: (c) {
        return SizedBox(
          height: Get.size.height,
          width: Get.size.width,
          child: Column(
            children: [
              HomeHeader(
                isCompany: true,
                companyName: c.getCompanyName(),
              ),
              SizedBox(height: smallSize,),
              Expanded(
                child: c.isLoadingInventories() ?
                FullScreenLoading(
                    height: Get.size.height * 0.8,
                    width: Get.size.width
                )
                :
                SingleChildScrollView(
                  child: Column(
                    children: [
                      _inventorySection(companyStartedInventoriesTitle, c.getStartedInventories()),
                      _inventorySection(companyNotStartedInventoriesTitle, c.getNotStartedInventories()),
                      _inventorySection(companyFinishedInventoriesTitle, c.getFinishedInventories())
                    ],
                  ),
                )
              ),
            ],
          ),
        );
      }
    );
  }

  Widget _inventorySection(String title, List<BeepInventory> inventories) {
    return inventories != null ? InventorySection(
      title: title,
      inventoriesSection: Column(
        children: inventories.map((e) => InventoryItem(inventory: e,)).toList(),
      ),
    ) : Container();
  }
}
