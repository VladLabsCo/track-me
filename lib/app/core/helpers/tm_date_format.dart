import 'package:intl/intl.dart';

String tmDateFormat(DateTime date) {
  return DateFormat('dd/MM/yyyy').format(date);
}
