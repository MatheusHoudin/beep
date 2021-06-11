import 'package:equatable/equatable.dart';

class EmployeeAllocation extends Equatable {
  final String email, name;

  EmployeeAllocation({this.name, this.email});

  factory EmployeeAllocation.fromJson(Map<String, dynamic> json) {
    return EmployeeAllocation(
      name: json['name'],
      email: json['email']
    );
  }

  @override
  List<Object> get props => [email, name];
}
