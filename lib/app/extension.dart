import 'package:intl/intl.dart';

const empty = "";
const zero = 0;

extension NonNullString on String? {
  String orEmpty() {
    if (this == null) {
      return empty;
    } else {
      return this!;
    }
  }
}

extension NonNullInteger on int? {
  int orZero() {
    if (this == null) {
      return zero;
    } else {
      return this!;
    }
  }
}

extension NonNullDateTime on DateTime? {
  DateTime orNow() {
    return this ?? DateTime.now();
  }
}

extension FormatDateTime on DateTime {
  String toStringType() {
    return DateFormat('yyyy-MM-dd hh:mm:ss').format(this);
  }
}

extension FormatDateTimeString on String {
  DateTime toDateTimeType() {
    return DateFormat('yyyy-MM-dd hh:mm:ss').parse(this);
  }
}
