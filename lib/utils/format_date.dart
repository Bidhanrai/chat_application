import 'package:intl/intl.dart';

String formatDateInLanguageDynamic(String dateString) {
  if(DateTime.parse(dateString).day == DateTime.now().day) {
    String todayDate = "Today, ${DateFormat.jm().format(DateTime.parse(dateString).toLocal())}";
    return todayDate;
  } else if(DateTime.parse(dateString).day == DateTime.now().subtract(const Duration(days: 1)).day) {
    String yesterdayDate = "Yesterday, ${DateFormat.MMMd().format(DateTime.parse(dateString).toLocal())}";
    return yesterdayDate;
  } else {
    return DateFormat.yMMMEd().format(DateTime.parse(dateString).toLocal());
  }
}

String formatDate(String dateString) {
  return "${DateFormat.yMMMd().format(DateTime.parse(dateString).toLocal())}, ${DateFormat.jm().format(DateTime.parse(dateString).toLocal())}";
}