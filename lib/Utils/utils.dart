import 'package:intl/intl.dart';

extension DateTimeUtils on DateTime {
  String get datetimeiniformantString =>
      DateFormat('y/M/d 00:00:00').format(this);
  String get datetimeformantString => DateFormat('dd/M/y').format(this);
  String get dateformantString => DateFormat('yyyy/MM/dd').format(this);
  String get datetimefinformantString =>
      DateFormat('y/M/d HH:mm:ss').format(this);
}
