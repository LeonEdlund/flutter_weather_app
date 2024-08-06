import 'package:flutter/material.dart';
import 'package:page_view_dot_indicator/page_view_dot_indicator.dart';
import 'package:geolocator/geolocator.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:weather_app_u3/models/weather_models.dart';
import 'package:weather_app_u3/pages/weather/current.dart';
import 'package:weather_app_u3/pages/weather/forecast.dart';
import 'package:weather_app_u3/services/set_background.dart';
import 'package:weather_app_u3/services/get_weather.dart';
import 'package:weather_app_u3/services/get_user_location.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  CurrentWeather? currentWeather;
  List? forecast;
  Background? backgroundColors;
  bool isLoading = true;
  bool somethingFailed = false;
  String? errorMessage;

  // for page view dots
  late int selectedPage;
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    selectedPage = 0;
    _pageController = PageController(initialPage: selectedPage);
    _getWeatherData();
  }

  void _reloadPage() {
    setState(() {
      isLoading = true;
    });
    _getWeatherData();
  }

  void _changePageIndex(int page) {
    setState(() {
      selectedPage = page;
    });
  }

  Future _getWeatherData() async {
    try {
      // check internat connection
      final List<ConnectivityResult> connectivityResult =
          await (Connectivity().checkConnectivity());
      if (connectivityResult.contains(ConnectivityResult.none)) {
        throw Exception("no internet access...");
      }
      // Get users position
      Position position = await getUserLocation();

      // Get weather data
      List weatherResults = await Future.wait([
        GetWeather().getCurrentWeather(position),
        GetWeather().getForecast(position),
      ]);
      CurrentWeather currentWeatherData = weatherResults[0];
      List forecastData = weatherResults[1];

      // Set app background based on weather
      Background backgroundColor =
          setBackground(currentWeatherData.weatherCode);

      setState(() {
        somethingFailed = false;
        selectedPage = 0;
        currentWeather = currentWeatherData;
        forecast = forecastData;
        backgroundColors = backgroundColor;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        errorMessage = e.toString().replaceAll("Exception: ", "");
        somethingFailed = true;
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    const pageCount = 2;

    return Container(
      decoration: _backgroundGradient(),
      child: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SafeArea(
              child: somethingFailed
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            errorMessage ?? "something failed...",
                            style: const TextStyle(fontSize: 18),
                          ),
                          IconButton(
                            onPressed: _reloadPage,
                            icon: const Icon(
                              Icons.refresh,
                              size: 42,
                            ),
                          )
                        ],
                      ),
                    )
                  : Column(
                      children: [
                        _currentLocation(),
                        Expanded(
                          child: PageView(
                            controller: _pageController,
                            onPageChanged: (page) => _changePageIndex(page),
                            children: [
                              CurrentWeatherPage(weatherData: currentWeather),
                              ForecastPage(forecasts: forecast)
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: PageViewDotIndicator(
                              currentItem: selectedPage,
                              count: pageCount,
                              unselectedColor: Colors.blueGrey,
                              selectedColor: Colors.white),
                        )
                      ],
                    ),
            ),
    );
  }

  BoxDecoration _backgroundGradient() {
    return BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          backgroundColors?.topColor ?? Colors.black,
          backgroundColors?.bottomColor ?? Colors.black
        ],
      ),
    );
  }

  Widget _currentLocation() {
    return AppBar(
      backgroundColor: Colors.transparent,
      leading: const SizedBox(width: 48),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.location_on),
          const SizedBox(width: 5),
          Text(
            "${currentWeather?.name}, ${currentWeather?.country}",
            style: const TextStyle(fontSize: 18),
          ),
        ],
      ),
      actions: [
        IconButton(
          onPressed: _reloadPage,
          icon: const Icon(Icons.refresh),
        )
      ],
    );
  }
}
