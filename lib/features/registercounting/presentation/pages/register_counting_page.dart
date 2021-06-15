import 'package:beep/core/constants/assets.dart';
import 'package:beep/core/constants/colors.dart';
import 'package:beep/core/constants/dimens.dart';
import 'package:beep/features/registercounting/domain/controller/register_counting_controller.dart';
import 'package:beep/features/registercounting/presentation/widgets/counting_action_toggle.dart';
import 'package:beep/shared/model/inventory_counting_allocation.dart';
import 'package:beep/shared/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_qr_bar_scanner/qr_bar_scanner_camera.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterCountingPage extends StatefulWidget {
  @override
  _RegisterCountingPageState createState() => _RegisterCountingPageState();
}

class _RegisterCountingPageState extends State<RegisterCountingPage> {
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
              Expanded(child: ContentSection())
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

  Widget ContentSection() {
    return Padding(
      padding: EdgeInsets.only(top: mediumSize, left: normalSize, right: normalSize),
      child: Column(
        children: [
          CountingActionsSection(),
          BarcodeCameraSection()
        ],
      ),
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
      color: primaryColor,
      icon: Icon(
        Icons.visibility_outlined,
        color: Colors.white,
      ),
      onClick: () => null,
    );
  }

  Widget FlashlightToggleAction() {
    return CountingActionToggle(
      color: secondaryNegativeColor,
      icon: Icon(
        Icons.flash_off,
        color: Colors.white,
      ),
      onClick: () => null,
    );
  }

  Widget BarcodeCameraSection() {
    return Container(
      width: Get.size.width,
      height: Get.size.height * 0.4,
      child: QRBarScannerCamera(
        qrCodeCallback: (barcode) {
          print(barcode);
        },
      ),
    );
  }
}
