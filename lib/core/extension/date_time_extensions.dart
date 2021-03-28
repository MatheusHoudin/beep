extension DateTimeExtension on DateTime {
  String formatDateTimeToBrazilianDate() {
    final day = this.day > 9 ? this.day.toString() : "0${this.day}";
    final month = this.month > 9 ? this.month.toString() : "0${this.month}";
    final year = this.year;

    return "$day/$month/$year";
  }

  String formatDateTimeToBrazilianDateTime() {
    final date = this.formatDateTimeToBrazilianDate();
    final hour = this.hour > 9 ? this.hour.toString() : "0${this.hour}";
    final minute = this.minute > 9 ? this.minute.toString() : "0${this.minute}";

    return "$date às $hour:$minute";
  }
}
