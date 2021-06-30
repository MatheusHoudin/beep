import 'package:beep/core/constants/colors.dart';
import 'package:beep/core/constants/texts.dart';
import 'package:beep/shared/model/beep_user.dart';
import 'package:beep/shared/model/employee_inventory_allocation.dart';
import 'package:beep/shared/model/inventory_location.dart';
import 'package:beep/shared/widgets/primary_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FinishAllocationCountingButton extends StatelessWidget {
  final String companyCode, inventoryCode;
  final InventoryLocation inventoryLocation;
  final BeepUser loggedUser;
  final String session;
  final Function onPressed;

  FinishAllocationCountingButton({this.companyCode, this.inventoryCode, this.inventoryLocation, this.loggedUser, this.session, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: getInventoryAllocationStatusSnapshot(),
      builder: (context, snapshot) {
        if (snapshot.hasError || snapshot.connectionState == ConnectionState.waiting) return Container();

        final employeeInventoryAllocation = EmployeeInventoryAllocation.fromJson(snapshot.data.docs.first.data());

        return Visibility(
          visible: employeeInventoryAllocation.status == 'Started',
          child: FinishButton(),
        );
      },
    );
  }

  Stream<QuerySnapshot> getInventoryAllocationStatusSnapshot() {
    return FirebaseFirestore.instance
        .collection('companies')
        .doc(companyCode)
        .collection('inventories')
        .doc(inventoryCode)
        .collection('allocations')
        .where('location', isEqualTo: inventoryLocation.toJson())
        .where('employee', isEqualTo: loggedUser.toJson())
        .where('session', isEqualTo: session)
        .limit(1)
        .snapshots();
  }

  Widget FinishButton() {
    return PrimaryButton(
      buttonText: registerCountingPageFinishCounting,
      shouldExpand: true,
      buttonColor: secondaryNegativeColor,
      onPressedCallback: () => onPressed(),
    );
  }
}
