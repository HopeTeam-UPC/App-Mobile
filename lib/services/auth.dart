import 'package:go2climb/models/authModel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class authService{

  static Future<dynamic> loginTourist(dynamic creds) async{
    final headers = {"Content-type": "application/json"};
    const url = 'https://go2climbmobile.herokuapp.com/api/v1/auth/customers/login';
    final uri = Uri.parse(url);
    final json = jsonEncode(creds);
    final response = await http.post(uri,headers: headers,body: json);
    return response;
  }

  static Future<dynamic> loginAgency(dynamic creds) async{
    final headers = {"Content-type": "application/json"};
    const url = 'https://go2climbmobile.herokuapp.com/api/v1/auth/agencies/login';
    final uri = Uri.parse(url);
    final json = jsonEncode(creds);
    print(json);
    final response = await http.post(uri,headers: headers,body: json);
    return response;
  }

  static Future<int> postAgency(dynamic data) async{
    final headers = {"Content-type": "application/json"};
    const url = 'https://go2climbmobile.herokuapp.com/api/v1/auth/agencies/register';
    final uri = Uri.parse(url);
    final json = data;
    final response = await http.post(uri,headers: headers,body: json);
    return response.statusCode;
    }

  static Future<int> postTourist(dynamic data) async{
    final headers = {"Content-type": "application/json"};
    const url = 'https://go2climbmobile.herokuapp.com/api/v1/auth/customers/register';
    final uri = Uri.parse(url);
    final json = data;
    final response = await http.post(uri,headers: headers,body: json);
    return response.statusCode;
  }

  }