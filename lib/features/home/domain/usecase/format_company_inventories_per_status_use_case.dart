import 'package:beep/core/usecase/base_use_case.dart';
import 'package:beep/shared/model/beep_inventory.dart';
import 'package:beep/shared/model/beep_inventory_status.dart';
import 'package:beep/shared/model/inventories_per_status.dart';

class FormatCompanyInventoriesPerStatusUseCase extends BaseUseCase<InventoriesPerStatus, List<BeepInventory>> {
  @override
  InventoriesPerStatus call(List<BeepInventory> params) {
    final notStartedInventories = _filterInventories(BeepInventoryStatus.NotStarted, params);
    final startedInventories = _filterInventories(BeepInventoryStatus.Started, params);
    final finishedInventories = _filterInventories(BeepInventoryStatus.Finished, params);

    return InventoriesPerStatus(
      notStartedInventories: notStartedInventories,
      finishedInventories: finishedInventories,
      startedInventories: startedInventories
    );
  }

  List<BeepInventory> _filterInventories(BeepInventoryStatus status, List<BeepInventory> inventories) {
    return inventories.where((e) => e.status == status).toList();
  }
}
