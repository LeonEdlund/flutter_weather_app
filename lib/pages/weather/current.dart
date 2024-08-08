import 'package:flutter/material.dart';
import 'package:weather_app_u3/models/weather_models.dart';
import 'package:fluttericon/meteocons_icons.dart';
import 'package:intl/intl.dart';

class CurrentWeatherPage extends StatelessWidget {
  final CurrentWeather? weatherData;

  const CurrentWeatherPage({super.key, required this.weatherData});

  @override
  Widget build(BuildContext context) {
    if (weatherData == null) {
      return const Center(
        child: Text("weather is unavailable!"),
      );
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _weatherIcon(),
        _mainWeatherInfo(),
        const SizedBox(height: 50),
        _additionalWeatherInfo(),
      ],
    );
  }

  Widget _weatherIcon() {
    return Image(
      image: NetworkImage(
        "https://openweathermap.org/img/wn/${weatherData!.iconCode}@4x.png",
        scale: 0.8,
      ),
    );
  }

  Widget _mainWeatherInfo() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          "${weatherData!.temp}°",
          style: const TextStyle(fontSize: 80, fontWeight: FontWeight.bold),
        ),
        Text(
          weatherData!.weatherDescription,
          style: const TextStyle(fontSize: 24),
        ),
        Text(weatherData!.date)
      ],
    );
  }

  Widget _additionalWeatherInfo() {
    int? windSpeed = weatherData!.windSpeed;
    int? clouds = weatherData!.clouds;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Meteocons.wind,
              size: 50,
            ),
            Text(windSpeed != null ? "$windSpeed Km/h" : "-"),
            const Text("Wind"),
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Meteocons.cloud,
              size: 50,
            ),
            Text(clouds != null ? "$clouds%" : "-"),
            const Text("clouds"),
          ],
        ),
      ],
    );
  }
}
