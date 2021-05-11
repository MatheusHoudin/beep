import 'package:beep/core/constants/dimens.dart';
import 'package:beep/features/inventorydetails/presentation/widgets/register_inventory_session_dialog.dart';
import 'package:beep/shared/model/inventory_counting_session.dart';
import 'package:beep/shared/widgets/empty_list.dart';
import 'package:beep/shared/widgets/primary_button.dart';
import 'package:beep/shared/widgets/simple_list_item.dart';
import 'package:flutter/material.dart';
import 'package:beep/core/constants/texts.dart';
import 'package:get/get.dart';

class InventoryCountingSessionSection extends StatelessWidget {
  final List<InventoryCountingSession> inventoryCountingSessions;

  InventoryCountingSessionSection({this.inventoryCountingSessions});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: normalSize),
      child: Column(
        children: [
          CreateInventoryCountingButton(),
          SizedBox(height: mediumSize),
          Expanded(
            child: InventoryCountingSessionList(),
          )
        ],
      ),
    );
  }

  Widget CreateInventoryCountingButton() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: mediumSize),
      child: PrimaryButton(
          buttonText: createInventoryCountingSessionButton,
          shouldExpand: true,
          onPressedCallback: () => Get.dialog(RegisterInventorySessionDialog())),
    );
  }

  Widget InventoryCountingSessionList() {
    return inventoryCountingSessions.isEmpty ? InventorySessionsEmpty() : InventorySessionsListView();
  }

  Widget InventorySessionsEmpty() {
    return EmptyList(
      message: thereAreNoCreatedInventoryCountingSessions,
    );
  }

  Widget InventorySessionsListView() {
    return ListView.builder(
      itemCount: inventoryCountingSessions.length,
      scrollDirection: Axis.vertical,
      itemBuilder: (context, index) => SimpleListItem(
        title: inventoryCountingSessions[index].name,
        description: '',
        hasDescription: false,
        isExpandedVertically: true,
      ),
    );
  }
}
