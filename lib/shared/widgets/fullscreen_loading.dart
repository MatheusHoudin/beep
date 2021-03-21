import 'package:beep/core/constants/assets.dart';
import 'package:beep/core/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class FullScreenLoading extends StatefulWidget {
  final double height;
  final double width;

  FullScreenLoading({this.height, this.width});

  @override
  _FullScreenLoadingState createState() => _FullScreenLoadingState();
}

class _FullScreenLoadingState extends State<FullScreenLoading> with SingleTickerProviderStateMixin {

  Animation<double> animation;
  AnimationController controller;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(duration: Duration(seconds: 1), vsync: this);
    animation = Tween<double>(begin: 30, end: 120.0).animate(controller)
                ..addListener(() {
                  setState(() {});
                });

    controller.repeat();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset(
        beepLogo,
        width: animation.value,
        height: animation.value,
      ),
    );
  }
}

