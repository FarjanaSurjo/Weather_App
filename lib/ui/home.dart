import 'package:flutter/material.dart';
import 'package:weather/model/weatherModel.dart';
import 'package:weather/service/apiService.dart';
import 'package:weather/ui/components/future_forecast_listitem.dart';
import 'package:weather/ui/components/hourly_weather_listitem.dart';
import 'package:weather/ui/components/todays_weather.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Apiservice apiservice = Apiservice();

  final _textFieldController = TextEditingController();
  String searchText = "auto:ip";

  _showTextInputDialog(BuildContext, context) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Search Location"),
          content: TextField(
            controller: _textFieldController,
            decoration:
                InputDecoration(hintText: "Search by city, zip, lat, lang"),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                if (_textFieldController.text.isEmpty) {
                  return;
                }
                Navigator.pop(context, _textFieldController.text);
              },
              child: Text("Ok"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("My Weather App"),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        actions: [
          IconButton(
            onPressed: () async {
              _textFieldController.clear();
              String text = await _showTextInputDialog(BuildContext, context);
              setState(() {
                searchText = text;
              });
            },
            icon: Icon(Icons.search),
          ),
          IconButton(
            onPressed: () {
              searchText = "auto:ip";
              setState(() {});
            },
            icon: Icon(Icons.my_location),
          ),
        ],
      ),
      body: SafeArea(
          child: FutureBuilder(
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            WeatherModel? weatherModel = snapshot.data;
            return SizedBox(
              width: double.infinity,
              child: Column(
                children: [
                  TodaysWeather(
                    weatherModel: weatherModel,
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    "Weather by hour",
                    style: TextStyle(fontSize: 15, color: Colors.white),
                  ),
                  const SizedBox(height: 5),
                  SizedBox(
                    height: 120,
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        Hour? hour = weatherModel
                            ?.forecast?.forecastday?[0].hour?[index];
                        return HourlyWeatherListitem(
                          hour: hour,
                        );
                      },
                      itemCount:
                          weatherModel?.forecast?.forecastday?[0].hour?.length,
                      scrollDirection: Axis.horizontal,
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    "Next 3 Days Weather",
                    style: TextStyle(fontSize: 15, color: Colors.white),
                  ),
                  const SizedBox(height: 5),
                  Expanded(
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        Forecastday? forecastday =
                            weatherModel?.forecast?.forecastday?[index];
                        return FutureForecastListItem(
                          forecastday: forecastday,
                        );
                      },
                      itemCount: weatherModel?.forecast?.forecastday?.length,
                    ),
                  )
                ],
              ),
            );
          }
          if (snapshot.hasError) {
            return const Center(
              child: Text("Error has occured"),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
        future: apiservice.getWeatherData(searchText),
      )),
    );
  }
}
