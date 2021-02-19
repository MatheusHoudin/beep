import 'package:beep/core/constants/colors.dart';
import 'package:beep/shared/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: secondaryColor,
        body: Column(
          children: [
            CustomAppBar("CRIAR MINHA CONTA")
          ],
        ),
      ),
    );
  }
}
