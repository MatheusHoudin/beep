import 'package:beep/core/constants/colors.dart';
import 'package:beep/core/constants/dimens.dart';
import 'package:beep/core/constants/texts.dart';
import 'package:beep/features/createinventory/domain/controller/create_inventory_controller.dart';
import 'package:beep/shared/widgets/custom_app_bar.dart';
import 'package:beep/shared/widgets/main_text_field.dart';
import 'package:beep/shared/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateInventoryPage extends StatelessWidget {

  final TextEditingController nameController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController timeController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: secondaryColor,
        body: SingleChildScrollView(
          child: Column(
            children: [
              CustomAppBar(
                appBarTitle: createInventoryToolbarTitle,
                hasIcon: false,
              ),
              SizedBox(
                height: largeSize,
              ),
              CreateInventoryForm()
            ],
          ),
        ),
      ),
    );
  }

  Widget CreateInventoryForm() {
    return GetBuilder<CreateInventoryController>(
      builder: (c) => Padding(
        padding: EdgeInsets.symmetric(
          horizontal: mediumSize
        ),
        child: Column(
          children: [
            NameField(),
            SizedBox(height: normalSize),
            DateField(),
            SizedBox(height: normalSize),
            TimeField(),
            SizedBox(height: normalSize),
            DescriptionField(),
            SizedBox(height: mediumSize),
            CreateInventoryButton(c),
            SizedBox(height: normalSize)
          ],
        ),
      ),
    );
  }

  Widget NameField() {
    return MainTextField(
      hint: createInventoryNameHint,
      controller: nameController,
    );
  }

  Widget DateField() {
    return MainTextField(
      hint: createInventoryDateHint,
      controller: dateController,
    );
  }

  Widget TimeField() {
    return MainTextField(
      hint: createInventoryTimeHint,
      controller: timeController,
    );
  }

  Widget DescriptionField() {
    return MainTextField(
      hint: createInventoryDescriptionHint,
      controller: descriptionController,
    );
  }

  Widget CreateInventoryButton(CreateInventoryController c) {
    return PrimaryButton(
      buttonText: createInventoryButtonText,
      shouldExpand: true,
      onPressedCallback: () => c.createInventory(
        nameController.value.text,
        descriptionController.value.text,
        dateController.value.text,
        timeController.value.text
      ),
    );
  }
}
