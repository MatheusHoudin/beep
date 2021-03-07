import 'package:beep/features/home/domain/router/controller/home_router_controller.dart';
import 'package:beep/features/home/presentation/company/company_home.dart';
import 'package:beep/features/home/presentation/employee/employee_home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeRouter extends StatefulWidget {
  @override
  _HomeRouterState createState() => _HomeRouterState();
}

class _HomeRouterState extends State<HomeRouter> {

  @override
  void initState() {
    Get.find<HomeRouterController>().setStartPage();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: GetBuilder<HomeRouterController>(
          builder: (c) => _handleHomePage(c.currentStartPage()),
        ),
      ),
    );
  }

  Widget _handleHomePage(String userType) {
    if (userType == 'company') {
      return CompanyHome();
    }
    return EmployeeHome();
  }
}
