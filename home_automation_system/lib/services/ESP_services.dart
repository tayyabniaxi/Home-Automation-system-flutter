import 'package:http/http.dart' as http;

class ESPServices {
  //this method used to turn on the led
  void turnOnLed(String pinNo) async {
    await http.get(Uri.parse('http://192.168.117.61/on/${pinNo}'));
  }

  //this method used to turn off the led
  void turnOffLed(String pinNo) async {
    await http.get(Uri.parse('http://192.168.117.61/off/${pinNo}'));
  }

  //retrive temperature
  Future<String> fetchTemperature() async {
    final Uri uri = Uri.parse('http://192.168.117.61/temp');
    final response = await http.get(uri);
    var temp = '0';
    if (response.statusCode == 200) {
      // Parse and use the response data
      temp = response.body.toString();
      return temp;
    } else {
      return temp;
    }
  }
}
