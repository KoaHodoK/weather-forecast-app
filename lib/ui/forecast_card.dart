import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_forcaste/model/weather_forecast_model.dart';
import 'package:weather_forcaste/ui/convert_icon.dart';

Widget forecastCard(AsyncSnapshot<WeatherForecastModel> snapshot, int index) {
  var forecastlist = snapshot.data!.list;
  var fullDate = DateFormat("EEEE, MMM d, y").format(
      DateTime.fromMillisecondsSinceEpoch(
          (forecastlist![index].dt! * 1000).toInt()));
  var dayOfWeek = fullDate.split(",")[0];
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Center(
          child: Text(dayOfWeek.toString(),
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.w600))),
      getWeatherIcon(
          weatherDesc: forecastlist[index].weather![0].main.toString(),
          color: Colors.white,
          size: 35),
      Text("Max :${forecastlist[index].temp!.max!.toStringAsFixed(0)} °F"),
      Text("Min :${forecastlist[index].temp!.min!.toStringAsFixed(0)} °F"),
      Text("Hum :${forecastlist[index].humidity.toString} %"),
      Text("Wind :${forecastlist[index].speed} min/h")
    ],
  );
}
