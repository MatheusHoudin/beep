import 'package:beep/core/constants/assets.dart';
import 'package:beep/core/constants/colors.dart';
import 'package:beep/core/constants/dimens.dart';
import 'package:beep/core/constants/texts.dart';
import 'package:beep/features/inventoryemployees/domain/controller/register_inventory_employee_controller.dart';
import 'package:beep/features/inventoryemployees/presentation/widgets/inventory_employee.dart';
import 'package:beep/shared/model/beep_inventory.dart';
import 'package:beep/shared/widgets/app_bar_details_section.dart';
import 'package:beep/shared/widgets/custom_app_bar.dart';
import 'package:beep/shared/widgets/main_text_field.dart';
import 'package:beep/shared/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class InventoryEmployees extends StatelessWidget {

  final TextEditingController userEmailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: GetBuilder<RegisterInventoryEmployeeController>(
          initState: (_) {
            Get.find<RegisterInventoryEmployeeController>().initialize(
                Get.arguments as BeepInventory
            );
          },
          builder: (c) => Column(
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
                      top: normalSize,
                      right: normalSize,
                      left: normalSize
                  ),
                  child: Column(
                    children: [
                      EmployeeEmailField(),
                      SizedBox(height: smallSize,),
                      AddEmployeeToInventoryButton(c),
                      SizedBox(height: mediumSize,),
                      Expanded(child: RegisteredInventoryEmployees())
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
      style: GoogleFonts.firaSans(
        fontSize: smallTextSize,
        color: grayTextColor
      ),
    );
  }

  Widget EmployeeEmailField() {
    return MainTextField(
      hint: registerInventoryEmployeeHint,
      isFilled: true,
      controller: userEmailController,
    );
  }

  Widget AddEmployeeToInventoryButton(RegisterInventoryEmployeeController c) {
    return PrimaryButton(
      buttonText: registerInventoryEmployeeButton,
      shouldExpand: true,
      onPressedCallback: () => c.registerInventoryEmployee(userEmailController.text),
    );
  }
  
  Widget RegisteredInventoryEmployees() {
    return ListView(
      scrollDirection: Axis.vertical,
      children: [
        InventoryEmployee(employeeName: "Matheus Gomes", employeeEmail: "matheus@gmail.com.bt",),
        InventoryEmployee(employeeName: "Maria Gomes", employeeEmail: "matheus@gmail.com.bt",),
        InventoryEmployee(employeeName: "João Gomes", employeeEmail: "matheus@gmail.com.bt",),
        InventoryEmployee(employeeName: "Teste Gomes", employeeEmail: "matheus@gmail.com.bt",),
        InventoryEmployee(employeeName: "Bruna Gomes", employeeEmail: "matheus@gmail.com.bt",),
      ],
    );
  }
}
