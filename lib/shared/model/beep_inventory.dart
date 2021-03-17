import 'package:equatable/equatable.dart';

class BeepInventory extends Equatable {
  final String name, date, time, description, status;

  BeepInventory({
    this.name,
    this.description,
    this.date,
    this.time,
    this.status = "NotStarted"
  });

  factory BeepInventory.fromJson(Map<String, dynamic> json) {
    return BeepInventory(
      name: json['name'],
      description: json['description'],
      date: json['date'],
      time: json['time'],
      status: json['status']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'date': date,
      'time': time,
      'status': status
    };
  }

  @override
  List<Object> get props => [
    this.name,
    this.description,
    this.date,
    this.time,
    this.status
  ];
}
