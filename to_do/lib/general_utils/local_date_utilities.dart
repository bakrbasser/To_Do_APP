import 'package:intl/intl.dart';

class LocalDateUtilities {
  static formattedDate(DateTime date) {
    return DateFormat('yyyy-MM-dd').format(date);
  }
}
