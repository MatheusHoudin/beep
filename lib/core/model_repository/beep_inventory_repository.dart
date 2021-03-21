import 'package:beep/shared/model/beep_inventory.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class BeepInventoryRepository {
  Future registerInventory(BeepInventory inventory, String companyCode);
  Future<List<BeepInventory>> fetchCompanyInventories(String companyCode);
}

class BeepInventoryRepositoryImpl extends BeepInventoryRepository {
  final FirebaseFirestore firestore;

  BeepInventoryRepositoryImpl({this.firestore});

  @override
  Future registerInventory(BeepInventory inventory, String companyCode) async {
    try {
      await firestore.collection('companies').doc(companyCode).update({
        'inventories': FieldValue.arrayUnion([inventory.toJson()])
      });
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<List<BeepInventory>> fetchCompanyInventories(String companyCode) async {
    try {
      final inventoriesSnapshot = await firestore.collection('companies')
                                    .doc(companyCode).get();

      return (inventoriesSnapshot.get('inventories') as List)
              .map((e) => BeepInventory.fromJson(e)).toList();
    } catch (e) {
      throw e;
    }
  }
}
