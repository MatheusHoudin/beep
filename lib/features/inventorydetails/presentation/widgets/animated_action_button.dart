import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AnimatedActionButton extends StatelessWidget {
  final double progress;
  final Widget child;
  final int position;

  AnimatedActionButton({this.progress, this.child, this.position});

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      width: Get.size.width,
      height: 56,
      duration: Duration(milliseconds: 250),
      bottom: position * progress,
      child: child,
    );
  }
}
