import 'package:beep/core/constants/routes.dart';
import 'package:beep/shared/model/beep_inventory.dart';
import 'package:beep/shared/model/beep_inventory_session.dart';
import 'package:beep/shared/model/inventory_counting_allocation.dart';
import 'package:get/get.dart';

abstract class AppRouter {
  void routeSplashPageToLoginPage();
  void routeLoginPageToRegisterPage();
  void routeLoginPageToHomePage();
  void routeHomePageToRegisterInventoryPage();
  void routeHomePageToEmployeeAllocationsPage(BeepInventory beepInventory);
  void routeEmployeeInventoryAllocationsPageToRegisterCountingPage(
      InventoryCountingAllocation inventoryCountingAllocation);
  void routeHomePageToInventoryDetailsPage(BeepInventory beepInventory);
  void routeInventoryDetailsPageToImportInventoryProductsPage(BeepInventory beepInventory);
  void routeInventoryDetailsPageToInventoryEmployeesPage(BeepInventory beepInventory);
  void routeInventoryDetailsPageToInventoryLocationsPage(BeepInventory beepInventory);
  void routeInventoryDetailsPageToCountingSessionsPage(BeepInventory beepInventory, String session);
  void logOut();
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
  void routeInventoryDetailsPageToImportInventoryProductsPage(BeepInventory beepInventory) {
    Get.toNamed(importInventoryProductsRouterPage, arguments: beepInventory);
  }

  @override
  void routeInventoryDetailsPageToInventoryEmployeesPage(BeepInventory beepInventory) {
    Get.toNamed(inventoryEmployeesRouterPage, arguments: beepInventory);
  }

  @override
  void routeInventoryDetailsPageToInventoryLocationsPage(BeepInventory beepInventory) {
    Get.toNamed(inventoryLocationsRouterPage, arguments: beepInventory);
  }

  @override
  void routeInventoryDetailsPageToInventoryCountingSessionsPage(BeepInventory beepInventory, String session) {
    Get.toNamed(inventoryCountingSessionsRouterPage,
        arguments: BeepInventorySession(beepInventory: beepInventory, session: session));
  }

  @override
  void logOut() {
    Get.offAllNamed(loginPage);
  }

  @override
  void routeHomePageToEmployeeInventoryAllocationsPage(BeepInventory beepInventory) {
    Get.toNamed(employeeInventoryAllocationsRouterPage, arguments: beepInventory);
  }

  @override
  void routeEmployeeInventoryAllocationsPageToRegisterCountingPage(
      InventoryCountingAllocation inventoryCountingAllocation) {
    Get.toNamed(registerCountingRouterPage, arguments: inventoryCountingAllocation);
  }
}
