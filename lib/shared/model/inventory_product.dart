import 'package:beep/shared/model/inventory_product_packaging.dart';
import 'package:equatable/equatable.dart';

class InventoryProduct extends Equatable {
  final String name, code;
  final InventoryProductPackaging inventoryProductPackaging;

  InventoryProduct({
    this.name,
    this.code,
    this.inventoryProductPackaging
  });


  @override
  String toString() {
    return "Name: $name, Code: $code, Packaging: $inventoryProductPackaging";
  }

  @override
  List<Object> get props => [name, code, inventoryProductPackaging];
}
