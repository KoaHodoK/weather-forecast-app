import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weather_forcaste/model/weather_forecast_model.dart';
import 'package:weather_forcaste/util/forecast_util.dart';

class Network {
  Future<WeatherForecastModel> getWeatherForecast(
      {required String city_name}) async {
    var finalURL = "https://api.openweathermap.org/data/2.5/forecast/daily?q=" +
        city_name +
        "&appid=" +
        Util.appId +
        "&units=imperial";
    final response = await http.get(Uri.parse(finalURL));
    if (response.statusCode == 200) {
      print("Weather Data: ${response.body}");
      return WeatherForecastModel.fromJson(json.decode(response.body));
    } else {
      throw Exception("Error on gettting weather forecast");
    }
  }
}
