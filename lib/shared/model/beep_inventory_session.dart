import 'package:beep/shared/model/beep_inventory.dart';
import 'package:equatable/equatable.dart';

class BeepInventorySession extends Equatable {
  final BeepInventory beepInventory;
  final String session;

  BeepInventorySession({this.beepInventory, this.session});

  @override
  List<Object> get props => [beepInventory, session];
}
