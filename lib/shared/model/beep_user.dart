import 'package:equatable/equatable.dart';

class BeepUser extends Equatable {
  final String uid;
  final String name;
  final String email;
  final String type;
  final String companyCode;

  BeepUser({this.uid, this.name, this.email, this.type, this.companyCode});

  factory BeepUser.fromJson(Map<String, dynamic> json) {
    return BeepUser(
        uid: json['id'],
        email: json['email'],
        name: json['name'],
        type: json['type'],
        companyCode: json['companyCode']);
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email
    };
  }

  @override
  List<Object> get props => [this.uid, this.name, this.email, this.type, this.companyCode];
}
