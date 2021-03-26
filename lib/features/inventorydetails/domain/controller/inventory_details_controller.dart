import 'package:beep/core/router/app_router.dart';
import 'package:get/get.dart';

abstract class InventoryDetailsController extends GetxController {
  void routeToImportInventoryProductsPage();
}

class InventoryDetailsControllerImpl extends InventoryDetailsController {
  final AppRouter router;

  InventoryDetailsControllerImpl({this.router});

  @override
  void routeToImportInventoryProductsPage() {
    router.routeInventoryDetailsPageToImportInventoryProductsPage();
  }
}
