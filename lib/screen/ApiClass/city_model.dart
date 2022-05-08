import 'package:flutter/cupertino.dart';

class CityModel {
  @required
  String city_id;
  @required
  String city_name;


  CityModel(
      {required this.city_id, required this.city_name});

  factory CityModel.fromMap(Map<String, dynamic> e) {
    return CityModel(
        city_id: e["city_id"], city_name: e["city_name"]);
  }
}