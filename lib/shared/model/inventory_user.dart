import 'package:equatable/equatable.dart';

class InventoryUser extends Equatable {
  final String name, email;

  InventoryUser({this.name, this.email});

  factory InventoryUser.fromJson(Map<String, dynamic> json) {
    return InventoryUser(
      name: json['name'],
      email: json['email']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email
    };
  }

  @override
  List<Object> get props => throw UnimplementedError();
}
