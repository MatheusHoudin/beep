import 'package:beep/core/constants/colors.dart';
import 'package:beep/core/constants/dimens.dart';
import 'package:beep/shared/model/employee_inventory_allocation.dart';
import 'package:beep/shared/widgets/small_card_list_item.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InventoryAllocationItem extends StatelessWidget {
  final EmployeeInventoryAllocation employeeInventoryAllocation;

  InventoryAllocationItem({this.employeeInventoryAllocation});

  @override
  Widget build(BuildContext context) {
    final shouldShowStatus = employeeInventoryAllocation.status != 'NotStarted';
    return SmallCardListItem(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AllocationName(),
          AllocationDescription(),
          Visibility(
            visible: shouldShowStatus,
            child: Status(),
          )
        ],
      ),
    );
  }

  Widget AllocationName() {
    return Text(
      employeeInventoryAllocation.inventoryLocation.name,
      style: GoogleFonts.firaSans(fontWeight: FontWeight.bold, fontSize: normalTextSize, color: secondaryColor),
    );
  }

  Widget AllocationDescription() {
    return Text(
      employeeInventoryAllocation.inventoryLocation.description,
      style: GoogleFonts.firaSans(fontSize: normalTextSize, color: grayColor),
    );
  }

  Widget Status() {
    final statusName = employeeInventoryAllocation.status == 'Started' ? 'Iniciado' : 'Finalizado';
    final statusColor = employeeInventoryAllocation.status == 'Started' ? primaryColor : secondaryNegativeColor;

    return Padding(
      padding: EdgeInsets.only(top: mediumSmallSize),
      child: Text(
        statusName,
        textAlign: TextAlign.end,
        style: GoogleFonts.firaSans(fontSize: normalTextSize, color: statusColor),
      ),
    );
  }
}
