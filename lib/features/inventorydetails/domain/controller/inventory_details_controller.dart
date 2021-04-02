import 'package:beep/core/router/app_router.dart';
import 'package:beep/shared/model/beep_inventory.dart';
import 'package:get/get.dart';

abstract class InventoryDetailsController extends GetxController {
  void initialize(BeepInventory inventory);
  void routeToImportInventoryProductsPage();
}

class InventoryDetailsControllerImpl extends InventoryDetailsController {
  final AppRouter router;

  BeepInventory beepInventory;

  InventoryDetailsControllerImpl({this.router});

  @override
  void routeToImportInventoryProductsPage() {
    router.routeInventoryDetailsPageToImportInventoryProductsPage(
      beepInventory.id
    );
  }

  @override
  void initialize(BeepInventory inventory) {
    beepInventory = inventory;
  }
}
