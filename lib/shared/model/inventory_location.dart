import 'package:equatable/equatable.dart';

class InventoryLocation extends Equatable {
  final String name, description;

  InventoryLocation({this.name, this.description});

  Map<String, dynamic> toJson() {
    return {'name': name, 'description': description};
  }

  factory InventoryLocation.fromJson(Map<String, dynamic> json) {
    return InventoryLocation(
      name: json['name'],
      description: json['description']
    );
  }

  @override
  List<Object> get props => [name, description];
}
