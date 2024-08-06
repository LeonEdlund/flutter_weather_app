import 'package:flutter/material.dart';

class ForecastPage extends StatelessWidget {
  final List? forecasts;

  const ForecastPage({super.key, required this.forecasts});

  @override
  Widget build(BuildContext context) {
    if (forecasts!.isEmpty || forecasts == null) {
      return const Center(
        child: Text("No forecast available!"),
      );
    }
    return ListView.builder(
      itemCount: forecasts!.length,
      itemBuilder: (BuildContext context, int index) {
        var forecast = forecasts![index];
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
          color: const Color.fromARGB(44, 158, 158, 158),
          child: ListTile(
            leading: Image(
              image: NetworkImage(
                "https://openweathermap.org/img/wn/${forecast.iconCode.toString()}@2x.png",
              ),
            ),
            title: Text(forecast.timeStamp),
            subtitle: Text(forecast.weatherDescription),
            trailing: Text(
              "${forecast.temp.toString()}°",
              style: const TextStyle(fontSize: 28),
            ),
          ),
        );
      },
    );
  }
}
