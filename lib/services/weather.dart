import 'dart:convert';
import 'package:go2climb/models/weather.dart';
import 'package:http/http.dart' as http;

class weatherApi{
  static Future<dynamic> fetchbyId(String city) async{
    final headers = {"X-RapidAPI-Key": "ba2c5a93acmsha268520418ea628p17348cjsne1629d772df0",
    "X-RapidAPI-Host": "open-weather13.p.rapidapi.com"};
    var url = 'https://open-weather13.p.rapidapi.com/city/$city';
    final uri = Uri.parse(url);
    final response = await http.get(uri,headers: headers);
    final body = response.body;
    final json = jsonDecode(body);
    final transformed = weatherData.fromJson(json);
    return transformed;
  }
}