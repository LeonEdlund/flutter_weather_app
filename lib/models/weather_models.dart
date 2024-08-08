import 'package:weather_app_u3/utils/format_timestamps.dart';

class CurrentWeather {
  final String name;
  final String country;
  final int temp;
  final int? windSpeed;
  final int? clouds;
  final String iconCode;
  final int weatherCode;
  final int sunset;
  final String weatherDescription;
  final String date;

  CurrentWeather({
    required this.name,
    required this.country,
    required this.temp,
    required this.windSpeed,
    required this.clouds,
    required this.iconCode,
    required this.weatherCode,
    required this.sunset,
    required this.weatherDescription,
    required this.date,
  });

  factory CurrentWeather.fromJson(Map<String, dynamic> json) {
    return CurrentWeather(
      name: json["name"],
      country: json["sys"]["country"],
      temp: json["main"]["temp"].round(),
      windSpeed: json["wind"]?["speed"]?.round(),
      clouds: json["clouds"]?["all"]?.toInt(),
      iconCode: json["weather"][0]["icon"],
      weatherCode: json["weather"][0]["id"],
      sunset: json["sys"]["sunset"],
      weatherDescription: json["weather"][0]["description"],
      date: formatCurrentWeatherDate(json["dt"]),
    );
  }
}

class Forecast {
  final int temp;
  final String iconCode;
  final String weatherDescription;
  final String day;
  final String hour;

  Forecast(
      {required this.temp,
      required this.iconCode,
      required this.weatherDescription,
      required this.day,
      required this.hour});

  factory Forecast.fromJson(Map<String, dynamic> json) {
    return Forecast(
        temp: json["main"]["temp"].round(),
        iconCode: json["weather"][0]["icon"],
        weatherDescription: json["weather"][0]["description"],
        day: formatForecastDate(json["dt"]),
        hour: formatUnixToHour(json["dt"]));
  }
}
