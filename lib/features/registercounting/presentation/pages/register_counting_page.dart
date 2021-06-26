import 'package:beep/core/constants/assets.dart';
import 'package:beep/core/constants/colors.dart';
import 'package:beep/core/constants/dimens.dart';
import 'package:beep/core/constants/texts.dart';
import 'package:beep/core/utils/custom_beep_feedback_message.dart';
import 'package:beep/features/registercounting/domain/controller/register_counting_controller.dart';
import 'package:beep/features/registercounting/presentation/widgets/counting_action_toggle.dart';
import 'package:beep/features/registercounting/presentation/widgets/finish_allocation_counting_button.dart';
import 'package:beep/features/registercounting/presentation/widgets/register_product_counting_section.dart';
import 'package:beep/shared/model/inventory_counting_allocation.dart';
import 'package:beep/shared/model/inventory_product.dart';
import 'package:beep/shared/model/inventory_product_packaging.dart';
import 'package:beep/shared/widgets/custom_app_bar.dart';
import 'package:beep/shared/widgets/fullscreen_loading.dart';
import 'package:beep/shared/widgets/inventory_product_list_item.dart';
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

  @override
  void initState() {
    super.initState();
    Get.find<RegisterCountingController>().initialize(Get.arguments as InventoryCountingAllocation);
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
    return Container(
      width: Get.size.width,
      padding: EdgeInsets.only(top: mediumSize, left: normalSize, right: normalSize),
      child: ListView(
        scrollDirection: Axis.vertical,
        children: [
          foundProduct == null ? RegisterProductSection(controller) : RegisterProductCountingSection(inventoryProduct: foundProduct,),
          SizedBox(
            height: largeSize,
          ),
          RegisteredProductsSection()
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
          qrCodeCallback: (barcode) => controller.findProductByBarCode(barcode),
        ),
      ),
    );
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
    );
  }

  Widget RegisteredProductsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          registerCountingPageLastRegisteredProducts,
          textAlign: TextAlign.start,
          style: GoogleFonts.firaSans(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: normalSize,
        ),
        Column(
          children: [
            InventoryProduct(
                code: "3254634234343",
                inventoryProductPackaging: InventoryProductPackaging.KG,
                name: "Oleo de oliva natural 250ML",
                quantity: 20.5),
            InventoryProduct(
                code: "3254634234343",
                inventoryProductPackaging: InventoryProductPackaging.UND,
                name: "Oleo de oliva natural 250ML",
                quantity: 20.0),
            InventoryProduct(
                code: "3254634234343",
                inventoryProductPackaging: InventoryProductPackaging.KG,
                name: "Oleo de oliva natural 250ML",
                quantity: 20.0),
            InventoryProduct(
                code: "3254634234343",
                inventoryProductPackaging: InventoryProductPackaging.KG,
                name: "Oleo de oliva natural 250ML",
                quantity: 20.0),
            InventoryProduct(
                code: "3254634234343",
                inventoryProductPackaging: InventoryProductPackaging.KG,
                name: "Oleo de oliva natural 250ML",
                quantity: 20.0),
            InventoryProduct(
                code: "3254634234343",
                inventoryProductPackaging: InventoryProductPackaging.KG,
                name: "Oleo de oliva natural 250ML",
                quantity: 20.0),
            InventoryProduct(
                code: "3254634234343",
                inventoryProductPackaging: InventoryProductPackaging.KG,
                name: "Oleo de oliva natural 250ML",
                quantity: 20.0),
          ].map((e) => InventoryProductItem(e)).toList(),
        )
      ],
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
