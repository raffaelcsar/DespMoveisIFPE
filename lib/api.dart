import 'package:http/http.dart' as http;

const baseUrl =
    "https://raw.githubusercontent.com/humbertobeltrao/web-practice/master";

class API {
  static Future getPets() async {
    var url = baseUrl + "/ajax-pets.json";
    return await http.get(url);
  }
}
