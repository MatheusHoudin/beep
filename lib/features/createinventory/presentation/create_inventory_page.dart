import 'package:beep/core/constants/assets.dart';
import 'package:beep/core/constants/colors.dart';
import 'package:beep/core/constants/dimens.dart';
import 'package:beep/core/constants/texts.dart';
import 'package:beep/features/createinventory/domain/controller/create_inventory_controller.dart';
import 'package:beep/features/home/domain/controller/company_controller.dart';
import 'package:beep/shared/widgets/custom_app_bar.dart';
import 'package:beep/shared/widgets/main_text_field.dart';
import 'package:beep/shared/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class CreateInventoryPage extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController timeController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Get.find<CreateInventoryController>().initialize(() => Get.find<CompanyController>().fetchCompanyInventories());
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
              CreateInventoryForm(context)
            ],
          ),
        ),
      ),
    );
  }

  Widget CreateInventoryForm(BuildContext context) {
    return GetBuilder<CreateInventoryController>(
      builder: (c) => Padding(
        padding: EdgeInsets.symmetric(horizontal: mediumSize),
        child: Column(
          children: [
            NameField(),
            SizedBox(height: normalSize),
            DateField(context, c),
            SizedBox(height: normalSize),
            TimeField(context, c),
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
      textInputType: TextInputType.text,
    );
  }

  Widget DateField(BuildContext context, CreateInventoryController c) {
    dateController.text = c.getPickedDate();
    return GestureDetector(
      onTap: () => _handleDatePicker(context, c),
      child: AbsorbPointer(
        child: MainTextField(
            hint: createInventoryDateHint,
            controller: dateController,
            suffixIcon: _fieldIcon(datePicker),
            textInputType: TextInputType.text),
      ),
    );
  }

  void _handleDatePicker(BuildContext context, CreateInventoryController c) async {
    final DateTime pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2030),
        helpText: "Selecione a data inicial do inventário",
        cancelText: "Cancelar",
        confirmText: "Pronto",
        locale: Locale("pt", "BR"));

    c.setPickedDate(pickedDate);
  }

  Widget TimeField(BuildContext context, CreateInventoryController c) {
    timeController.text = c.getPickedTime();

    return GestureDetector(
      onTap: () => _handleTimePicker(context, c),
      child: AbsorbPointer(
        child: MainTextField(
          hint: createInventoryTimeHint,
          controller: timeController,
          suffixIcon: _fieldIcon(timePicker),
          textInputType: TextInputType.text,
        ),
      ),
    );
  }

  void _handleTimePicker(BuildContext context, CreateInventoryController c) async {
    final TimeOfDay time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      helpText: "Selecione a hora inicial do inventário",
      cancelText: "Agora não",
      confirmText: "Pronto",
      builder: (BuildContext context, Widget child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child,
        );
      },
    );

    c.setPickedTime(time);
  }

  Widget _fieldIcon(String icon) {
    return Padding(
      padding: EdgeInsets.all(smallSize),
      child: SvgPicture.asset(icon),
    );
  }

  Widget DescriptionField() {
    return MainTextField(
      hint: createInventoryDescriptionHint,
      controller: descriptionController,
      textInputType: TextInputType.multiline,
      isMultiline: true,
    );
  }

  Widget CreateInventoryButton(CreateInventoryController c) {
    return PrimaryButton(
      buttonText: createInventoryButtonText,
      shouldExpand: true,
      onPressedCallback: () => c.createInventory(nameController.value.text, descriptionController.value.text,
          dateController.value.text, timeController.value.text),
    );
  }
}
