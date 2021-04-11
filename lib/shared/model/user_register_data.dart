import 'package:equatable/equatable.dart';

class UserRegisterData extends Equatable {
  final String name;
  final String email;
  final String password;

  UserRegisterData({
    this.name,
    this.email,
    this.password
  });

  @override
  List<Object> get props => [
    this.name,
    this.email,
    this.password
  ];
}
