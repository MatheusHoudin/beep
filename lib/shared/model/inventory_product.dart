import 'package:beep/shared/model/inventory_product_packaging.dart';
import 'package:equatable/equatable.dart';
import 'package:beep/core/extension/inventory_product_packaging_extensions.dart';

class InventoryProduct extends Equatable {
  final String name, code;
  final InventoryProductPackaging inventoryProductPackaging;

  InventoryProduct({
    this.name,
    this.code,
    this.inventoryProductPackaging
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'code': code,
      'packaging': inventoryProductPackaging.convertInventoryProductPackagingToString()
    };
  }

  @override
  String toString() {
    return "Name: $name, Code: $code, Packaging: $inventoryProductPackaging";
  }

  @override
  List<Object> get props => [name, code, inventoryProductPackaging];
}
