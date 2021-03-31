import 'package:flutter/material.dart';

class BaseDialog extends StatelessWidget {
  final Widget content;

  BaseDialog({this.content});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: Container(
        padding: EdgeInsets.all(Consts.padding),
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.all(Radius.circular(8))
        ),
        child: content,
      ),
    );
  }
}

class Consts {
  static const double padding = 16.0;
}
