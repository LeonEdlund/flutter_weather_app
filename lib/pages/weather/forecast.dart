import 'package:flutter/material.dart';

class ForecastPage extends StatelessWidget {
  final Map? forecasts;

  const ForecastPage({super.key, required this.forecasts});

  @override
  Widget build(BuildContext context) {
    if (forecasts!.isEmpty) {
      return const Center(
        child: Text("No forecast available!"),
      );
    }

    return ListView.builder(
      itemCount: forecasts!.length,
      itemBuilder: (BuildContext context, int index) {
        String day = forecasts!.keys.elementAt(index);
        List dayForecasts = forecasts![day]!;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            dayOfForecast(day),
            ...dayForecasts.map((forecast) => forecastCard(forecast)),
          ],
        );
      },
    );
  }

  Widget dayOfForecast(String day) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10),
      child: Text(
        day,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget forecastCard(var forecast) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      color: const Color.fromARGB(44, 158, 158, 158),
      child: ListTile(
        leading: Image(
          image: NetworkImage(
            "https://openweathermap.org/img/wn/${forecast.iconCode.toString()}@2x.png",
          ),
        ),
        title: Text(
          forecast.weatherDescription,
        ),
        subtitle: Text(forecast.hour),
        trailing: Text(
          "${forecast.temp.toString()}°",
          style: const TextStyle(fontSize: 28),
        ),
      ),
    );
  }
}
