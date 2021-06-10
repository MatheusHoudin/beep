import 'package:beep/core/constants/assets.dart';
import 'package:beep/core/constants/colors.dart';
import 'package:beep/core/constants/dimens.dart';
import 'package:beep/core/constants/texts.dart';
import 'package:beep/shared/widgets/app_bar_details_section.dart';
import 'package:beep/shared/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EmployeeInventoryAllocationsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            CustomAppBar(
              isWhiteStyle: true,
              hasIcon: true,
              icon: inventoryDetailsProductsIcon,
              appBarTitle: "nome do inventario",
              onBackPressed: () => null,
            ),
            AppBarDetailsSection(
              title: "",
              bottomSection: Text(
                employeeInventoryAllocationsInstructions,
                textAlign: TextAlign.center,
                style: GoogleFonts.firaSans(
                  fontSize: smallTextSize,
                  color: grayColor
                ),
              ),
            ),
            Expanded(
              child: Container(
                color: secondaryColor,
              ),
            )
          ],
        ),
      ),
    );
  }
}