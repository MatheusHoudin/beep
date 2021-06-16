import 'package:beep/core/constants/colors.dart';
import 'package:beep/core/constants/dimens.dart';
import 'package:beep/core/constants/texts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showNotImplementedSnackbar() {
  Get.showSnackbar(GetBar(
    title: genericErrorMessageTitle,
    message: notImplementedMessage,
    backgroundColor: primaryColor,
    borderRadius: 10.0,
    margin: EdgeInsets.only(left: normalSize, right: normalSize, bottom: normalSize),
    duration: Duration(seconds: 3),
  ));
}
