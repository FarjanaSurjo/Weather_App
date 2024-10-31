import 'dart:convert';

import 'package:http/http.dart';
import 'package:weather/constants/contants.dart';
import 'package:weather/model/weather_model.dart';

class Apiservice {
  Future<WeatherModel> getWeatherData(String searchText) async {
    String url = "$baseUrl&q=$searchText&days=7";

    try {
      Response response = await get(Uri.parse(url));
      if (response.statusCode == 200) {
        Map<String, dynamic> json = jsonDecode(response.body);
        WeatherModel weatherModel = WeatherModel.fromJson(json);
        return weatherModel;
      } else {
        throw ("No data found");
      }
    } catch (e) {
      throw e.toString();
    }
  }
}
