import 'package:equatable/equatable.dart';

class InventoryLocation extends Equatable {
  final String name, description;

  InventoryLocation({this.name, this.description});

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description
    };
  }

  @override
  List<Object> get props => [name, description];
}
