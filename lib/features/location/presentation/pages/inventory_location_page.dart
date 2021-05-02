import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/constants/assets.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/constants/dimens.dart';
import '../../../../core/constants/texts.dart';
import '../../../../shared/widgets/app_bar_details_section.dart';
import '../../../../shared/widgets/custom_app_bar.dart';

class InventoryLocationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            CustomAppBar(
              isWhiteStyle: true,
              hasIcon: true,
              icon: inventoryDetailsAddressesIcon,
              appBarTitle: inventoryLocationsToolbarTitle,
              onBackPressed: () => null,
            ),
            AppBarDetailsSection(
              title: 'Enderecos',
              bottomSection: ImportInfoSection(),
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

  Widget ImportInfoSection() {
    return Text(
      inventoryLocationsInfo,
      textAlign: TextAlign.center,
      style:  GoogleFonts.firaSans(
        fontSize: smallTextSize, 
        color: grayTextColor
      ),
    );
  }
}
