import 'package:beep/shared/model/beep_inventory_status.dart';
import 'package:equatable/equatable.dart';
import 'package:beep/core/extension/string_extensions.dart';
import 'package:beep/core/extension/beep_inventory_status_extensions.dart';

class BeepInventory extends Equatable {
  final String id, name, date, time, description;
  final BeepInventoryStatus status;

  BeepInventory({
    this.id,
    this.name,
    this.description,
    this.date,
    this.time,
    this.status = BeepInventoryStatus.NotStarted
  });

  factory BeepInventory.fromJson(Map<String, dynamic> json) {
    return BeepInventory(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      date: json['date'],
      time: json['time'],
      status: (json['status'] as String).convertStringToBeepInventoryStatus()
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'date': date,
      'time': time,
      'status': status.getName()
    };
  }

  @override
  List<Object> get props => [
    this.id,
    this.name,
    this.description,
    this.date,
    this.time,
    this.status
  ];
}
