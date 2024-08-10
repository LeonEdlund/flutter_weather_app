import 'package:flutter/material.dart';

class Background {
  Color topColor;
  Color bottomColor;

  Background({
    required this.topColor,
    this.bottomColor = Colors.black,
  });
}

Background setBackground(int weatherCode, double sunset, double sunrise) {
  const Color badWeatherNight = Color.fromARGB(255, 64, 64, 64);
  const Color badWeatherDay = Colors.grey;
  const Color clearSkyNight = Color.fromARGB(255, 0, 49, 71);
  const Color clearSkyDay = Color.fromARGB(255, 2, 141, 205);
  const Color defaultColor = Colors.black;

  var now = DateTime.now();
  double rightNow = now.hour + (now.minute / 60);
  bool isNight = false;
  if (rightNow > sunset || rightNow < sunrise) {
    isNight = true;
  }

  if (weatherCode < 800 || weatherCode > 801) {
    return Background(topColor: isNight ? badWeatherNight : badWeatherDay);
  } else if (weatherCode == 800 || weatherCode == 801) {
    return Background(topColor: isNight ? clearSkyNight : clearSkyDay);
  } else {
    return Background(topColor: defaultColor);
  }
}
