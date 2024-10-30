import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather/model/weatherModel.dart';

class FutureForecastListItem extends StatelessWidget {
  final Forecastday? forecastday;
  const FutureForecastListItem({super.key, this.forecastday});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white24,
        borderRadius: BorderRadius.circular(20),
      ),
      padding: EdgeInsets.symmetric(vertical: 8),
      margin: EdgeInsets.all(8),
      width: double.infinity,
      child: Row(
        children: [
          Image.network(forecastday?.day?.condition?.icon ?? ""),
          Expanded(
            child: Text(
              DateFormat.MMMEd()
                  .format(DateTime.parse(forecastday?.date.toString() ?? "")),
              style: TextStyle(color: Colors.white),
            ),
          ),
          Expanded(
            child: Text(
              forecastday?.day?.condition?.text.toString() ?? "",
              style: TextStyle(color: Colors.white),
            ),
          ),
          Expanded(
            child: Text(
              "^${forecastday?.day?.maxtempC?.round()}/${forecastday?.day?.mintempC?.round()}",
              style: TextStyle(color: Colors.white, fontSize: 15),
            ),
          ),
        ],
      ),
    );
  }
}
