import 'package:intl/intl.dart';

String dateTimeToStringFormat(String value) {
  String result;
  var inputFormat = DateFormat('yyyy-MM-ddTHH:mm:ss.zzz');
  var inputDate = inputFormat.parse(value);

  var resultFormat = DateFormat('yyyy-MM-dd HH:mm:ss');
  result = resultFormat.format(inputDate);
  return result;
}
