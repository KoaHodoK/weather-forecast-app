import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

Widget getWeatherIcon(
    {required String weatherDesc, required Color color, required double size}) {
  switch (weatherDesc) {
    case "Clear":
      {
        return Icon(
          FontAwesomeIcons.sun,
          color: color,
          size: size,
        );
      }
    case "Cloud":
      {
        return Icon(
          FontAwesomeIcons.cloud,
          color: color,
          size: size,
        );
      }
    case "Rain":
      {
        return Icon(
          FontAwesomeIcons.cloudRain,
          color: color,
          size: size,
        );
      }
    case "Snow":
      {
        return Icon(
          FontAwesomeIcons.snowman,
          color: color,
          size: size,
        );
      }
    default:
      {
        return Icon(
          FontAwesomeIcons.sun,
          color: color,
          size: size,
        );
      }
  }
}
