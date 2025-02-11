import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:weather/model/weather_model.dart';

class HourlyWeatherListitem extends StatelessWidget {
  final Hour? hour;
  const HourlyWeatherListitem({
    super.key,
    this.hour,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(8),
      width: 80,
      decoration: BoxDecoration(
          color: Colors.white24, borderRadius: BorderRadius.circular(20)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  hour?.tempC?.round().toString() ?? "",
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 13),
                ),
              ),
              const Text(
                "o",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ],
          ),
          Container(
            height: 30,
            decoration:
                const BoxDecoration(shape: BoxShape.circle, color: Colors.teal),
            child: Image.network(hour?.condition?.icon.toString() ?? ""),
          ),
          Text(
            DateFormat.j().format(DateTime.parse(
              hour?.time?.toString() ?? "",
            )),
            style: const TextStyle(color: Colors.white),
          )
        ],
      ),
    );
  }
}
