import 'package:beep/core/constants/dimens.dart';
import 'package:beep/shared/widgets/empty_list.dart';
import 'package:beep/shared/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:beep/core/constants/texts.dart';

class InventoryCountingSessionSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: normalSize
      ),
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
      margin: EdgeInsets.symmetric(
        horizontal: mediumSize
      ),
      child: PrimaryButton(
        buttonText: createInventoryCountingSessionButton,
        shouldExpand: true,
        onPressedCallback: () => null
      ),
    );
  }

  Widget InventoryCountingSessionList() {
    return EmptyList(
      message: thereAreNoCreatedInventoryCountingSessions,
    );
  }
}
