import 'package:beep/shared/model/beep_inventory.dart';

class InventoriesPerStatus {
  final List<BeepInventory> notStartedInventories;
  final List<BeepInventory> startedInventories;
  final List<BeepInventory> finishedInventories;

  InventoriesPerStatus({
    this.finishedInventories,
    this.notStartedInventories,
    this.startedInventories
  });
}
