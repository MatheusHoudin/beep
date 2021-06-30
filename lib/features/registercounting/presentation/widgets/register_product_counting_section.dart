import 'package:beep/core/constants/colors.dart';
import 'package:beep/core/constants/dimens.dart';
import 'package:beep/features/registercounting/domain/controller/register_counting_controller.dart';
import 'package:beep/shared/model/inventory_product.dart';
import 'package:beep/core/constants/texts.dart';
import 'package:beep/core/extension/inventory_product_packaging_extensions.dart';
import 'package:beep/shared/widgets/main_text_field.dart';
import 'package:beep/shared/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterProductCountingSection extends StatelessWidget {
  final InventoryProduct inventoryProduct;
  final TextEditingController quantityController = TextEditingController();

  RegisterProductCountingSection({this.inventoryProduct});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ProductInfoSection(registerCountingPageProductName, inventoryProduct.name),
          SizedBox(
            height: smallSize,
          ),
          Row(
            children: [
              Expanded(child: ProductInfoSection(registerCountingPageProductCode, inventoryProduct.code)),
              Expanded(
                child: ProductInfoSection(registerCountingPageProductPackaging,
                    inventoryProduct.inventoryProductPackaging.convertInventoryProductPackagingToString()),
              )
            ],
          ),
          SizedBox(
            height: smallSize,
          ),
          ProductQuantityTextField(),
          SizedBox(
            height: mediumSize,
          ),
          Column(
            children: [
              RegisterButton(),
              SizedBox(
                height: normalSize,
              ),
              CancelButton()
            ],
          )
        ],
      ),
    );
  }

  Widget ProductInfoSection(String title, String info) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title,
          style: GoogleFonts.firaSans(color: Colors.white, fontWeight: FontWeight.bold, fontSize: mediumTextSize),
        ),
        SizedBox(
          height: mediumSmallSize,
        ),
        Text(
          info,
          style: GoogleFonts.firaSans(color: countingGray, fontSize: normalTextSize),
        )
      ],
    );
  }

  Widget ProductQuantityTextField() {
    return MainTextField(
      hint: registerCountingPageQuantityHint,
      textInputType: TextInputType.number,
      controller: quantityController,
    );
  }

  Widget CancelButton() {
    return PrimaryButton(
      buttonText: registerCountingPageCancelButton,
      shouldExpand: true,
      buttonColor: secondaryNegativeColor,
      onPressedCallback: () => Get.find<RegisterCountingController>().resetFoundProduct(),
    );
  }

  Widget RegisterButton() {
    return PrimaryButton(
      buttonText: registerCountingPageRegisterButton,
      shouldExpand: true,
      buttonColor: primaryColor,
      onPressedCallback: () => Get.find<RegisterCountingController>().registerFoundProduct(quantityController.text),
    );
  }
}
