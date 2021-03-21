import 'package:beep/shared/model/beep_inventory_status.dart';

extension BeepInventoryStatusConverter on BeepInventoryStatus {
  String getName() {
    switch(this) {
      case BeepInventoryStatus.NotStarted:
        return "NotStarted";
      case BeepInventoryStatus.Started:
        return "Started";
      default:
        return "Finished";
    }
  }
}
