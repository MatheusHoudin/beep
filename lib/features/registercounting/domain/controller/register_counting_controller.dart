import 'package:beep/core/error/failure.dart';
import 'package:beep/core/router/app_router.dart';
import 'package:beep/features/employeeinventoryallocations/domain/usecase/change_allocation_status_use_case.dart';
import 'package:beep/features/home/domain/usecase/get_logged_user_use_case.dart';
import 'package:beep/features/registercounting/domain/usecase/register_counting_use_case.dart';
import 'package:beep/shared/feedback/feedback_message_provider.dart';
import 'package:beep/shared/feedback/loading_provider.dart';
import 'package:beep/shared/model/beep_user.dart';
import 'package:beep/shared/model/inventory_counting_allocation.dart';
import 'package:beep/shared/model/inventory_location.dart';
import 'package:beep/shared/model/inventory_product.dart';
import 'package:get/get.dart';
import 'package:beep/core/constants/texts.dart';

abstract class RegisterCountingController extends GetxController {
  void initialize(InventoryCountingAllocation inventoryCountingAllocation, Function onBackPressed);
  String getInventoryName();
  String getLocationName();
  InventoryLocation getInventoryLocation();
  String getInventoryCode();
  String getLoggedUserCompanyCode();
  InventoryProduct getFoundInventoryProduct();
  String getNotFoundProductCode();
  BeepUser getLoggedUser();
  String getAllocationSession();
  void setSelectedProduct(InventoryProduct selectedProduct);
  void findProductByBarCode(String barcode);
  void registerFoundProduct(String quantity);
  void resetFoundProduct();
  void resetNotFoundProduct();
  void finishAllocation();
}

class RegisterCountingControllerImpl extends RegisterCountingController {
  final GetLoggedUserUseCase getLoggedUserUseCase;
  final RegisterCountingUseCase registerCountingUseCase;
  final ChangeAllocationStatusUseCase changeAllocationStatusUseCase;
  final LoadingProvider loadingProvider;
  final FeedbackMessageProvider feedbackMessageProvider;
  final AppRouter router;

  InventoryCountingAllocation _inventoryCountingAllocation;
  InventoryProduct _foundProduct;
  String _notFoundProductCode;
  BeepUser _loggedUser;
  Function _onBackPressed;

  RegisterCountingControllerImpl(
      {this.getLoggedUserUseCase,
      this.loadingProvider,
      this.feedbackMessageProvider,
      this.registerCountingUseCase,
      this.changeAllocationStatusUseCase,
      this.router});

  @override
  void initialize(InventoryCountingAllocation inventoryCountingAllocation, Function onBackPressed) {
    _inventoryCountingAllocation = inventoryCountingAllocation;
    _loggedUser = getLoggedUserUseCase(GetLoggedUserParams());
    _onBackPressed = onBackPressed;
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
    return _loggedUser.companyCode;
  }

  @override
  void findProductByBarCode(String barcode) {
    _foundProduct = _inventoryCountingAllocation.products.firstWhere((e) => e.code == barcode, orElse: () => null);

    if (_foundProduct == null) {
      _notFoundProductCode = barcode;
    }
    update();
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

  @override
  void registerFoundProduct(String quantity) async {
    if (_foundProduct != null) {
      try {
        final parsedQuantity = double.parse(quantity);
        loadingProvider.showFullscreenLoading();

        final registerCountingResult = await registerCountingUseCase(RegisterCountingParams(
            inventoryAllocation: _inventoryCountingAllocation.employeeInventoryAllocation,
            inventoryCode: _inventoryCountingAllocation.beepInventory.id,
            inventoryProduct: InventoryProduct(
                code: _foundProduct.code,
                inventoryProductPackaging: _foundProduct.inventoryProductPackaging,
                name: _foundProduct.name,
                quantity: parsedQuantity)));

        loadingProvider.hideFullscreenLoading();
        if (registerCountingResult != null) {
          registerCountingResult.fold(_handleFailure, null);
          return;
        }

        feedbackMessageProvider.showOneButtonDialog(
            registerCountingPageRegisterProductSuccessTitle, registerCountingPageRegisterProductSuccessMessage);
        resetFoundProduct();
      } on FormatException {
        feedbackMessageProvider.showOneButtonDialog(
            registerCountingPageFormatErrorTitle, registerCountingPageFormatErrorMessage);
      }
    }
  }

  void _handleFailure(Failure failure) {
    feedbackMessageProvider.showOneButtonDialog(failure.title, failure.message);
  }

  @override
  String getNotFoundProductCode() {
    return _notFoundProductCode;
  }

  @override
  void resetNotFoundProduct() {
    _notFoundProductCode = null;
    update();
  }

  @override
  BeepUser getLoggedUser() {
    return _loggedUser;
  }

  @override
  String getAllocationSession() {
    return _inventoryCountingAllocation.employeeInventoryAllocation.session;
  }

  @override
  void setSelectedProduct(InventoryProduct selectedProduct) {
    this._foundProduct = selectedProduct;
    update();
  }

  @override
  void finishAllocation() async {
    loadingProvider.showFullscreenLoading();

    final changeAllocationStatusResult = await changeAllocationStatusUseCase(ChangeAllocationStatusParams(
        inventoryAllocation: _inventoryCountingAllocation.employeeInventoryAllocation,
        inventoryCode: _inventoryCountingAllocation.beepInventory.id));

    loadingProvider.hideFullscreenLoading();

    if (changeAllocationStatusResult != null) {
      changeAllocationStatusResult.fold(_handleFailure, (r) => null);
      return;
    }
    router.back();
    _onBackPressed();
  }
}
