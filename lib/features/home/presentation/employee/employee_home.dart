import 'package:beep/features/home/domain/controller/employee_controller.dart';
import 'package:beep/features/home/presentation/widgets/home_header.dart';
import 'package:flutter/material.dart';
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
              Expanded(
                child: Container(),
              )
            ],
          ),
        );
      },
    );
  }
}
