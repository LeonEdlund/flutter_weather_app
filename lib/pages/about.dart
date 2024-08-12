import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 40.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "THE WEATHER APP",
              style: TextStyle(fontSize: 32),
            ),
            SizedBox(height: 10),
            Text(
              "This is a simple weather app made with flutter and openWeatherMap API for the course 1DV535 at Linnaeus University.",
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Text(
              "Made by Leon Edlund",
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
