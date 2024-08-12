import 'package:flutter/material.dart';
import 'package:page_view_dot_indicator/page_view_dot_indicator.dart';
import 'package:geolocator/geolocator.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:permission_handler/permission_handler.dart';
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
  // Weather data
  CurrentWeather? currentWeather;
  Map? forecast;

  // useful variables
  bool isLoading = true;
  bool somethingFailed = false;
  String? errorMessage;

  // used for page view dots
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
      // check internet connection
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

      setState(() {
        somethingFailed = false;
        selectedPage = 0;
        currentWeather = weatherResults[0];
        forecast = weatherResults[1];
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        currentWeather = null;
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
                  ? _errorPopUp()
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
    Background backgroundColors = setBackground(
      currentWeather?.weatherCode,
      currentWeather?.sunset,
      currentWeather?.sunrise,
    );

    return BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          backgroundColors.topColor,
          backgroundColors.bottomColor,
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

  Widget _errorPopUp() {
    bool locationError = errorMessage == "Location permission is disabled...";

    return AlertDialog(
      icon: const Icon(Icons.error),
      content: Text(
        errorMessage ?? "something went wrong",
        textAlign: TextAlign.center,
      ),
      contentTextStyle: const TextStyle(fontSize: 15),
      actions: [
        TextButton(onPressed: _reloadPage, child: const Text("Try Again")),
        locationError
            ? const TextButton(
                onPressed: openAppSettings,
                child: Text("Open settings"),
              )
            : const SizedBox()
      ],
      actionsAlignment: MainAxisAlignment.center,
    );
  }
}
