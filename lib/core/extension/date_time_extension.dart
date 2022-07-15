import 'package:intl/intl.dart';

extension DateTimeX on DateTime {
  String toFormat() {
    return DateFormat('kk:mm dd-MM-yyyy').format(this);
  }
}
