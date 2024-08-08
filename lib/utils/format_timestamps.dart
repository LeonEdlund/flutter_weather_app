import 'package:intl/intl.dart';

String formatForecastDate(int dateToConvert) {
  // helper functions
  String formatUnixToDay(int time) {
    DateTime date = DateTime.fromMillisecondsSinceEpoch(time * 1000);
    return DateFormat.EEEE().format(date);
  }

  // return formatted date
  int currentUnixDate = DateTime.now().millisecondsSinceEpoch ~/ 1000;
  String currentDate = formatUnixToDay(currentUnixDate);
  String forecastDate = formatUnixToDay(dateToConvert);
  if (currentDate == forecastDate) {
    return "Today";
  } else {
    return forecastDate;
  }
}

int formatSunsetTime(int sunsetUnix) {
  DateTime time = DateTime.fromMillisecondsSinceEpoch(sunsetUnix * 1000);
  return time.hour;
}

String formatCurrentWeatherDate(int time) {
  DateTime date = DateTime.fromMillisecondsSinceEpoch(time * 1000);
  return DateFormat.MMMMEEEEd().format(date);
}

String formatUnixToHour(int time) {
  DateTime date = DateTime.fromMillisecondsSinceEpoch(time * 1000);
  return DateFormat.Hm().format(date);
}
