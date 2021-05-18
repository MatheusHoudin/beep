import 'package:beep/features/home/presentation/widgets/home_header.dart';
import 'package:flutter/material.dart';

class EmployeeHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        HomeHeader(
          isCompany: false,
          loggedEntityName: "Matheus Gomes",
        ),
        Expanded(
          child: Center(
            child: Container(
              child: Text("EMPLOYEE"),
            ),
          ),
        )
      ],
    );
  }
}
