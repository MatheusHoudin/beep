import 'package:beep/core/constants/assets.dart';
import 'package:beep/core/constants/colors.dart';
import 'package:beep/core/constants/dimens.dart';
import 'package:beep/core/constants/texts.dart';
import 'package:beep/features/inventoryemployees/presentation/widgets/inventory_employee.dart';
import 'package:beep/shared/widgets/app_bar_details_section.dart';
import 'package:beep/shared/widgets/custom_app_bar.dart';
import 'package:beep/shared/widgets/main_text_field.dart';
import 'package:beep/shared/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InventoryEmployees extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            CustomAppBar(
              isWhiteStyle: true,
              hasIcon: true,
              icon: inventoryDetailsEmployeeIcon,
              appBarTitle: inventoryEmployeesToolbarTitle,
              onBackPressed: () => null,
            ),
            AppBarDetailsSection(
              title: "teste",
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
                    SearchEmployees(),
                    SizedBox(height: smallSize,),
                    AddEmployeeToInventoryButton(),
                    SizedBox(height: mediumSize,),
                    Expanded(child: RegisteredInventoryEmployees())
                  ],
                ),
              ),
            )
          ],
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

  Widget SearchEmployees() {
    return MainTextField(
      hint: registerInventoryEmployeeHint,
      isFilled: true,
    );
  }

  Widget AddEmployeeToInventoryButton() {
    return PrimaryButton(
      buttonText: registerInventoryEmployeeButton,
      shouldExpand: true,
      onPressedCallback: () => null,
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
