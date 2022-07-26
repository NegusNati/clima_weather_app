import 'package:clima_weather_app/services/location.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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
    print(locationObj.latitude);
    print(locationObj.longtiude);
  }

  var url = Uri.parse(
      'https://api.openweathermap.org/data/2.5/weather?lat=35&lon=139&appid=be2f2d133df4c10e749cc9944f6cc5dd');
  void getData() async {
    http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      print(response.body);
    } else {
      print(response.statusCode);
    }
  }

  @override
  Widget build(BuildContext context) {
    getData();
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {},
          child: Text('Get Location'),
        ),
      ),
    );
  }
}
