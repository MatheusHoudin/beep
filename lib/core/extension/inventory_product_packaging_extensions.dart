import 'package:beep/shared/model/inventory_product_packaging.dart';

extension InventoryProductPackagingExtensions on InventoryProductPackaging {
  String convertInventoryProductPackagingToString() {
    switch(this) {
      case InventoryProductPackaging.KG: return 'KG';
      case InventoryProductPackaging.UND: return 'UND';
    }
  }
}
