import 'package:beep/shared/model/beep_inventory.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class BeepInventoryRepository {
  Future registerInventory(BeepInventory inventory, String companyCode);
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
}
