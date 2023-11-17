import 'package:intl/intl.dart';

String formatDateInLanguageDynamic(String dateString) {
  String date = DateFormat().format(DateTime.parse(dateString).toLocal());
  if(date == DateFormat().format(DateTime.now().toLocal())) {
    String todayDate = "Today, ${DateFormat.jm().format(DateTime.parse(dateString).toLocal())}";
    return todayDate;
  } else if(date == DateFormat().format(DateTime.now().subtract(const Duration(days: 1)).toLocal())) {
    String yesterdayDate = "Yesterday, ${DateFormat.MMMd().format(DateTime.parse(dateString).toLocal())}";
    return yesterdayDate;
  }
  else {
    return DateFormat.yMMMEd().format(DateTime.parse(dateString).toLocal());
  }
}