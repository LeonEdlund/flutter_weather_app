import 'package:flutter/material.dart';
import 'package:weather_app_u3/utils/format_timestamps.dart';

class Background {
  Color topColor;
  Color bottomColor;

  Background({
    required this.topColor,
    this.bottomColor = Colors.black,
  });
}

Background setBackground(int weatherCode, int sunset) {
  const Color badWeatherNight = Color.fromARGB(255, 64, 64, 64);
  const Color badWeatherDay = Colors.grey;
  const Color clearSkyNight = Color.fromARGB(255, 2, 79, 115);
  const Color clearSkyDay = Color.fromARGB(255, 2, 141, 205);
  const Color defaultColor = Colors.black;

  var now = DateTime.now();
  int timeOfSunset = formatSunsetTime(sunset);
  bool isNight = now.hour >= timeOfSunset;

  if (weatherCode < 800 || weatherCode == 803 || weatherCode == 804) {
    return Background(topColor: isNight ? badWeatherNight : badWeatherDay);
  } else if (weatherCode >= 800 && weatherCode <= 802) {
    return Background(topColor: isNight ? clearSkyNight : clearSkyDay);
  } else {
    return Background(topColor: defaultColor);
  }
}
