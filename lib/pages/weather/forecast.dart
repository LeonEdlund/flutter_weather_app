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
    return ListView.separated(
      itemCount: forecasts!.length,
      separatorBuilder: (context, index) => const Divider(),
      itemBuilder: (BuildContext context, int index) {
        var forecast = forecasts![index];
        return ListTile(
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
        );
      },
    );
  }
}
