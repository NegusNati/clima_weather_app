import 'package:clima_weather_app/services/location.dart';
import 'package:clima_weather_app/services/networking.dart';
import 'package:clima_weather_app/utilities/constants.dart';

class WeatherModel {
  Future<dynamic> getCityWeather(String cityName) async {
    var urlCity = '$kOpenWeatherAPI?q=$cityName&appid=$kApiKey&units=metric';
    NetworkingHelper networkinghelper = NetworkingHelper(urlCity);
    var weatherData = await networkinghelper.getData();

    return weatherData;
  }

  Future<dynamic> getLoactionWeater() async {
    Location locationObj = Location();
    await locationObj.checkGPSEnabled();
    await locationObj.getCurrentLocation();

    NetworkingHelper networkinghelper = NetworkingHelper(
        '$kOpenWeatherAPI?lat=${locationObj.latitude}&lon=${locationObj.longtiude}&appid=$kApiKey&units=metric');
    var weatherData = await networkinghelper.getData();
    return weatherData;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
