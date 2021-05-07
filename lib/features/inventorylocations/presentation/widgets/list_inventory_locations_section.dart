import 'package:beep/core/constants/texts.dart';
import 'package:beep/features/inventorylocations/domain/controller/inventory_location_controller.dart';
import 'package:beep/features/inventorylocations/presentation/widgets/inventory_location_item.dart';
import 'package:beep/shared/model/inventory_location.dart';
import 'package:beep/shared/widgets/empty_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';

class ListInventoryLocationsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<InventoryLocationController>(builder: (c) {
      final inventoryLocations = c.getInventoryLocations();

      return inventoryLocations.isEmpty
          ? EmptyList(message: inventoryLocationsEmptyListMessage)
          : InventoryLocationsListView(inventoryLocations);
    }, initState: (_) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        Get.find<InventoryLocationController>().fetchInventoryLocations();
      });
    });
  }

  Widget InventoryLocationsListView(List<InventoryLocation> inventoryLocations) {
    return ListView.builder(
      itemCount: inventoryLocations.length,
      scrollDirection: Axis.vertical,
      itemBuilder: (context, index) => InventoryLocationItem(inventoryLocation: inventoryLocations[index]),
    );
  }
}
