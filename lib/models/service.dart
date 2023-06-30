import 'dart:ffi';

import 'package:flutter/foundation.dart';

//este de aca es solo para get services
class Services{
  final String id;
  final String name;
  final int price;
  final String location;
  final String img_url;
  final String description;
  final int score;
  final AgencyDetails agency;


  Services({
    required this.id,
    required this.name,
    required this.price,
    required this.location,
    required this.img_url,
    required this.description,
    required this.score,
    required this.agency
  });

  factory Services.fromJson(Map<String, dynamic> e){
    return Services(
        id: e['_id'],
        name: e['name'],
        price: e['price'],
        location: e['location'],
        img_url: e['img_url'],
        description: e['description'],
        score: e['score'],
        agency: AgencyDetails.fromJson(e['agency_id']));
  }

}

//este de aca solo es para get
class AgencyDetails{
  final String id;
  final int score;
  final String name;
  final String email;
  final String description;
  final String location;
  final String phoneNumber;
  final String img_url;
  final String type_user;

  AgencyDetails({
    required this.id,
    required this.score,
    required this.name,
    required this.email,
    required this.description,
    required this.location,
    required this.phoneNumber,
    required this.img_url,
    required this.type_user
  });

  factory AgencyDetails.fromJson(Map<String, dynamic> json){
    return AgencyDetails(
        id: json['_id'],
        score: json['score'],
        name: json['name'],
        email: json['email'],
        description: json['description'],
        location: json['location'],
        phoneNumber: json['phoneNumber'],
        img_url: json['img_url'],
        type_user: json['type_user']);
  }

}