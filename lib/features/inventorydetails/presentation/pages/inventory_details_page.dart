import 'package:beep/core/constants/assets.dart';
import 'package:beep/core/constants/colors.dart';
import 'package:beep/core/constants/dimens.dart';
import 'package:beep/features/inventorydetails/domain/controller/inventory_details_controller.dart';
import 'package:beep/features/inventorydetails/presentation/widgets/action_button.dart';
import 'package:beep/features/inventorydetails/presentation/widgets/expandable_fab.dart';
import 'package:beep/shared/model/beep_inventory.dart';
import 'package:beep/shared/model/beep_inventory_status.dart';
import 'package:beep/shared/model/inventory_product.dart';
import 'package:beep/shared/widgets/custom_app_bar.dart';
import 'package:beep/shared/widgets/empty_list.dart';
import 'package:beep/shared/widgets/inventory_products_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:beep/core/constants/texts.dart';

class InventoryDetailsPage extends StatefulWidget {

  @override
  _InventoryDetailsPageState createState() => _InventoryDetailsPageState();
}

class _InventoryDetailsPageState extends State<InventoryDetailsPage> {
  final PageController pageController = PageController(initialPage: 0);

  BeepInventory inventory;
  int selectedPage = 0;

  @override
  void initState() {
    super.initState();
    inventory = Get.arguments as BeepInventory;
    Get.find<InventoryDetailsController>().initialize(inventory.id);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        floatingActionButton: ExpandableFab(),
        body: Column(
          children: [
            CustomAppBar(
              appBarTitle: inventory.name,
              hasIcon: true,
              icon: inventoryItemIcon,
              isWhiteStyle: true,
            ),
            InventoryDetailsSection(),
            Expanded(child: ContentSection())
          ],
        ),
      ),
    );
  }

  Widget InventoryDetailsSection() {
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: smallSize,
          vertical: mediumSmallSize
      ),
      child: Column(
        children: [
          Text(
            inventory.description,
            style: GoogleFonts.firaSans(
                color: grayTextColor,
                fontSize: normalTextSize
            ),
          ),
          SizedBox(height: smallSize,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${inventory.date} às ${inventory.time}',
                textAlign: TextAlign.start,
                style: GoogleFonts.firaSans(
                    color: grayTextColor,
                    fontSize: smallTextSize
                ),
              ),
              SizedBox(height: mediumSmallSize,),
              InventoryStatus()
            ],
          ),
        ],
      ),
    );
  }

  Widget InventoryStatus() {
    return Row(
      children: [
        Container(
          height: smallSize,
          width: smallSize,
          decoration: BoxDecoration(
              color: getInventoryStatusColor(),
              shape: BoxShape.circle
          ),
        ),
        SizedBox(width: mediumSmallSize,),
        Text(
          getInventoryStatusName(),
          style: GoogleFonts.firaSans(
              color: secondaryColor
          ),
        )
      ],
    );
  }

  Color getInventoryStatusColor() {
    switch (inventory.status) {
      case BeepInventoryStatus.NotStarted:
        return notStartedInventoryBackground;
      case BeepInventoryStatus.Started:
        return positiveColor;
      default:
        return negativeColor;
    }
  }

  String getInventoryStatusName() {
    switch (inventory.status) {
      case BeepInventoryStatus.NotStarted:
        return notStartedInventory;
      case BeepInventoryStatus.Started:
        return startedInventory;
      default:
        return finishedInventory;
    }
  }

  Widget ContentSection() {
    return Container(
      color: secondaryColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ContentSectionNavigator(),
          Expanded(
            child: GetBuilder<InventoryDetailsController>(
              initState: (_) {
                Get.find<InventoryDetailsController>().fetchInventoryDetails();
              },
              builder: (c) {
                final beepInventory = c.getBeepInventoryDetails();
                return PageView(
                  controller: pageController,
                  onPageChanged: (page) {
                    setState(() {
                      selectedPage = page;
                    });
                  },
                  scrollDirection: Axis.horizontal,
                  children: [
                    ProductsSection(beepInventory?.inventoryProducts),
                    AddressesSection(),
                    AnalisysSection()
                  ],
                );
              },
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
      onTap: () =>
          pageController.animateToPage(
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

  Widget ProductsSection(List<InventoryProduct> inventoryProducts) {
    return inventoryProducts == null || inventoryProducts.isEmpty ?
    NoInventoryProducts() : InventoryProductsSection(inventoryProducts);
  }

  Widget NoInventoryProducts() {
    return EmptyList(
      message: emptyListMessage,
    );
  }

  Widget InventoryProductsSection(List<InventoryProduct> inventoryProducts) {
    return InventoryProductsList(inventoryProducts: inventoryProducts,);
  }

  Widget AddressesSection() {
    return Center(
      child: Text(
        addressesSectionTitle,
        style: GoogleFonts.firaSans(
          color: Colors.white
        )
      ),
    );
  }

  Widget AnalisysSection() {
    return Center(
      child: Text(
        analisysSectionTitle,
        style: GoogleFonts.firaSans(
          color: Colors.white
        )
      ),
    );
  }
}
