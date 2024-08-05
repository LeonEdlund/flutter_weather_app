class CurrentWeather {
  final String name;
  final String country;
  final int temp;
  final int? windSpeed;
  final int? clouds;
  final String iconCode;
  final int weatherCode;
  final String weatherDescription;
  final int timeStamp;

  CurrentWeather({
    required this.name,
    required this.country,
    required this.temp,
    required this.windSpeed,
    required this.clouds,
    required this.iconCode,
    required this.weatherCode,
    required this.weatherDescription,
    required this.timeStamp,
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
      weatherDescription: json["weather"][0]["description"],
      timeStamp: json["dt"],
    );
  }
}

class Forecast {
  final int temp;
  final String iconCode;
  final String weatherDescription;
  final String timeStamp;

  Forecast({
    required this.temp,
    required this.iconCode,
    required this.weatherDescription,
    required this.timeStamp,
  });

  factory Forecast.fromJson(Map<String, dynamic> json) {
    return Forecast(
      temp: json["main"]["temp"].round(),
      iconCode: json["weather"][0]["icon"],
      weatherDescription: json["weather"][0]["description"],
      timeStamp: json["dt_txt"],
    );
  }
}
