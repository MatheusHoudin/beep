import 'package:beep/core/constants/dimens.dart';
import 'package:beep/core/constants/texts.dart';
import 'package:beep/shared/model/beep_user.dart';
import 'package:beep/shared/model/inventory_location.dart';
import 'package:beep/shared/model/inventory_product.dart';
import 'package:beep/shared/widgets/inventory_product_list_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class CountingProductsSection extends StatelessWidget {
  final String companyCode, inventoryCode;
  final InventoryLocation inventoryLocation;
  final BeepUser loggedUser;
  final String session;

  CountingProductsSection(
      {this.companyCode, this.inventoryCode, this.inventoryLocation, this.loggedUser, this.session});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.size.height * 0.6,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            registerCountingPageLastRegisteredProducts,
            textAlign: TextAlign.start,
            style: GoogleFonts.firaSans(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: normalSize,
          ),
          StreamBuilder<QuerySnapshot>(
              stream: getInventoryAllocationCountedProductsSnapshot(),
              builder: (context, snapshot) {
                if (snapshot.hasError || snapshot.connectionState == ConnectionState.waiting) return Container();

                return FutureBuilder<QuerySnapshot>(
                  future: snapshot.data.docs.first.reference.collection('counting').orderBy('updatedAt', descending: true).get(),
                  builder: (_, countingResult) {
                    if (snapshot.hasError || snapshot.connectionState == ConnectionState.waiting) return Container();
                    if (countingResult.data == null) return Container();

                    final countingListResult =
                        countingResult.data.docs.map((e) => InventoryProduct.fromJson(e.data())).toList();
                    return Expanded(
                        child: ListView.builder(
                            itemCount: countingListResult.length,
                            itemBuilder: (_, index) => InventoryProductItem(countingListResult[index])));
                  },
                );
              })
        ],
      ),
    );
  }

  Stream<QuerySnapshot> getInventoryAllocationCountedProductsSnapshot() {
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

  Widget InventoryProductItem(InventoryProduct inventoryProduct) {
    return Container(
      margin: EdgeInsets.only(bottom: mediumSmallSize),
      child: InventoryProductListItem(
        inventoryProduct: inventoryProduct,
        shouldShowProductCount: true,
      ),
    );
  }
}
