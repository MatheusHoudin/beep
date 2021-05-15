import 'package:beep/features/inventorycountingsessions/domain/controller/inventory_counting_sessions_controller.dart';
import 'package:beep/features/inventorycountingsessions/presentation/widgets/allocation_list_item.dart';
import 'package:beep/shared/model/inventory_counting_session_allocation.dart';
import 'package:beep/shared/widgets/empty_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:beep/core/constants/texts.dart';

class AllocationsListSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<InventoryCountingSessionsController>(
      initState: (_) {
        SchedulerBinding.instance.addPostFrameCallback((_) {
          Get.find<InventoryCountingSessionsController>().fetchInventoryCountingSessionAllocations();
        });
      },
      builder: (c) {
        final allocations = c.getAllocations();
        return allocations.isEmpty ? AllocationsEmptyList() : AllocationsList(allocations);
      },
    );
  }

  Widget AllocationsEmptyList() {
    return EmptyList(
      message: allocationsEmptyListMessage,
    );
  }

  Widget AllocationsList(List<InventoryCountingSessionAllocation> allocations) {
    return ListView.builder(
        itemCount: allocations.length,
        itemBuilder: (context, index) => AllocationListItem(
              allocation: allocations[index],
            ));
  }
}
