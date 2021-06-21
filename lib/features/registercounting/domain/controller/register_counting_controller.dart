import 'package:beep/features/home/domain/usecase/get_logged_user_use_case.dart';
import 'package:beep/shared/model/inventory_counting_allocation.dart';
import 'package:beep/shared/model/inventory_location.dart';
import 'package:beep/shared/model/inventory_product.dart';
import 'package:get/get.dart';

abstract class RegisterCountingController extends GetxController {
  void initialize(InventoryCountingAllocation inventoryCountingAllocation);
  String getInventoryName();
  String getLocationName();
  InventoryLocation getInventoryLocation();
  String getInventoryCode();
  String getLoggedUserCompanyCode();
  InventoryProduct getFoundInventoryProduct();
  void findProductByBarCode(String barcode);
  void resetFoundProduct();
}

class RegisterCountingControllerImpl extends RegisterCountingController {
  final GetLoggedUserUseCase getLoggedUserUseCase;

  InventoryCountingAllocation _inventoryCountingAllocation;
  InventoryProduct _foundProduct;

  RegisterCountingControllerImpl({this.getLoggedUserUseCase});

  @override
  void initialize(InventoryCountingAllocation inventoryCountingAllocation) {
    _inventoryCountingAllocation = inventoryCountingAllocation;
  }

  @override
  String getInventoryName() {
    return _inventoryCountingAllocation.beepInventory.name;
  }

  @override
  String getLocationName() {
    return _inventoryCountingAllocation.employeeInventoryAllocation.inventoryLocation.name;
  }

  @override
  String getInventoryCode() {
    return _inventoryCountingAllocation.beepInventory.id;
  }

  @override
  InventoryLocation getInventoryLocation() {
    return _inventoryCountingAllocation.employeeInventoryAllocation.inventoryLocation;
  }

  @override
  String getLoggedUserCompanyCode() {
    final loggedUser = getLoggedUserUseCase(GetLoggedUserParams());
    return loggedUser.companyCode;
  }

  @override
  void findProductByBarCode(String barcode) {
    _foundProduct = _inventoryCountingAllocation.products.firstWhere((e) => e.code == barcode);

    if (_foundProduct != null) update();
  }

  @override
  InventoryProduct getFoundInventoryProduct() {
    return _foundProduct;
  }

  @override
  void resetFoundProduct() {
    _foundProduct = null;
    update();
  }
}
