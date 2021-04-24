import 'package:beep/core/constants/assets.dart';
import 'package:beep/core/constants/colors.dart';
import 'package:beep/core/constants/dimens.dart';
import 'package:beep/core/constants/texts.dart';
import 'package:beep/features/inventoryemployees/domain/controller/inventory_employees_controller.dart';
import 'package:beep/features/inventoryemployees/presentation/widgets/inventory_employee.dart';
import 'package:beep/shared/model/beep_inventory.dart';
import 'package:beep/shared/widgets/app_bar_details_section.dart';
import 'package:beep/shared/widgets/custom_app_bar.dart';
import 'package:beep/shared/widgets/empty_list.dart';
import 'package:beep/shared/widgets/main_text_field.dart';
import 'package:beep/shared/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class InventoryEmployees extends StatelessWidget {
  final TextEditingController userEmailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: GetBuilder<InventoryEmployeesController>(
          initState: (_) {
            Get.find<InventoryEmployeesController>()
                .initialize(Get.arguments as BeepInventory);
            SchedulerBinding.instance.addPostFrameCallback((_) {
              Get.find<InventoryEmployeesController>()
                  .fetchInventoryEmployees();
            });
          },
          builder: (c) =>
              Column(
                children: [
                  CustomAppBar(
                    isWhiteStyle: true,
                    hasIcon: true,
                    icon: inventoryDetailsEmployeeIcon,
                    appBarTitle: inventoryEmployeesToolbarTitle,
                    onBackPressed: () => null,
                  ),
                  AppBarDetailsSection(
                    title: c.getInventoryName(),
                    bottomSection: ImportInfoSection(),
                  ),
                  Expanded(
                    child: Container(
                      color: secondaryColor,
                      padding: EdgeInsets.only(
                          top: normalSize, right: normalSize, left: normalSize),
                      child: Column(
                        children: [
                          EmployeeEmailField(),
                          SizedBox(
                            height: smallSize,
                          ),
                          AddEmployeeToInventoryButton(c),
                          SizedBox(
                            height: mediumSize,
                          ),
                          Expanded(child: RegisteredInventoryEmployees(c))
                        ],
                      ),
                    ),
                  )
                ],
              ),
        ),
      ),
    );
  }

  Widget ImportInfoSection() {
    return Text(
      inventoryEmployeesInfo,
      textAlign: TextAlign.center,
      style:
      GoogleFonts.firaSans(fontSize: smallTextSize, color: grayTextColor),
    );
  }

  Widget EmployeeEmailField() {
    return MainTextField(
      hint: registerInventoryEmployeeHint,
      isFilled: true,
      controller: userEmailController,
    );
  }

  Widget AddEmployeeToInventoryButton(InventoryEmployeesController c) {
    return PrimaryButton(
      buttonText: registerInventoryEmployeeButton,
      shouldExpand: true,
      onPressedCallback: () =>
          c.registerInventoryEmployee(userEmailController.text),
    );
  }

  Widget NoInventoryEmployees() {
    return EmptyList(
      message: emptyInventoryEmployeesListMessage,
    );
  }

  Widget RegisteredInventoryEmployees(InventoryEmployeesController c) {
    final inventoryEmployees = c.getInventoryEmployee();
    return inventoryEmployees.isEmpty
        ? NoInventoryEmployees()
        : ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: inventoryEmployees.length,
      itemBuilder: (context, index) =>
          InventoryEmployee(
            employeeEmail: inventoryEmployees[index].email,
            employeeName: inventoryEmployees[index].name,
          ),
    );
  }
}
