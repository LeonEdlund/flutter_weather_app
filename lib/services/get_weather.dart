import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'package:weather_app_u3/const.dart';
import 'package:weather_app_u3/models/weather_models.dart';

class GetWeather {
  Future<CurrentWeather> getCurrentWeather(Position location) async {
    final response = await http.get(
      Uri.https(
        "api.openweathermap.org",
        "/data/2.5/weather",
        {
          "lat": location.latitude.toString(),
          "lon": location.longitude.toString(),
          "appid": API_KEY,
          "units": "metric",
        },
      ),
    );

    if (response.statusCode == 200) {
      return CurrentWeather.fromJson(json.decode(response.body));
    } else {
      throw Exception("error getting weather information...");
    }
  }

  Future<List<Forecast>> getForecast(Position location) async {
    final response = await http.get(
      Uri.https(
        "api.openweathermap.org",
        "/data/2.5/forecast",
        {
          "lat": location.latitude.toString(),
          "lon": location.longitude.toString(),
          "appid": API_KEY,
          "units": "metric",
        },
      ),
    );

    if (response.statusCode == 200) {
      List<Forecast> forecasts = [];
      var jsonData = jsonDecode(response.body);
      for (var eachForecast in jsonData["list"]) {
        forecasts.add(Forecast.fromJson(eachForecast));
      }
      return forecasts;
    } else {
      throw Exception("error getting weather information...");
    }
  }
}
