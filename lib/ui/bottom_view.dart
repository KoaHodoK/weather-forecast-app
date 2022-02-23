import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_forcaste/model/weather_forecast_model.dart';
import 'package:weather_forcaste/ui/forecast_card.dart';

Widget bottomView(
    AsyncSnapshot<WeatherForecastModel> snapshot, BuildContext context) {
  var forecastlist = snapshot.data!.list;
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Text("7-Day Weather Forecast".toUpperCase(),
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      const SizedBox(
        height: 15,
      ),
      SizedBox(
        height: 150,
        child: ListView.separated(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, i) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                  ),
                  width: MediaQuery.of(context).size.width / 2.5,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: forecastCard(snapshot, i),
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) => const SizedBox(
                  width: 3,
                ),
            itemCount: forecastlist!.length),
      )
    ],
  );
}
