import 'package:beep/core/constants/assets.dart';
import 'package:beep/core/constants/colors.dart';
import 'package:beep/core/constants/dimens.dart';
import 'package:beep/core/constants/texts.dart';
import 'package:beep/features/inventorycountingsessions/domain/controller/inventory_counting_sessions_controller.dart';
import 'package:beep/shared/model/beep_inventory_session.dart';
import 'package:beep/shared/widgets/app_bar_details_section.dart';
import 'package:beep/shared/widgets/custom_app_bar.dart';
import 'package:beep/shared/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class InventoryCountingSessionsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: secondaryColor,
        body: GetBuilder<InventoryCountingSessionsController>(
          initState: (_) {
            Get.find<InventoryCountingSessionsController>().initialize(Get.arguments as BeepInventorySession);
            SchedulerBinding.instance.addPostFrameCallback((_) {
              Get.find<InventoryCountingSessionsController>().fetchInventoryCountingSessionsOptions();
            });
          },
          builder: (controller) => Column(
            children: [
              CustomAppBar(
                isWhiteStyle: true,
                hasIcon: true,
                icon: inventoryItemIcon,
                appBarTitle: inventoryCountingSessionsAppBarTitle,
                onBackPressed: () => null,
              ),
              AppBarDetailsSection(
                title: controller.getInventoryTitle(),
                bottomSection: InventoryCountingSessionsInfoSection(),
              ),
              Expanded(child: Content(),)
            ],
          ),
        ),
      ),
    );
  }

  Widget Content() {
    return Container(
      margin: EdgeInsets.only(
        right: normalSize,
        left: normalSize,
        top: normalSize
      ),
      child: Column(
        children: [
          CreateCountingSessionButton()
        ],
      ),
    );
  }

  Widget InventoryCountingSessionsInfoSection() {
    return Text(
      inventoryCountingSessionsInfo,
      textAlign: TextAlign.center,
      style: GoogleFonts.firaSans(fontSize: smallTextSize, color: grayColor),
    );
  }

  Widget CreateCountingSessionButton() {
    return PrimaryButton(
      shouldExpand: true,
      buttonText: createInventoryCountingSessionButton,
      onPressedCallback: () => null,
    );
  }
}
