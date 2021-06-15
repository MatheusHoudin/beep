import 'package:beep/core/constants/assets.dart';
import 'package:beep/core/constants/colors.dart';
import 'package:beep/core/constants/dimens.dart';
import 'package:beep/features/registercounting/domain/controller/register_counting_controller.dart';
import 'package:beep/shared/model/inventory_counting_allocation.dart';
import 'package:beep/shared/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
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
              Expanded(child: Container())
            ],
          ),
        ),
      ),
    );
  }

  Widget LocationText(String location) {
    return Text(
      location,
      style: GoogleFonts.firaSans(color: countingGray, fontSize: normalTextSize),
    );
  }
}
