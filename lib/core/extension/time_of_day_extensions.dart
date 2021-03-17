import 'package:flutter/material.dart';

extension TimeOfDayExtension on TimeOfDay {
  String convertTimeOfDayToHourMinuteString() {
    final hour = this.hour > 9 ? this.hour : "0${this.hour}";
    final minute = this.minute > 9 ? this.minute : "0${this.minute}";
    return "$hour:$minute";
  }
}
