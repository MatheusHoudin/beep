import 'package:beep/shared/model/inventory_counting_session_type.dart';
import 'package:equatable/equatable.dart';

class InventoryCountingSession extends Equatable {
  final String name;
  final InventoryCountingSessionType type;

  InventoryCountingSession({this.name, this.type});

  factory InventoryCountingSession.fromJson(Map<String, dynamic> json) {
    return InventoryCountingSession(
      name: json['name'],
      type: json['type'] == 'Counting' ? InventoryCountingSessionType.Counting : InventoryCountingSessionType.Checking
    );
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'type': type == InventoryCountingSessionType.Counting ? 'Counting' : 'Checking'};
  }

  @override
  List<Object> get props => [name, type];
}
