import 'package:beep/features/home/domain/controller/company_controller.dart';
import 'package:beep/features/home/presentation/widgets/home_header.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CompanyHome extends StatefulWidget {
  @override
  _CompanyHomeState createState() => _CompanyHomeState();
}

class _CompanyHomeState extends State<CompanyHome> {

  @override
  void initState() {
    super.initState();
    Get.find<CompanyController>().getLoggedUser();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CompanyController>(
      builder: (c) {
        return Column(
          children: [
            HomeHeader(
              isCompany: true,
              companyName: c.getCompanyName(),
            ),
            Expanded(
                child: Container()
            )
          ],
        );
      }
    );
  }
}
