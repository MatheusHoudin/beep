import 'package:beep/features/home/presentation/widgets/home_header.dart';
import 'package:flutter/material.dart';

class CompanyHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        HomeHeader(),
        Expanded(
          child: Container()
        )
      ],
    );
  }
}
