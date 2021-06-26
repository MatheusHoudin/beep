import 'package:beep/core/error/failure.dart';
import 'package:beep/features/home/domain/usecase/get_logged_user_use_case.dart';
import 'package:beep/features/registercounting/domain/usecase/register_counting_use_case.dart';
import 'package:beep/shared/feedback/feedback_message_provider.dart';
import 'package:beep/shared/feedback/loading_provider.dart';
import 'package:beep/shared/model/inventory_counting_allocation.dart';
import 'package:beep/shared/model/inventory_location.dart';
import 'package:beep/shared/model/inventory_product.dart';
import 'package:get/get.dart';
import 'package:beep/core/constants/texts.dart';

abstract class RegisterCountingController extends GetxController {
  void initialize(InventoryCountingAllocation inventoryCountingAllocation);
  String getInventoryName();
  String getLocationName();
  InventoryLocation getInventoryLocation();
  String getInventoryCode();
  String getLoggedUserCompanyCode();
  InventoryProduct getFoundInventoryProduct();
  void findProductByBarCode(String barcode);
  void registerFoundProduct(String quantity);
  void resetFoundProduct();
}

class RegisterCountingControllerImpl extends RegisterCountingController {
  final GetLoggedUserUseCase getLoggedUserUseCase;
  final RegisterCountingUseCase registerCountingUseCase;
  final LoadingProvider loadingProvider;
  final FeedbackMessageProvider feedbackMessageProvider;

  InventoryCountingAllocation _inventoryCountingAllocation;
  InventoryProduct _foundProduct;

  RegisterCountingControllerImpl(
      {this.getLoggedUserUseCase, this.loadingProvider, this.feedbackMessageProvider, this.registerCountingUseCase});

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
      } on FormatException {
        feedbackMessageProvider.showOneButtonDialog(
            registerCountingPageFormatErrorTitle, registerCountingPageFormatErrorMessage);
      }
    }
  }

  void _handleFailure(Failure failure) {
    feedbackMessageProvider.showOneButtonDialog(failure.title, failure.message);
  }
}
