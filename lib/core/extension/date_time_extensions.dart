extension DateTimeExtension on DateTime {
  String formatDateTimeToBrazilianDate() {
    final day = this.day > 9 ? this.day.toString() : "0${this.day}";
    final month = this.month > 9 ? this.month.toString() : "0${this.month}";
    final year = this.year;

    return "$day/$month/$year";
  }
}
