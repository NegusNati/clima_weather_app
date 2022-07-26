import 'package:clima_weather_app/services/location.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';


class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLocation();
  }
  void getLocation() async {
  Location locationObj = Location();
 await locationObj.getCurrentLocation();
  print( locationObj.latitude);
  print(locationObj.longtiude );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
           
          },
          child: Text('Get Location'),
        ),
      ),
    );
  }
}
