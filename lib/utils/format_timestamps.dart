import 'package:intl/intl.dart';

String formatForecastDate(int dateToConvert) {
  int currentUnixDate = DateTime.now().millisecondsSinceEpoch ~/ 1000;
  String currentDay = formatUnixToDay(currentUnixDate);
  String forecastDay = formatUnixToDay(dateToConvert);

  if (currentDay == forecastDay) {
    return "Today";
  } else {
    return forecastDay;
  }
}

// converts unixTimestamp to "Weekday, Month, day(number)"
String formatCurrentWeatherDate(int time) {
  DateTime date = DateTime.fromMillisecondsSinceEpoch(time * 1000);
  return DateFormat.MMMMEEEEd().format(date);
}

// returns day day in written form ex. friday
String formatUnixToDay(int time) {
  DateTime date = DateTime.fromMillisecondsSinceEpoch(time * 1000);
  return DateFormat.EEEE().format(date);
}

// converts unixTimestamp to time in double format ex 20.30 == 20.5
double formatUnixToDouble(int sunsetUnix) {
  DateTime time = DateTime.fromMillisecondsSinceEpoch(sunsetUnix * 1000);
  return time.hour + (time.minute / 60);
}

// returns hour and minute ex. 20:50
String formatUnixToHour(int time) {
  DateTime date = DateTime.fromMillisecondsSinceEpoch(time * 1000);
  return DateFormat.Hm().format(date);
}
