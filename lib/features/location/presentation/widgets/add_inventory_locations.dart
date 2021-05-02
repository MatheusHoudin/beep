import 'package:flutter/material.dart';

import '../../../../core/constants/dimens.dart';
import '../../../../core/constants/texts.dart';
import '../../../../shared/widgets/main_text_field.dart';
import '../../../../shared/widgets/main_text_field.dart';

class AddInventoryLocation extends StatelessWidget {
  final TextEditingController locationNameController = TextEditingController();
  final TextEditingController locationDescriptionController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        LocationNameField(),
        LocationDescriptionField()
      ],
    );
  }

  Widget LocationNameField() {
    return Container(
      margin: EdgeInsets.only(
        bottom: smallSize,
      ),
      child: MainTextField(
        hint: addInventoryLocationLocationNameFieldHint,
        controller: locationNameController,
        textInputType: TextInputType.name,
      ),
    );
  }

  Widget LocationDescriptionField() {
    return MainTextField(
      hint: addInventoryLocationLocationDescriptionFieldHint,
      controller: locationDescriptionController,
      textInputType: TextInputType.name,
      isMultiline: true,
    );
  }
}
