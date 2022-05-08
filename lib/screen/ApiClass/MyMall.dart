import 'package:flutter/cupertino.dart';

class MyMall {
  @required
  int mall_id;
  @required
  String mall_name;
  @required
  String icon;
  @required
  String link_app;
  @required
  String city;

  MyMall(
      {required this.mall_id,
      required this.mall_name,
      required this.icon,
      required this.link_app,
      required this.city});

  factory MyMall.fromMap(Map<String, dynamic> e) {
    return MyMall(
        mall_id: e["mall_id"].hashCode, mall_name: e["name"], icon: e["icon"] ,city:e["city"] ,link_app: e["link_app"]);
  }
}
