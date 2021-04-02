import 'package:beep/features/inventorydetails/domain/controller/inventory_details_controller.dart';
import 'package:get/get.dart';

class InventoryDetailsBindings extends Bindings {
  @override
  void dependencies() {
    Get.put<InventoryDetailsController>(InventoryDetailsControllerImpl(
      router: Get.find()
    ));
  }
}
