import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:weather_forcaste/model/weather_forecast_model.dart';
import 'package:weather_forcaste/network/network.dart';
import 'package:intl/intl.dart';
import 'package:weather_forcaste/ui/bottom_view.dart';
import 'package:weather_forcaste/ui/convert_icon.dart';

class WeatherForecast extends StatefulWidget {
  const WeatherForecast({Key? key}) : super(key: key);

  @override
  _WeatherForecastState createState() => _WeatherForecastState();
}

class _WeatherForecastState extends State<WeatherForecast> {
  late Future<WeatherForecastModel> forecastObj;
  String _cityname = "Mumbai";
  DateFormat format = DateFormat("yMd");

  @override
  void initState() {
    super.initState();
    forecastObj = Network().getWeatherForecast(city_name: _cityname);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: ListView(
            children: [
              textFieldView(),
              FutureBuilder(
                builder:
                    (context, AsyncSnapshot<WeatherForecastModel> snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Text(
                                '${snapshot.data!.city!.name} , ${snapshot.data!.city!.country}',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16)),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: Text(
                                format.format(
                                    DateTime.fromMillisecondsSinceEpoch(
                                        (snapshot.data!.list![0].dt! * 1000)
                                            .toInt())),
                                style: const TextStyle(fontSize: 16)),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: getWeatherIcon(
                                weatherDesc: snapshot
                                    .data!.list![0].weather![0].main
                                    .toString(),
                                color: Colors.blue,
                                size: 150),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                  "${snapshot.data!.list![0].temp!.day!.toStringAsFixed(0)} °F   ",
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700)),
                              Text(
                                  snapshot
                                      .data!.list![0].weather![0].description!
                                      .toUpperCase(),
                                  style: const TextStyle(fontSize: 16)),
                            ],
                          ),
                          Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0, vertical: 16.0),
                              child: Card(
                                color: Colors.grey.shade400,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                              "${snapshot.data!.list![0].speed!.toStringAsFixed(1)} mi/h",
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16)),
                                          const Padding(
                                            padding: EdgeInsets.all(6.0),
                                            child: Icon(
                                              FontAwesomeIcons.wind,
                                              size: 25,
                                              color: Colors.blue,
                                            ),
                                          )
                                        ],
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                              "${snapshot.data!.list![0].humidity!.toStringAsFixed(1)} %",
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16)),
                                          const Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Icon(
                                              FontAwesomeIcons
                                                  .solidGrinBeamSweat,
                                              size: 25,
                                              color: Colors.pink,
                                            ),
                                          )
                                        ],
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                              "${snapshot.data!.list![0].temp!.max.toString()} °F ",
                                              style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold)),
                                          const Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Icon(
                                              FontAwesomeIcons.temperatureHigh,
                                              size: 25,
                                              color: Colors.amber,
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              )),
                          bottomView(snapshot, context),
                        ]);
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
                future: forecastObj,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget textFieldView() {
    return TextField(
        decoration: InputDecoration(
          hintText: "Enter City Name",
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          contentPadding: const EdgeInsets.all(8),
        ),
        onSubmitted: (v) {
          setState(() {
            _cityname = v;
            forecastObj = Network().getWeatherForecast(city_name: _cityname);
          });
        });
  }
}
