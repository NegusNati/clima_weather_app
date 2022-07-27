import 'package:flutter/material.dart';
import 'package:clima_weather_app/utilities/constants.dart';
import 'package:clima_weather_app/services/weather.dart';
import 'package:clima_weather_app/screens/city_screen.dart';

// ignore: must_be_immutable
class LocationScreen extends StatefulWidget {
  LocationScreen({Key? key, this.locationWeater}) : super(key: key);
  // ignore: prefer_typing_uninitialized_variables
  var locationWeater;
  @override
  // ignore: library_private_types_in_public_api
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  late String weatherIcon;
  late int temprature;
  late String cityName;
  late String messageToUser;
  WeatherModel weatherModel = WeatherModel();
  @override
  void initState() {
    super.initState();
    print('Inside Loaction Satate');
    updateUI(widget.locationWeater);
  }

  void updateUI(dynamic dataRecived) {
    setState(() {
      if (dataRecived == null) {
        temprature = 0;
        weatherIcon = 'error';
        messageToUser = 'Unable to Get Weater data ';
        cityName = ' Your location ';
        return;
      }
      var condition = dataRecived['weather'][0]['id'];
      weatherIcon = weatherModel.getWeatherIcon(condition);
      double temp = dataRecived['main']['temp'];
      temprature = temp.toInt();
      messageToUser = weatherModel.getMessage(temprature);
      cityName = dataRecived['name'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage('images/nature.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: const BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  TextButton(
                    onPressed: () async {
                      var weatherData = await weatherModel.getLoactionWeater();
                      updateUI(weatherData);
                    },
                    child: const Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      var typedName = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return CityScreen();
                          },
                        ),
                      );
                      if (typedName != null) {
                        var weatherData =
                            await weatherModel.getCityWeather(typedName);
                        updateUI(weatherData);
                      }
                    },
                    child: const Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '$temprature°',
                      style: kTempTextStyle,
                    ),
                    Text(
                      weatherIcon,
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  '$messageToUser in $cityName!',
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
