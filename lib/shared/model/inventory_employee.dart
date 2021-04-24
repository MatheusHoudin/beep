import 'package:equatable/equatable.dart';

class InventoryEmployee extends Equatable {
  final String id, email, name;

  InventoryEmployee({
    this.id,
    this.email,
    this.name
  });

  factory InventoryEmployee.fromJson(Map<String, dynamic> json) {
    return InventoryEmployee(
      id: json['id'],
      email: json['email'],
      name: json['name']
    );
  }

  @override
  List<Object> get props => [id, email, name];
}
