import 'package:intl/intl.dart';

String formatForecastDate(int unconvertedTime, String formattedTime) {
  // helper functions
  String removeTimeFromDate(String time) {
    return time.split(" ")[0];
  }

  String formatTimeToDay(int time) {
    DateTime date = DateTime.fromMillisecondsSinceEpoch(time * 1000);
    return DateFormat.E().format(date);
  }

  String formatTimeToHour(int time) {
    DateTime date = DateTime.fromMillisecondsSinceEpoch(time * 1000);
    return DateFormat.Hm().format(date);
  }

  // return formatted date
  String currentDate = removeTimeFromDate(DateTime.now().toString());
  String forecastDate = removeTimeFromDate(formattedTime);
  if (currentDate == forecastDate) {
    return "Today, ${formatTimeToHour(unconvertedTime)}";
  } else {
    return "${formatTimeToDay(unconvertedTime)}, ${formatTimeToHour(unconvertedTime)}";
  }
}
