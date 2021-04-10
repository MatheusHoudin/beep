import 'package:beep/shared/model/inventory_product_packaging.dart';
import 'package:equatable/equatable.dart';
import 'package:beep/core/extension/inventory_product_packaging_extensions.dart';
import 'package:beep/core/extension/string_extensions.dart';

class InventoryProduct extends Equatable {
  final String name, code;
  final double quantity;
  final InventoryProductPackaging inventoryProductPackaging;

  InventoryProduct({
    this.name,
    this.code,
    this.inventoryProductPackaging,
    this.quantity = 0.0
  });

  factory InventoryProduct.fromJson(Map<String, dynamic> json) {
    return InventoryProduct(
      name: json['name'],
      code: json['code'],
      quantity: json['quantity'] ?? 0.0,
      inventoryProductPackaging: json['packaging'].toString().convertStringToInventoryProductPackaging()
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'code': code,
      'quantity': quantity,
      'packaging': inventoryProductPackaging.convertInventoryProductPackagingToString()
    };
  }

  Map<String, dynamic> toJsonWithoutQuantityField() {
    return {
      'name': name,
      'code': code,
      'packaging': inventoryProductPackaging.convertInventoryProductPackagingToString()
    };
  }

  @override
  String toString() {
    return "Name: $name, Code: $code, Quantity: $quantity, Packaging: $inventoryProductPackaging";
  }

  @override
  List<Object> get props => [name, code, quantity, inventoryProductPackaging];
}
