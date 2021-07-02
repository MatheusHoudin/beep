import 'dart:async';

import 'package:beep/core/constants/assets.dart';
import 'package:beep/core/constants/colors.dart';
import 'package:beep/core/constants/dimens.dart';
import 'package:beep/core/constants/texts.dart';
import 'package:beep/core/utils/custom_beep_feedback_message.dart';
import 'package:beep/features/employeeinventoryallocations/domain/controller/employee_inventory_allocations_controller.dart';
import 'package:beep/features/registercounting/domain/controller/register_counting_controller.dart';
import 'package:beep/features/registercounting/presentation/widgets/counting_action_toggle.dart';
import 'package:beep/features/registercounting/presentation/widgets/counting_products_section.dart';
import 'package:beep/features/registercounting/presentation/widgets/finish_allocation_counting_button.dart';
import 'package:beep/features/registercounting/presentation/widgets/not_found_product_section.dart';
import 'package:beep/features/registercounting/presentation/widgets/register_product_counting_section.dart';
import 'package:beep/shared/model/inventory_counting_allocation.dart';
import 'package:beep/shared/model/inventory_product.dart';
import 'package:beep/shared/model/inventory_product_packaging.dart';
import 'package:beep/shared/widgets/custom_app_bar.dart';
import 'package:beep/shared/widgets/fullscreen_loading.dart';
import 'package:beep/shared/widgets/inventory_product_list_item.dart';
import 'package:beep/shared/widgets/main_text_field.dart';
import 'package:beep/shared/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_qr_bar_scanner/qr_bar_scanner_camera.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterCountingPage extends StatefulWidget {
  @override
  _RegisterCountingPageState createState() => _RegisterCountingPageState();
}

