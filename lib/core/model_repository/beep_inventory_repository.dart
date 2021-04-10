import 'package:beep/shared/model/beep_inventory.dart';
import 'package:beep/shared/model/inventory_product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class BeepInventoryRepository {
  Future registerInventory(BeepInventory inventory, String companyCode);

  Future<List<BeepInventory>> fetchCompanyInventories(String companyCode);

  Future importInventoryProductsToInventory(
    String companyCode,
    String inventoryCode,
    List<InventoryProduct> inventoryProducts
  );

  Future<BeepInventory> fetchInventoryData(String companyCode, String inventoryId);
}

class BeepInventoryRepositoryImpl extends BeepInventoryRepository {
  final FirebaseFirestore firestore;

  BeepInventoryRepositoryImpl({this.firestore});

  @override
  Future registerInventory(BeepInventory inventory, String companyCode) async {
    try {
      await firestore
          .collection('companies')
          .doc(companyCode)
          .collection('inventories')
          .add(inventory.toJson());
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<List<BeepInventory>> fetchCompanyInventories(String companyCode) async {
    try {
      final inventoriesSnapshot = await firestore
          .collection('companies')
          .doc(companyCode)
          .collection('inventories')
          .get();

      return inventoriesSnapshot.docs
          .map((e) =>
              BeepInventory.fromJson(e.data()..putIfAbsent('id', () => e.id)))
          .toList();
    } catch (e) {
      throw e;
    }
  }

  @override
  Future importInventoryProductsToInventory(
    String companyCode,
    String inventoryCode,
    List<InventoryProduct> inventoryProducts
  ) async {
    try {
      await Future.wait(inventoryProducts
          .map((e) {
            return firestore
                .collection('companies')
                .doc(companyCode)
                .collection('inventories')
                .doc(inventoryCode)
                .collection('products')
                .doc(e.code)
                .set(
                  e.toJsonWithoutQuantityField(),
                  SetOptions(merge: true,)
                );
          }).toList());
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<BeepInventory> fetchInventoryData(String companyCode, String inventoryId) async {
    try {
      final inventorySnapshot = await firestore
          .collection('companies')
          .doc(companyCode)
          .collection('inventories')
          .doc(inventoryId)
          .get();
      final inventoryProducts = await inventorySnapshot.reference.collection('products').get();

      final data = inventorySnapshot.data();
      final inventoryDetailsJson = {
        'id': data['id'],
        'name': data['name'],
        'description': data['description'],
        'date': data['date'],
        'time': data['time'],
        'status': data['status'],
        'products': inventoryProducts.docs.map((e) => e.data()).toList()
      };
      return BeepInventory.fromJson(inventoryDetailsJson);
    } catch (e) {
      throw e;
    }
  }
}
