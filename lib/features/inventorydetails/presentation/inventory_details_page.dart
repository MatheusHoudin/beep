import 'package:beep/core/constants/assets.dart';
import 'package:beep/core/constants/colors.dart';
import 'package:beep/core/constants/dimens.dart';
import 'package:beep/shared/model/beep_inventory.dart';
import 'package:beep/shared/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class InventoryDetailsPage extends StatefulWidget {

  @override
  _InventoryDetailsPageState createState() => _InventoryDetailsPageState();
}

class _InventoryDetailsPageState extends State<InventoryDetailsPage> {
  final PageController pageController = PageController(initialPage: 1);

  BeepInventory beepInventory;
  int selectedPage = 1;

  @override
  void initState() {
    beepInventory = Get.arguments as BeepInventory;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            CustomAppBar(
              appBarTitle: beepInventory.name,
              hasIcon: true,
              icon: inventoryItemIcon,
              isWhiteStyle: true,
            ),
            InventoryDescriptionSection(),
            Expanded(child: ContentSection())
          ],
        ),
      ),
    );
  }

  Widget InventoryDescriptionSection() {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: smallSize,
        vertical: mediumSmallSize
      ),
      child: Text(
        beepInventory.description,
        style: GoogleFonts.firaSans(
          color: disabledTextColor,
          fontSize: smallTextSize
        ),
      ),
    );
  }

  Widget ContentSection() {
    return Container(
      color: secondaryColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ContentSectionNavigator(),
          Expanded(
            child: PageView(
              controller: pageController,
              onPageChanged: (page) {
                setState(() {
                  selectedPage = page;
                });
              },
              scrollDirection: Axis.horizontal,
              children: [
                ProductsSection(),
                AddressesSection(),
                AnalisysSection()
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget ContentSectionNavigator() {
    return Row(
      children: [
        Expanded(
          child: SectionNavigatorItem('Produtos', 0)
        ),
        Expanded(
          child: SectionNavigatorItem('Endereços', 1)
        ),
        Expanded(
          child: SectionNavigatorItem('Análise', 2)
        ),
      ],
    );
  }

  Widget SectionNavigatorItem(String section, int pageNumber) {
    return InkWell(
      onTap: () => pageController.animateToPage(
        pageNumber,
        duration: Duration(milliseconds: 500),
        curve: Curves.ease
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: mediumSmallSize,
              vertical: smallSize
            ),
            child: Text(
              section,
              textAlign: TextAlign.center,
              style: GoogleFonts.firaSans(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: smallTextSize
              ),
            ),
          ),
          Visibility(
            visible: selectedPage == pageNumber,
            child: Container(
              color: primaryColor,
              height: miniSize
            ),
          )
        ],
      ),
    );
  }

  Widget ProductsSection() {
    return Center(
      child: Text(
        'Produtos',
        style: GoogleFonts.firaSans(
          color: Colors.white
        )
      ),
    );
  }

  Widget AddressesSection() {
    return Center(
      child: Text(
        'Endereços',
        style: GoogleFonts.firaSans(
          color: Colors.white
        )
      ),
    );
  }

  Widget AnalisysSection() {
    return Center(
      child: Text(
        'Análise',
        style: GoogleFonts.firaSans(
          color: Colors.white
        )
      ),
    );
  }
}
