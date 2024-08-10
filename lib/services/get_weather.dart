import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'package:weather_app_u3/const.dart';
import 'package:weather_app_u3/models/weather_models.dart';

class GetWeather {
  Future<CurrentWeather> getCurrentWeather(Position location) async {
    try {
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
    } catch (e) {
      print(e);
      throw Exception("error getting weather information...");
    }
  }

  Future<Map<String, List<Forecast>>> getForecast(Position location) async {
    try {
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
        Map<String, List<Forecast>> groupedForecasts = {};

        // create list of all forecasts
        var jsonData = jsonDecode(response.body);
        for (var eachForecast in jsonData["list"]) {
          forecasts.add(Forecast.fromJson(eachForecast));
        }

        // group forecasts based on day
        for (var forecast in forecasts) {
          String day = forecast.day;
          if (!groupedForecasts.containsKey(forecast.day)) {
            groupedForecasts[day] = [];
          }
          groupedForecasts[day]!.add(forecast);
        }
        return groupedForecasts;
      } else {
        throw Exception("error getting weather information...");
      }
    } catch (e) {
      throw Exception("error getting weather information...");
    }
  }
}
