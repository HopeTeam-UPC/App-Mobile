import 'package:go2climb/models/activity.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class activitiesApi{

  static Future<List<Activity>> fetchActivitiesById(String id) async{
    var param = id;
    var url = 'https://go2climbmobile.herokuapp.com/api/v1/services/$param/activities';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final body = response.body;
    final json = jsonDecode(body);
    final results = json as List<dynamic>;
    final transformed = results.map((e) {
      return Activity(
          id: e['_id'],
          name: e['name'],
          description: e['description'],
          service_id: e['service_id']);

    }).toList();
    return transformed;
  }

}