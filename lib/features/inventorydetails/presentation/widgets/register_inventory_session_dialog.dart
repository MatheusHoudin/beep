import 'package:beep/core/constants/colors.dart';
import 'package:beep/core/constants/dimens.dart';
import 'package:beep/core/constants/texts.dart';
import 'package:beep/features/inventorydetails/domain/controller/inventory_details_controller.dart';
import 'package:beep/shared/widgets/base_dialog.dart';
import 'package:beep/shared/widgets/main_text_field.dart';
import 'package:beep/shared/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterInventorySessionDialog extends StatefulWidget {
  @override
  _RegisterInventorySessionDialogState createState() => _RegisterInventorySessionDialogState();
}

class _RegisterInventorySessionDialogState extends State<RegisterInventorySessionDialog> {
  final TextEditingController nameController = TextEditingController();
  String selectedInventorySessionType;
  List<String> inventorySessionTypeList = ['Contagem', 'Crítica'];

  @override
  Widget build(BuildContext context) {
    return BaseDialog(
      content: Content(),
    );
  }

  Widget Content() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Title(),
        SizedBox(
          height: mediumSize,
        ),
        NameField(),
        SizedBox(
          height: smallSize,
        ),
        SelectInventorySessionTypeDropdownButton(),
        SizedBox(
          height: mediumSize,
        ),
        RegisterInventorySessionButton()
      ],
    );
  }

  Widget Title() {
    return Text(
      createInventoryCountingSessionTitle,
      style: GoogleFonts.firaSans(color: Colors.black, fontWeight: FontWeight.bold),
    );
  }

  Widget NameField() {
    return MainTextField(
      hint: createInventoryCountingSessionNameHint, 
      controller: nameController,
      isDarkMode: false,
    );
  }

  Widget RegisterInventorySessionButton() {
    return PrimaryButton(
        buttonText: createInventoryCountingSessionAddButton,
        shouldExpand: true,
        onPressedCallback: () =>
            Get.find<InventoryDetailsController>().registerInventorySession(nameController.text, selectedInventorySessionType));
  }

  Widget SelectInventorySessionTypeDropdownButton() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(4.0)),
        border: Border.all(
          color: grayColor
        )
      ),
      padding: EdgeInsets.symmetric(
        horizontal: tinySize
      ),
      child: DropdownButton(
        value: selectedInventorySessionType,
        isExpanded: true,
        underline: null,
        hint: Text(
          selectInventorySessionTypeHint,
          style: GoogleFonts.firaSans(color: grayColor),
        ),
        onChanged: (value) {
          setState(() {
            this.selectedInventorySessionType = value;
          });
        },
        items: inventorySessionTypeList.map<DropdownMenuItem<String>>((e) => DropdownOption(e)).toList(),
      ),
    );
  }

  Widget DropdownOption(String value) {
    return DropdownMenuItem(
      value: value,
      child: Text(
        value,
        style: GoogleFonts.firaSans(),
      ),
    );
  }
}
