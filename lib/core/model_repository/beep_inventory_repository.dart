import 'package:beep/core/error/exception.dart';
import 'package:beep/features/inventoryemployees/presentation/widgets/inventory_employee.dart';
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

  Future registerInventoryEmployee(String companyCode, String inventoryId, String userEmail);
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
        'id': inventoryId,
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

  @override
  Future registerInventoryEmployee(String companyCode, String inventoryId, String userEmail) async {
    try {
      final foundUser = await firestore
          .collection('users')
          .where('email', isEqualTo: userEmail)
          .where('type', isNotEqualTo: 'company')
          .limit(1)
          .get();

      if (foundUser.docs.length == 0)
        throw InventoryUserNotFoundException();

      final inventoryUserWithNewUserEmail = await firestore
          .collection('companies')
          .doc(companyCode)
          .collection('inventories')
          .doc(inventoryId)
          .collection('employees')
          .where('email', isEqualTo: userEmail)
          .limit(1)
          .get();
      
      if (inventoryUserWithNewUserEmail.docs.length > 0)
        throw InventoryUserIsAlreadyRegisteredOnInventoryException();

      final userData = foundUser.docs.first.data();

      return await firestore
          .collection('companies')
          .doc(companyCode)
          .collection('inventories')
          .doc(inventoryId)
          .collection('employees')
          .add({
            'name': userData['name'],
            'id': userData['id'],
            'email': userData['email'],
          });
    } catch (e) {
      throw e;
    }
  }
}
