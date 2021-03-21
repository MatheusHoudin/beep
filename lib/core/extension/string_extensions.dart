import 'package:beep/shared/model/beep_inventory_status.dart';

extension StringExtensions on String {
  BeepInventoryStatus convertStringToBeepInventoryStatus() {
    switch(this) {
      case "NotStarted": return BeepInventoryStatus.NotStarted;
      case "Started": return BeepInventoryStatus.Started;
      case "Finished": return BeepInventoryStatus.Finished;
    }
  }
}
