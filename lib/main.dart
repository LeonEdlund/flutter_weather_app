import 'package:flutter/material.dart';
import 'package:weather_app_u3/pages/about.dart';
import 'package:weather_app_u3/pages/weather/weather_page.dart';

void main() {
  runApp(
    MaterialApp(
      title: "Weather App",
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.green,
          brightness: Brightness.dark,
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: const GlobalNavigation(),
    ),
  );
}

class GlobalNavigation extends StatefulWidget {
  const GlobalNavigation({super.key});

  @override
  State<GlobalNavigation> createState() => _GlobalNavigationState();
}

class _GlobalNavigationState extends State<GlobalNavigation> {
  int _currentIndex = 0;

  void _updateCurrentIndex(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      bottomNavigationBar: NavigationBar(
        backgroundColor: Colors.black,
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) => _updateCurrentIndex(index),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.sunny),
            label: "Weather",
          ),
          NavigationDestination(
            icon: Icon(Icons.info),
            label: "About",
          ),
        ],
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: const [
          WeatherPage(),
          AboutPage(),
        ],
      ),
    );
  }
}
