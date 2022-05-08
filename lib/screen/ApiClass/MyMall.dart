import 'package:flutter/cupertino.dart';

class MyMall {
  @required
  int mall_id;
  @required
  String mall_name;
  @required
  String icon;

  MyMall(
      {required this.mall_id, required this.mall_name, required this.icon});

  factory MyMall.fromMap(Map<String, dynamic> e) {
    return MyMall(
        mall_id: e["mall_id"].hashCode, mall_name: e["name"], icon: e["icon"]);
  }
}