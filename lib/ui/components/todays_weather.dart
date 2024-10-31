import 'package:flutter/material.dart';
import 'package:flutter_weather_bg_null_safety/flutter_weather_bg.dart';
import 'package:intl/intl.dart';
import 'package:weather/model/weather_model.dart';

class TodaysWeather extends StatelessWidget {
  final WeatherModel? weatherModel;
  const TodaysWeather({super.key, this.weatherModel});

  WeatherType getWeatherType(Current? current) {
    if (current?.isDay == 1) {
      if (current?.condition?.text == "Sunny") {
        return WeatherType.sunny;
      } else if (current?.condition?.text == "OverCast") {
        return WeatherType.overcast;
      } else if (current?.condition?.text == "Partly Cloudy") {
        return WeatherType.cloudy;
      } else if (current?.condition?.text == "Cloudy") {
        return WeatherType.cloudy;
      } else if (current?.condition?.text == "Mist") {
        return WeatherType.lightSnow;
      } else if (current?.condition?.text == "Clear") {
        return WeatherType.sunny;
      } else if (current!.condition!.text!.contains("thunder")) {
        return WeatherType.thunder;
      } else if (current.condition!.text!.contains("rain")) {
        return WeatherType.heavyRainy;
      } else if (current.condition!.text!.contains("showers")) {
        return WeatherType.middleSnow;
      }
    } else {
      if (current?.condition?.text == "Sunny") {
        return WeatherType.sunnyNight;
      } else if (current?.condition?.text == "OverCast") {
        return WeatherType.overcast;
      } else if (current?.condition?.text == "Partly Cloudy") {
        return WeatherType.cloudyNight;
      } else if (current?.condition?.text == "Cloudy") {
        return WeatherType.cloudyNight;
      } else if (current?.condition?.text == "Mist") {
        return WeatherType.lightSnow;
      } else if (current?.condition?.text == "Clear") {
        return WeatherType.sunnyNight;
      } else if (current!.condition!.text!.contains("thunder")) {
        return WeatherType.thunder;
      } else if (current.condition!.text!.contains("rain")) {
        return WeatherType.heavyRainy;
      } else if (current.condition!.text!.contains("showers")) {
        return WeatherType.middleSnow;
      }
    }

    return WeatherType.thunder;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        WeatherBg(
            weatherType: getWeatherType(weatherModel?.current),
            width: MediaQuery.of(context).size.width,
            height: 300),
        SizedBox(
          width: double.infinity,
          height: 300,
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white10,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    Text(
                      weatherModel?.location?.name ?? "",
                      style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    Text(
                      DateFormat.yMMMMEEEEd().format(DateTime.parse(
                          weatherModel?.current?.lastUpdated.toString() ?? "")),
                      style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    )
                  ],
                ),
              ),
              Row(
                children: [
                  const SizedBox(
                    width: 15,
                  ),
                  Container(
                      child: Image.network(
                          "https:${weatherModel?.current?.condition?.icon ?? ""}")),
                  const Spacer(),
                  Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 2.0),
                            child: Text(
                              weatherModel?.current?.tempC
                                      ?.round()
                                      .toString() ??
                                  "",
                              style: const TextStyle(
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.pink),
                            ),
                          ),
                          const Text(
                            "o",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.pink),
                          )
                        ],
                      ),
                      Text(
                        weatherModel?.current?.condition?.text ?? "",
                        style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                ],
              ),
              Container(
                margin: const EdgeInsets.all(8),
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: Colors.white10,
                    borderRadius: BorderRadius.circular(30)),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            const Text(
                              "Feels Like",
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w300),
                            ),
                            Text(
                              weatherModel?.current?.feelslikeC
                                      ?.round()
                                      .toString() ??
                                  "",
                              style: const TextStyle(
                                  fontSize: 15,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            const Text(
                              "Wind",
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w300),
                            ),
                            Text(
                              "${weatherModel?.current?.windKph?.round()} km/h",
                              style: const TextStyle(
                                  fontSize: 15,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            const Text(
                              "Humidity",
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w300),
                            ),
                            Text(
                              "${weatherModel?.current?.humidity}%",
                              style: const TextStyle(
                                  fontSize: 15,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            const Text(
                              "Visibility",
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w300),
                            ),
                            Text(
                              "${weatherModel?.current?.visKm?.round()} km",
                              style: const TextStyle(
                                  fontSize: 15,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
