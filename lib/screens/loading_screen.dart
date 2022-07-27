import 'package:clima_weather_app/services/location.dart';
import 'package:flutter/material.dart';
import 'package:clima_weather_app/services/networking.dart';
import 'package:clima_weather_app/utilities/constants.dart';
import 'package:clima_weather_app/screens/location_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';



class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLocationData();
  }

  void getLocationData() async {
    Location locationObj = Location();
    await locationObj.checkGPSEnabled();
    await locationObj.getCurrentLocation();

    NetworkingHelper networkinghelper = NetworkingHelper(
        'https://api.openweathermap.org/data/2.5/weather?lat=${locationObj.latitude}&lon=${locationObj.longtiude}&appid=$apiKey&units=metric');

    var weatherData = await networkinghelper.getData();

    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return LocationScreen(locationWeater: weatherData,);
    },),);
  }

  @override
  Widget build(BuildContext context) {
    

    return Scaffold(
      body: Center(
        child: SpinKitSpinningLines(
          color: Colors.white38,
          size: 120.0,

        ),
      ),
    );
  }
}
