import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:weather_forcaste/model/weather_forecast_model.dart';
import 'package:weather_forcaste/network/network.dart';
import 'package:intl/intl.dart';
import 'package:weather_forcaste/util/convert_icon.dart';

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
    // TODO: implement initState
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
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                                '${snapshot.data!.city!.name} , ${snapshot.data!.city!.country}',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16)),
                          ),
                          Text(
                              format.format(DateTime.fromMillisecondsSinceEpoch(
                                  (snapshot.data!.list![0].dt! * 1000)
                                      .toInt())),
                              style: const TextStyle(fontSize: 16)),
                          const SizedBox(
                            height: 10,
                          ),
                          getWeatherIcon(
                              weatherDesc: snapshot
                                  .data!.list![0].weather![0].main
                                  .toString(),
                              color: Colors.blue,
                              size: 150),
                          const SizedBox(
                            height: 20,
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
                                  horizontal: 32.0, vertical: 32.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                          "${snapshot.data!.list![0].speed!.toStringAsFixed(1)} mi/h",
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16)),
                                      const Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Icon(
                                          FontAwesomeIcons.wind,
                                          size: 30,
                                          color: Colors.blue,
                                        ),
                                      )
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                          "${snapshot.data!.list![0].humidity!.toStringAsFixed(1)} %",
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16)),
                                      const Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Icon(
                                          FontAwesomeIcons.solidGrinBeamSweat,
                                          size: 30,
                                          color: Colors.pink,
                                        ),
                                      )
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
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
                                          size: 30,
                                          color: Colors.amber,
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              )),
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
