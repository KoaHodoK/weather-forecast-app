import 'package:flutter/material.dart';
import 'package:weather_forcaste/model/weather_forecast_model.dart';
import 'package:weather_forcaste/network/network.dart';

class WeatherForecast extends StatefulWidget {
  const WeatherForecast({Key? key}) : super(key: key);

  @override
  _WeatherForecastState createState() => _WeatherForecastState();
}

class _WeatherForecastState extends State<WeatherForecast> {
  late Future<WeatherForecastModel> forecastObj;
  String _cityname = "Mumbai";
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
              Container(
                  child: FutureBuilder<WeatherForecastModel>(
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                              '${snapshot.data!.city!.name} , ${snapshot.data!.city!.country}',
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16))
                        ]);
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
                future: forecastObj,
              ))
            ],
          ),
        ),
      ),
    );
  }

  Widget textFieldView() {
    return Container(
      child: TextField(
          decoration: InputDecoration(
            hintText: "Enter City Name",
            prefixIcon: const Icon(Icons.search),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            contentPadding: const EdgeInsets.all(8),
          ),
          onSubmitted: (v) {
            setState(() {
              _cityname = v;
              forecastObj =
                  new Network().getWeatherForecast(city_name: _cityname);
            });
          }),
    );
  }
}
