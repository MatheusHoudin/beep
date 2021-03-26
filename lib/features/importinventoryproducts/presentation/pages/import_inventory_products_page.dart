import 'package:beep/core/constants/assets.dart';
import 'package:beep/core/constants/colors.dart';
import 'package:beep/core/constants/dimens.dart';
import 'package:beep/core/constants/texts.dart';
import 'package:beep/shared/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:googleapis/drive/v3.dart' as drive;
import 'package:google_sign_in/google_sign_in.dart' as signIn;

class ImportInventoryProductsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: ImportProductsFab(),
        body: Column(
          children: [
            CustomAppBar(
              isWhiteStyle: true,
              hasIcon: true,
              icon: inventoryDetailsProductsFabIcon,
              appBarTitle: importInventoryProductsToolbarTitle,
            ),
            ImportInfoSection(),
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

  void _login() async {
    final googleSignIn = signIn.GoogleSignIn.standard(scopes: [drive.DriveApi.driveReadonlyScope]);
    final signIn.GoogleSignInAccount account = await googleSignIn.signIn();
    print("User account $account");
  }

  Widget ImportProductsFab() {
    return FloatingActionButton(
      backgroundColor: primaryColor,
      onPressed: () => _login(),
      child: Icon(
        Icons.add,
        color: Colors.white,
      ),
    );
  }

  Widget ImportInfoSection() {
    return Container(
      width: Get.size.width,
      margin: EdgeInsets.only(
        bottom: mediumSmallSize
      ),
      padding: EdgeInsets.symmetric(
        horizontal: smallSize
      ),
      color: Colors.white,
      child: Column(
        children: [
          Text(
            'Frios e Congelados',
            style: GoogleFonts.firaSans(
              fontSize: normalTextSize,
              color: grayTextColor
            ),
          ),
          SizedBox(height: mediumSmallSize,),
          Text(
            importInventoryProductsInfo,
            textAlign: TextAlign.center,
            style: GoogleFonts.firaSans(
              fontSize: smallTextSize,
              color: grayTextColor
            ),
          ),
          Text(
            importInventoryProductsFieldsName,
            style: GoogleFonts.firaSans(
              fontSize: smallTextSize,
              color: grayTextColor,
              fontWeight: FontWeight.bold
            ),
          )
        ],
      ),
    );
  }
}
