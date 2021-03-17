import 'package:equatable/equatable.dart';

class BeepInventory extends Equatable {
  final String name, date, time, description;

  BeepInventory({
    this.name,
    this.description,
    this.date,
    this.time
  });

  factory BeepInventory.fromJson(Map<String, dynamic> json) {
    return BeepInventory(
      name: json['name'],
      description: json['description'],
      date: json['date'],
      time: json['time']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'date': date,
      'time': time
    };
  }

  @override
  List<Object> get props => [
    this.name,
    this.description,
    this.date,
    this.time
  ];
}
