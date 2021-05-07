import 'package:beep/features/inventorylocations/domain/controller/inventory_location_controller.dart';
import 'package:beep/shared/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constants/dimens.dart';
import '../../../../core/constants/texts.dart';
import '../../../../shared/widgets/main_text_field.dart';

class AddInventoryLocationSection extends StatelessWidget {
  final TextEditingController locationNameController = TextEditingController();
  final TextEditingController locationDescriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        LocationNameField(),
        SizedBox(height: normalSize),
        LocationDescriptionField(),
        SizedBox(height: mediumSize),
        AddLocationButton()
      ],
    );
  }

  Widget LocationNameField() {
    return Container(
      margin: EdgeInsets.only(
        bottom: smallSize,
      ),
      child: MainTextField(
        hint: addInventoryLocationLocationNameFieldHint,
        controller: locationNameController,
        textInputType: TextInputType.name,
      ),
    );
  }

  Widget LocationDescriptionField() {
    return MainTextField(
      hint: addInventoryLocationLocationDescriptionFieldHint,
      controller: locationDescriptionController,
      textInputType: TextInputType.name,
      isMultiline: true,
    );
  }

  Widget AddLocationButton() {
    return PrimaryButton(
      buttonText: addInventoryLocationAddButton,
      shouldExpand: true,
      onPressedCallback: () => Get.find<InventoryLocationController>().registerInventoryLocation(
        locationNameController.text,
        locationDescriptionController.text
      ),
    );
  }
}
