import 'package:beep/core/constants/routes.dart';
import 'package:beep/shared/model/beep_inventory.dart';
import 'package:get/get.dart';
import 'package:beep/shared/model/inventory_file.dart';

abstract class AppRouter {
  void routeSplashPageToLoginPage();
  void routeLoginPageToRegisterPage();
  void routeLoginPageToHomePage();
  void routeHomePageToRegisterInventoryPage();
  void routeHomePageToInventoryDetailsPage(BeepInventory beepInventory);
  void routeInventoryDetailsPageToImportInventoryProductsPage();
  void routeImportInventoryProductsPageToSelectedProductsPage(List<InventoryFile> inventoryFiles);
  void back();
}

class AppRouterImpl extends AppRouter {
  @override
  void routeSplashPageToLoginPage() {
    Get.offAndToNamed(loginPage);
  }

  @override
  void routeLoginPageToRegisterPage() {
    Get.toNamed(registerPage);
  }

  @override
  void back() {
    Get.back();
  }

  @override
  void routeLoginPageToHomePage() {
    Get.offAndToNamed(homeRouterPage);
  }

  @override
  void routeHomePageToRegisterInventoryPage() {
    Get.toNamed(createInventoryRouterPage);
  }

  @override
  void routeHomePageToInventoryDetailsPage(BeepInventory beepInventory) {
    Get.toNamed(inventoryDetailsRouterPage, arguments: beepInventory);
  }

  @override
  void routeInventoryDetailsPageToImportInventoryProductsPage() {
    Get.toNamed(importInventoryProductsRouterPage);
  }

  @override
  void routeImportInventoryProductsPageToSelectedProductsPage(List<InventoryFile> inventoryFiles) {
    // TODO: implement routeImportInventoryProductsPageToSelectedProductsPage
  }
}