class _RegisterCountingPageState extends State<RegisterCountingPage> {
  bool isCameraVisible = true;
  Timer readBarCodeDeboucer;
  final TextEditingController barcodeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final inventoryAllocation = Get.arguments as InventoryCountingAllocation;
    final onBackPressed = () => Get.find<EmployeeInventoryAllocationsController>()
        .fetchEmployeeInventoryData(false, inventoryAllocation.employeeInventoryAllocation);
    Get.find<RegisterCountingController>().initialize(inventoryAllocation, onBackPressed);
  }

  @override
  void dispose() {
    readBarCodeDeboucer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: secondaryColor,
        body: GetBuilder<RegisterCountingController>(
          builder: (c) => Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CustomAppBar(
                isWhiteStyle: false,
                isCountingHeader: true,
                hasIcon: true,
                icon: inventoryItemIcon,
                appBarTitle: c.getInventoryName(),
                onBackPressed: () => null,
              ),
              LocationText(c.getLocationName()),
              Expanded(child: ContentSection(c))
            ],
          ),
        ),
      ),
    );
  }

  Widget LocationText(String location) {
    return Text(
      location,
      textAlign: TextAlign.center,
      style: GoogleFonts.firaSans(color: countingGray, fontSize: normalTextSize),
    );
  }

  Widget ContentSection(RegisterCountingController controller) {
    final foundProduct = controller.getFoundInventoryProduct();
    final notFoundProductCode = controller.getNotFoundProductCode();
    return Container(
      width: Get.size.width,
      padding: EdgeInsets.only(top: mediumSize, left: normalSize, right: normalSize),
      child: ListView(
        scrollDirection: Axis.vertical,
        children: [
          foundProduct == null && notFoundProductCode == null
              ? RegisterProductSection(controller)
              : (foundProduct != null
                  ? RegisterProductCountingSection(
                      inventoryProduct: foundProduct,
                    )
                  : NotFoundProductSection(
                      productCode: notFoundProductCode,
                    )),
          SizedBox(
            height: largeSize,
          ),
          RegisteredProductsSection(controller)
        ],
      ),
    );
  }

  Widget RegisterProductSection(RegisterCountingController controller) {
    return Column(
      children: [
        CountingActionsSection(),
        SizedBox(
          height: normalSize,
        ),
        ManualBarcodeSection(controller),
        SizedBox(
          height: normalSize,
        ),
        BarcodeCameraSection(controller),
        SizedBox(
          height: smallSize,
        ),
        CameraInstructionsSection(),
        SizedBox(
          height: normalSize,
        ),
        FinishCountingButton(controller),
      ],
    );
  }

  Widget CountingActionsSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        CameraToggleAction(),
        SizedBox(
          width: smallSize,
        ),
        FlashlightToggleAction()
      ],
    );
  }

  Widget CameraToggleAction() {
    return CountingActionToggle(
      color: isCameraVisible ? secondaryNegativeColor : primaryColor,
      icon: Icon(
        isCameraVisible ? Icons.visibility_off_outlined : Icons.visibility_outlined,
        color: Colors.white,
      ),
      onClick: () => toggleCameraVisibility(),
    );
  }

  void toggleCameraVisibility() {
    setState(() {
      isCameraVisible = !isCameraVisible;
    });
  }

  Widget FlashlightToggleAction() {
    return CountingActionToggle(
        color: primaryColor,
        icon: Icon(
          Icons.flash_off,
          color: Colors.white,
        ),
        onClick: () => showNotImplementedSnackbar());
  }

  Widget ManualBarcodeSection(RegisterCountingController controller) {
    return Column(
      children: [
        BarcodeTextField(),
        SizedBox(
          height: normalSize,
        ),
        SearchProductByBarcodeButton(controller)
      ],
    );
  }

  Widget BarcodeTextField() {
    return MainTextField(
      hint: registerCountingPageBarcodeHint,
      textInputType: TextInputType.number,
      controller: barcodeController,
    );
  }

  Widget SearchProductByBarcodeButton(RegisterCountingController controller) {
    return PrimaryButton(
      buttonText: registerCountingPageSearchByBarcode,
      shouldExpand: true,
      onPressedCallback: () => controller.findProductByBarCode(barcodeController.text),
    );
  }

  Widget BarcodeCameraSection(RegisterCountingController controller) {
    return Visibility(
      visible: isCameraVisible,
      child: Container(
        height: Get.size.height * 0.4,
        child: QRBarScannerCamera(
          fit: BoxFit.fill,
          notStartedBuilder: (_) => FullScreenLoading(
            width: Get.size.width,
            height: Get.size.height * 0.4,
          ),
          qrCodeCallback: (barcode) => _readBarCodeWithDebouce(barcode, controller),
        ),
      ),
    );
  }

  void _readBarCodeWithDebouce(String barcode, RegisterCountingController controller) {
    if (readBarCodeDeboucer?.isActive ?? false) readBarCodeDeboucer.cancel();

    readBarCodeDeboucer = Timer(Duration(milliseconds: 100), () {
      controller.findProductByBarCode(barcode);
    });
  }

  Widget CameraInstructionsSection() {
    return Text(
      isCameraVisible ? registerCountingPageCameraInstructions : registerCountingPageTurnOnCameraMessage,
      textAlign: TextAlign.center,
      style: GoogleFonts.firaSans(color: Colors.white),
    );
  }

  Widget FinishCountingButton(RegisterCountingController controller) {
    return FinishAllocationCountingButton(
      companyCode: controller.getLoggedUserCompanyCode(),
      inventoryCode: controller.getInventoryCode(),
      inventoryLocation: controller.getInventoryLocation(),
      loggedUser: controller.getLoggedUser(),
      session: controller.getAllocationSession(),
      onPressed: controller.finishAllocation,
    );
  }

  Widget RegisteredProductsSection(RegisterCountingController controller) {
    return CountingProductsSection(
      companyCode: controller.getLoggedUserCompanyCode(),
      inventoryCode: controller.getInventoryCode(),
      inventoryLocation: controller.getInventoryLocation(),
      loggedUser: controller.getLoggedUser(),
      session: controller.getAllocationSession(),
    );
  }

  Widget InventoryProductItem(InventoryProduct inventoryProduct) {
    return Container(
      margin: EdgeInsets.only(bottom: mediumSmallSize),
      child: InventoryProductListItem(
        inventoryProduct: inventoryProduct,
        shouldShowProductCount: true,
      ),
    );
  }
}
