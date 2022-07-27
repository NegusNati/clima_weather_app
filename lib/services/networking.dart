import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkingHelper {
  NetworkingHelper(this.url);

  final String url;

  Future getData() async {
    var urlCorrect = Uri.parse(url);
    http.Response response = await http.get(urlCorrect);

    if (response.statusCode == 200) {
      var data = response.body;
      return jsonDecode(data);
    } else {
      print(response.statusCode);
    }
  }
}
