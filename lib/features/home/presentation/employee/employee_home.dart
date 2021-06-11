import 'package:beep/core/constants/dimens.dart';
import 'package:beep/core/constants/texts.dart';
import 'package:beep/features/home/domain/controller/employee_controller.dart';
import 'package:beep/features/home/presentation/widgets/home_header.dart';
import 'package:beep/features/home/presentation/widgets/inventory_item.dart';
import 'package:beep/shared/widgets/empty_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';

class EmployeeHome extends StatefulWidget {
  @override
  _EmployeeHomeState createState() => _EmployeeHomeState();
}

class _EmployeeHomeState extends State<EmployeeHome> {
  @override
  void initState() {
    Get.find<EmployeeController>().initialize();
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      Get.find<EmployeeController>().fetchEmployeeInventories();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EmployeeController>(
      builder: (c) {
        return Container(
          width: Get.size.width,
          height: Get.size.height,
          child: Column(
            children: [
              HomeHeader(isCompany: false, loggedUserName: c.getLoggedUserName()),
              SizedBox(
                height: smallSize,
              ),
              Expanded(
                child: c.getEmployeeInventories().isEmpty
                    ? NoEmployeeInventories()
                    : ListView.builder(
                        itemCount: c.getEmployeeInventories().length,
                        itemBuilder: (context, index) => InventoryItem(
                          inventory: c.getEmployeeInventories()[index],
                          onClicked: () => c.routeToInventoryAllocationsPage(index),
                        ),
                      ),
              )
            ],
          ),
        );
      },
    );
  }

  Widget NoEmployeeInventories() {
    return EmptyList(
      message: noEmployeeInventories,
    );
  }
}
