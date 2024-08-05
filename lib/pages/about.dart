import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          AppBar(
            backgroundColor: Colors.transparent,
            title: const Text(
              "WEATHER",
              style: TextStyle(fontSize: 32),
            ),
            centerTitle: true,
          ),
          const Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "This is a simple weather app made with flutter and openWeather API",
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
        ],
      ),
    );
  }
}
