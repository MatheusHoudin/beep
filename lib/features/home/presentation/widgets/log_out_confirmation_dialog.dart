import 'package:beep/core/constants/texts.dart';
import 'package:beep/features/home/domain/controller/home_router_controller.dart';
import 'package:beep/shared/widgets/two_buttons_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LogOutConfirmationDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TwoButtonsDialog(
      title: logOutConfirmationDialogTitle,
      message: logOutConfirmationDialogMessage,
      confirmText: logOutConfirmationDialogConfirm,
      cancelText: logOutConfirmationDialogCancel,
      confirmFunction: () => Get.find<HomeRouterController>().logOut(),
      cancelFunction: () => Get.back(),
    );
  }
}