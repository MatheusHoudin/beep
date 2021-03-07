import 'package:equatable/equatable.dart';

class BeepUser extends Equatable {
  final String uid;
  final String name;
  final String email;
  final String type;
  BeepUser({this.uid, this.name, this.email, this.type});

  factory BeepUser.fromJson(Map<String, dynamic> json) {
    return BeepUser(
      uid: json['id'],
      email: json['email'],
      name: json['name'],
      type: json['type']
    );
  }

  @override
  List<Object> get props => [this.uid, this.name, this.email, this.type];
}
