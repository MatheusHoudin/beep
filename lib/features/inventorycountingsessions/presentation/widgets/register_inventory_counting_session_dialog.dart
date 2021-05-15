import 'package:beep/core/constants/colors.dart';
import 'package:beep/core/constants/dimens.dart';
import 'package:beep/core/constants/texts.dart';
import 'package:beep/features/inventorycountingsessions/domain/controller/inventory_counting_sessions_controller.dart';
import 'package:beep/shared/model/inventory_employee.dart';
import 'package:beep/shared/widgets/base_dialog.dart';
import 'package:beep/shared/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterInventoryCountingSessionDialog extends StatefulWidget {
  final List<String> locations;
  final List<InventoryEmployee> employees;

  RegisterInventoryCountingSessionDialog({this.employees, this.locations});

  @override
  _RegisterInventoryCountingSessionDialogState createState() => _RegisterInventoryCountingSessionDialogState();
}

class _RegisterInventoryCountingSessionDialogState extends State<RegisterInventoryCountingSessionDialog> {
  String selectedEmployee, selectedLocation;

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
        SelectInventoryCountingSessionEmployeeDropdownButton(),
        SizedBox(
          height: smallSize,
        ),
        SelectInventoryCountingSessionLocationDropdownButton(),
        SizedBox(
          height: mediumSize,
        ),
        RegisterInventoryCountingSessionButton()
      ],
    );
  }

  Widget Title() {
    return Text(
      registerInventoryCountingSessionTitle,
      style: GoogleFonts.firaSans(color: Colors.black, fontWeight: FontWeight.bold),
    );
  }

  Widget RegisterInventoryCountingSessionButton() {
    return PrimaryButton(
        buttonText: createInventoryCountingSessionAddButton,
        shouldExpand: true,
        onPressedCallback: () =>
            Get.find<InventoryCountingSessionsController>().registerAllocation(selectedEmployee, selectedLocation));
  }

  Widget SelectInventoryCountingSessionEmployeeDropdownButton() {
    return Container(
      decoration:
          BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(4.0)), border: Border.all(color: grayColor)),
      padding: EdgeInsets.symmetric(horizontal: tinySize),
      child: DropdownButton(
        value: selectedEmployee,
        isExpanded: true,
        underline: null,
        hint: Text(
          selectInventoryCountingSessionEmployeeHint,
          style: GoogleFonts.firaSans(color: grayColor),
        ),
        onChanged: (value) {
          setState(() {
            selectedEmployee = value;
          });
        },
        items: widget.employees.map<DropdownMenuItem<String>>((e) => EmployeeDropdownOption(e.email, e.name)).toList(),
      ),
    );
  }

  Widget SelectInventoryCountingSessionLocationDropdownButton() {
    return Container(
      decoration:
          BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(4.0)), border: Border.all(color: grayColor)),
      padding: EdgeInsets.symmetric(horizontal: tinySize),
      child: DropdownButton(
        value: selectedLocation,
        isExpanded: true,
        underline: null,
        hint: Text(
          selectInventoryCountingSessionLocationHint,
          style: GoogleFonts.firaSans(color: grayColor),
        ),
        onChanged: (value) {
          setState(() {
            selectedLocation = value;
          });
        },
        items: widget.locations.map<DropdownMenuItem<String>>((e) => LocationDropdownOption(e)).toList(),
      ),
    );
  }

  Widget LocationDropdownOption(String value) {
    return DropdownMenuItem(
      value: value,
      child: Text(
        value,
        style: GoogleFonts.firaSans(),
      ),
    );
  }

  Widget EmployeeDropdownOption(String email, String name) {
    return DropdownMenuItem(
      value: email,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            style: GoogleFonts.firaSans(fontWeight: FontWeight.bold),
          ),
          Text(
            email,
            style: GoogleFonts.firaSans(),
          ),
        ],
      ),
    );
  }
}
