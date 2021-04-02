import 'package:beep/shared/model/beep_inventory_status.dart';
import 'package:beep/shared/model/inventory_product_packaging.dart';

extension StringExtensions on String {
  BeepInventoryStatus convertStringToBeepInventoryStatus() {
    switch(this) {
      case "NotStarted": return BeepInventoryStatus.NotStarted;
      case "Started": return BeepInventoryStatus.Started;
      case "Finished": return BeepInventoryStatus.Finished;
    }
  }

  InventoryProductPackaging convertStringToInventoryProductPackaging() {
    switch(this) {
      case "UND": return InventoryProductPackaging.UND;
      case "KG": return InventoryProductPackaging.KG;
    }
  }
}
