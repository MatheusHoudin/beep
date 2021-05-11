import 'package:beep/core/constants/assets.dart';
import 'package:beep/core/constants/colors.dart';
import 'package:beep/core/constants/dimens.dart';
import 'package:beep/features/inventorydetails/domain/controller/inventory_details_controller.dart';
import 'package:beep/features/inventorydetails/presentation/widgets/expandable_fab.dart';
import 'package:beep/features/inventorydetails/presentation/widgets/inventory_counting_session_section.dart';
import 'package:beep/shared/model/beep_inventory.dart';
import 'package:beep/shared/model/beep_inventory_status.dart';
import 'package:beep/shared/model/inventory_product.dart';
import 'package:beep/shared/widgets/custom_app_bar.dart';
import 'package:beep/shared/widgets/empty_list.dart';
import 'package:beep/shared/widgets/inventory_products_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
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
  bool isFabOpened = false;

  @override
  void initState() {
    inventory = Get.arguments as BeepInventory;
    Get.find<InventoryDetailsController>().initialize(inventory.id);
    super.initState();
  }

  void _setFabOptionsAreOpened(bool isOpened) {
    setState(() {
      this.isFabOpened = isOpened;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        floatingActionButton: ExpandableFab(
          onFabClickAction: _setFabOptionsAreOpened,
        ),
        body: Stack(
          children: [
            Content(),
            Visibility(
              visible: isFabOpened,
              child: Container(
                width: Get.size.width,
                height: Get.size.height,
                color: isFabOpened ? Colors.black.withOpacity(0.5) : Colors
                    .transparent,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget Content() {
    return Column(
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
                color: grayColor,
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
                    color: grayColor,
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
                SchedulerBinding.instance.addPostFrameCallback((_) {
                  Get.find<InventoryDetailsController>()
                      .fetchInventoryDetails();
                });
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
                    InventorySessionsSection(c)
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
            child: SectionNavigatorItem(productsSectionTitle, 0)
        ),
        Expanded(
            child: SectionNavigatorItem(inventorySessionsSectionTitle, 1)
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
      message: emptyProductListMessage,
    );
  }

  Widget InventoryProductsSection(List<InventoryProduct> inventoryProducts) {
    return InventoryProductsList(
      inventoryProducts: inventoryProducts,
      shouldShowProductCount: true,
    );
  }

  Widget InventorySessionsSection(InventoryDetailsController controller) {
    return InventoryCountingSessionSection(
      inventoryCountingSessions: controller.getInventorySessions(),
    );
  }
}
